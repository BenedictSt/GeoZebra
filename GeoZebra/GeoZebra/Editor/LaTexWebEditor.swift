//
//  HTMLView.swift
//  GeoZebra
//
//  Created by Benedict on 26.12.21.
//

import SwiftUI
import WebKit

struct LaTexEditor: NSViewRepresentable {
	let data: DataModel
	let callbackHandlerName = "callbackHandler"
	var currentFunktion: UUID? = nil
	let messageHandler = MessageHandler()
	let configuration = WKWebViewConfiguration()
	let wkWebView: WKWebView
	
	init(data: DataModel){
		self.data = data
		self.wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), configuration: configuration)
	}
	
	
	class MessageHandler: NSObject, WKScriptMessageHandler {
		var dataI: DataModel? = nil
		
		func setData(data: DataModel){
			self.dataI = data
		}
		
		func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
			if message.name == "callbackHandler"{
				if let dict = message.body as? [String : AnyObject]{
					if let latex = dict["latex"] as? String{
						print("Latex: \(latex)")
						if let data = dataI{
							let parser = Parser(string: latex, dataModel: data)
							if let currentShowingFunktion = currentShowingFunktion, let _ = dataI!.funktionen[currentShowingFunktion]{
								dataI!.funktionen[currentShowingFunktion]!.latex = latex.replacingOccurrences(of: "\\", with: "\\\\")
								dataI!.funktionen[currentShowingFunktion]!.interneFunktion = parser.getFunktion().funktion
								dataI!.funktionen[currentShowingFunktion]!.schwererFehler = parser.getFunktion().fehlgeschlagen
								dataI!.funktionen[currentShowingFunktion]!.fehlerUndWarungen = parser.getFunktion().fehler
								
								if(parser.getFunktion().fehlgeschlagen){
									messagePublisher.sendeNachricht("Funktion konnte nicht analysiert werden!", farbe: .red)
								}
								funktionsEditorConfig.updateId = UUID()
								
							}
							funktionsEditorConfig.updateId = UUID()
							data.update = UUID()
						}
					}
				}
				return
			}
		}
	}
	
	func makeNSView(context: Context) -> WKWebView {
		messageHandler.setData(data: self.data)
		configuration.userContentController.add(messageHandler, name: callbackHandlerName)
		wkWebView.loadHTMLString(LaTexEditor.loadHtmlString(), baseURL: nil)
		updateLatex(wkWebView)
		return wkWebView
	}
	
	func updateNSView(_ nsView: WKWebView, context: Context) {
		if(!funktionsEditorConfig.eingabe.isEmpty){
			if let eingegebenerOperator = funktionsEditorConfig.eingabe.popLast(){
				switch(eingegebenerOperator){
				case .bruch:
					nsView.evaluateJavaScript("me.answerMathField.write('\\\\frac{}{}');", completionHandler: nil)
					nsView.evaluateJavaScript("me.answerMathField.focus();", completionHandler: nil)
					nsView.evaluateJavaScript("me.answerMathField.keystroke('Up');", completionHandler: nil)
					break
					
				case .wurzel:
					nsView.evaluateJavaScript("me.answerMathField.write('\\\\sqrt{}');", completionHandler: nil)
					nsView.evaluateJavaScript("me.answerMathField.focus();", completionHandler: nil)
					nsView.evaluateJavaScript("me.answerMathField.keystroke('Left');", completionHandler: nil)
					break
					
				case .nteWurzel:
					nsView.evaluateJavaScript("me.answerMathField.write('\\\\sqrt[{}]{}');", completionHandler: nil)
					nsView.evaluateJavaScript("me.answerMathField.focus();", completionHandler: nil)
					nsView.evaluateJavaScript("me.answerMathField.keystroke('Left');", completionHandler: nil)
					nsView.evaluateJavaScript("me.answerMathField.keystroke('Left');", completionHandler: nil)
					break
					
				case .potenz:
					nsView.evaluateJavaScript("me.answerMathField.write('\\\\^{}');", completionHandler: nil)
					nsView.evaluateJavaScript("me.answerMathField.focus();", completionHandler: nil)
					nsView.evaluateJavaScript("me.answerMathField.keystroke('Up');", completionHandler: nil)
					break
					
				case .enter:
					nsView.evaluateJavaScript("document.activeElement.blur();", completionHandler: nil)
					nsView.evaluateJavaScript("getLatexFromEditor();", completionHandler: nil)
					break
				}
			}
		}
		
		if(currentShowingFunktion != funktionsEditorConfig.funktionId){
			currentShowingFunktion = funktionsEditorConfig.funktionId
			updateLatex(nsView)
		}
	}
	
	public func updateLatex(_ view: WKWebView) {
		if let currentShowingFunktion = currentShowingFunktion{
			if(view.isLoading){
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
					updateLatex(view)
				}
			}else{
				let latex = self.data.funktionen[currentShowingFunktion]?.latex
				view.evaluateJavaScript("me.setLatex('\(latex ?? "error")');", completionHandler: nil)
			}
		}
	}
	
	private static func loadHtmlString() -> String{
		do {
			if let filepath = Bundle.main.path(forResource: "index", ofType: "html"){
				var contents = try String(contentsOfFile: filepath)
				let mqCSS = try String(contentsOfFile: Bundle.main.path(forResource: "mathquill", ofType: "css")!)
				let meCSS = try String(contentsOfFile: Bundle.main.path(forResource: "matheditor", ofType: "css")!)
				
				let mqJS = try String(contentsOfFile: Bundle.main.path(forResource: "mathquill", ofType: "js")!)
				let meJS = try String(contentsOfFile: Bundle.main.path(forResource: "matheditor", ofType: "js")!)
				let jqJS = try String(contentsOfFile: Bundle.main.path(forResource: "jquery", ofType: "js")!)
				contents = contents.replacingOccurrences(of: "mathquillStyle", with: mqCSS)
				contents = contents.replacingOccurrences(of: "matheditorStyle", with: meCSS)
				contents = contents.replacingOccurrences(of: "mathquillJS", with: mqJS)
				contents = contents.replacingOccurrences(of: "matheditorJS", with: meJS)
				contents = contents.replacingOccurrences(of: "jqueryJS", with: jqJS)
				contents = contents.replacingOccurrences(of: "borderStyleReplace", with: "1px solid gray")
				contents = contents.replacingOccurrences(of: "pointerEventType", with: "auto")
				contents = contents.replacingOccurrences(of: "colorReplace", with: "rgb(246,244,244)")
				return contents
			}
		}catch{}
		return "<html> <body>could not load </body></html>"
	}
}

fileprivate var currentShowingFunktion: UUID? = nil

func getDocumentsDirectory() -> URL {
	let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
	return paths[0]
}
