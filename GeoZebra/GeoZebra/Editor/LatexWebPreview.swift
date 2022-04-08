//
//  HTMLPreviewView.swift
//  GeoZebra
//
//  Created by Benedict on 22.01.22.
//

import SwiftUI
import WebKit

struct LatexPreview: NSViewRepresentable {
	let data: DataModel
	var currentFunktion: UUID? = nil
	var wkWebView: WKWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
	
	func makeNSView(context: Context) -> WKWebView {
		let view = wkWebView
		view.loadHTMLString(LatexPreview.loadHtmlString(), baseURL: nil)
		updateLatex(view)
		return view
	}
	
	func updateNSView(_ nsView: WKWebView, context: Context) {
		updateLatex(nsView)
	}
	
	func updateLatex(_ view: WKWebView) {
		if let currentShowingFunktion = currentFunktion{
			if(view.isLoading){
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
					updateLatex(view)
				}
			}
			else{
				view.evaluateJavaScript("me.setLatex('\(self.data.funktionen[currentShowingFunktion]?.latex ?? "error")');", completionHandler: nil)
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
				contents = contents.replacingOccurrences(of: "borderStyleReplace", with: "none")
				contents = contents.replacingOccurrences(of: "pointerEventType", with: "none")
				
				contents = contents.replacingOccurrences(of: "colorReplace", with: "rgb(236,236,236)")
				return contents
			}
		}catch{}
		return "<html> <body>could not load </body></html>"
	}
}
