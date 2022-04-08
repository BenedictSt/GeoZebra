//
//  Parser.swift
//  GeoZebra
//
//  Created by Benedict on 26.12.21.
//

import Foundation

///Parser für mathematische Ausdrücke
class Parser{
	typealias Token = Lexer.Token
	typealias ParameterNames = ParameterMaster.ParameterNames
	private let dataModel: DataModel
	
	//MARK: Konstanten für den Shunting Yard Algorithmus:
	private final let NUMBER_TOKENS: [Lexer.Tokens] = [.zahl, .x, .euler, .pi, .parameter]
	private final let FUNKTIONS_TOKENS: [Lexer.Tokens] = [.funktionsname, .sin, .cos, .tan] //Eigentlich auch ln, wurde aber zu log _ .euler vorher
	private final let OPERATOREN_TOKENS: [Lexer.Tokens] = [.plus, .minus, .mal, .geteilt, .wurzel, .bruch, .potenz, .log]
	private final let LINKE_KLAMMERN_TOKENS: [Lexer.Tokens] = [.lk, .lgk, .lek]
	private final let RECHTE_KLAMMERN_TOKENS: [Lexer.Tokens] = [.rk, .rgk, .rek]
	
	//MARK: Variablen für den Shunting Yard Algorithmus:
	private var outputQueue: [Token] = []
	private var operatorStack: [Token] = []
	
	//MARK: andere Variablen
	private var tokens: [Lexer.Token]
	private var mathematischeFehler: [String] = []
	private var pointer: Int = 0
	private var outputFunktion: FunktionProt = Dividieren(a: Zahl(1), b: Zahl(0))
	private var fehlgeschlagen = false
	
	///Tut den Input parsen
	///- Parameter string: Latex von dem mathematischen Ausdruck
	init(string input: String, dataModel: DataModel){
		self.dataModel = dataModel
		let l = Lexer(str: input)
		self.tokens = l.getTokens().tokens
		mathematischeFehler.append(contentsOf: l.getTokens().fehler)
		
		if(self.tokens.isEmpty){
			mathematischeFehler.append("Parser Output darf nicht leer sein")
			fehlgeschlagen = true
			self.outputFunktion = Zahl(.nan)
			return
		}
		
		preprocessor()
		parseInput()
		outputQueueToMathTree()
	}
	
	///Gibt die output Funktion des Parsers, sowie mögliche Fehler zurück
	public func getFunktion() -> (funktion: FunktionProt, fehler: [String], fehlgeschlagen: Bool){
		return (outputFunktion, mathematischeFehler, fehlgeschlagen)
	}
	
	///Bereitet den Input Token Stream so vor, dass der pars-Teil ihn verarbeiten kann
	private func preprocessor(){
		fuegeStandardWerteHinzu()
		fuegeKlammernHinzu()
		findeNegativeZahlen()
		fuegeImpliziteOperatorenHinzu()
		bruchZuGeteilt()
		prettyPrintTokens()
	}
	
	///Führt die notwendigen Schritte zum parsen der Tokens aus
	private func parseInput(){
		shuntingYard()
		prettyPrintOutputQueue()
	}
	
	///Negiert Zahlen mit Minus als Vorzeichen
	///- Description: Da es schwierig ist ein Minus als Operator von einem minus als Vorzeichen zu unterscheiden, kann der Lexer diesen Schritt noch nicht ausführen. Diese Funktion tut genau das. Sie unterscheidet zwischen einem Minus als Operator und als Vorzeichen. Wenn das Minus ein Vorzeichen ist, wird der Token entfernt und die Zahl zu dem das Vorzeichen gehört negiert.
	private func findeNegativeZahlen(){
		func ersetze(index: Int){
			assert(tokens[index].type == .zahl, "Kann Vorzeichen nur zu Token von Typ Zahl hinzufügen")
			let newValue = Double(tokens[index].parameters.first!)! * -1
			tokens[index].parameters[0] = "\(newValue)"
			tokens.remove(at: index-1)
		}
		
		var offset = 0
		for index in (1..<tokens.count){
			if(tokens[index - offset].type == .zahl && tokens[index - offset - 1].type == .minus){
				//preufe ob ersetzt werden darf
				let verbotenBei: [Lexer.Tokens] = [.x,.rk, .rgk, .rek, .euler, .pi, .y, .zahl]
				if(index - offset == 1){
					ersetze(index: index - offset)
					offset += 1
				}else if(!verbotenBei.contains(tokens[index - 2 - offset].type)){
					//wenn nicht erhalten, ersetze
					ersetze(index: index - offset)
					offset += 1
				}
			}
		}
	}
	
	public func prettyPrintTokens(){
		print("\n\n-------- after Replacement: --------\n")
		for token in tokens {
			print("> \(token.type) : \(token.parameters)")
		}
		print("\nFehler: \(mathematischeFehler)\n")
	}
	
	public func prettyPrintOutputQueue(){
		print("\n\n-------- output: --------\n")
		for token in outputQueue {
			print("> \(token.type) : \(token.parameters)")
		}
		print("\nFehler: \(mathematischeFehler)\n")
	}
	
	///Fügt Standardwerte hinzu z.B. ln => log{euler} oder sqrt => wurzel{2}
	private func fuegeStandardWerteHinzu(){
		//Ersetze log <ohne "_"> durch log _ .zahl<10>
		var indexOffset = 0
		for index in 0..<tokens.count - 1{
			if(tokens[index + indexOffset].type == .log && tokens[index + 1 + indexOffset].type != .unterstrich){
				tokens.replaceSubrange( index+indexOffset...index+indexOffset, with: [Lexer.Token(type: .log, parameters: []),Lexer.Token(type: .unterstrich, parameters: []),Lexer.Token(type: .zahl, parameters: ["10"])])
				indexOffset += 2
			}
		}
		
		//Ersetze ln durch log _ .euler
		while tokens.firstIndex(where: {$0.type == .ln}) != nil{
			let index = tokens.firstIndex(where: {$0.type == .ln})!
			tokens.replaceSubrange( index...index, with: [Lexer.Token(type: .log, parameters: []),Lexer.Token(type: .unterstrich, parameters: []),Lexer.Token(type: .euler, parameters: [])])
		}
		
		//Ersetze sqrt <ohne [...]> durch sqrt [ .zahl<2> ]
		indexOffset = 0
		for index in 0..<tokens.count - 1{
			if(tokens[index + indexOffset].type == .wurzel && tokens[index + 1 + indexOffset].type != .lek){
				tokens.replaceSubrange( index+indexOffset...index+indexOffset, with: [Lexer.Token(type: .wurzel, parameters: []),Lexer.Token(type: .lek, parameters: []),Lexer.Token(type: .zahl, parameters: ["2"]),Lexer.Token(type: .rek, parameters: [])])
				indexOffset += 3
			}
		}
	}
	
	///Fügt impliziete Klammern hinzu (bei Potenz und Unterstrich)
	private func fuegeKlammernHinzu(){
		///Fügt Klammer für Typ hinzu z.B.  log_3 -> log_{3}
		func fuegeKlammerHinzuBeiTyp(type: Lexer.Tokens){
			var indexOffset = 0
			for index in 0..<tokens.count - 1{
				if(tokens[index + indexOffset].type == type){
					if(tokens[index + 1 + indexOffset].type != .lgk){
						tokens.insert(Lexer.Token(type: .lgk, parameters: []), at: index + 1 + indexOffset)
						tokens.insert(Lexer.Token(type: .rgk, parameters: []), at: index + 3 + indexOffset)
						indexOffset += 2
					}
				}
			}
		}
		
		fuegeKlammerHinzuBeiTyp(type: .potenz)
		fuegeKlammerHinzuBeiTyp(type: .unterstrich)
	}
	
	///Fuegt impliziete Operatoren
	///zwischen zwei nicht Operatoren Tokens wird ein mal hinzugefuegt
	///z.B. [2] [π] -> [2] [*] [π]
	private func fuegeImpliziteOperatorenHinzu(){
		let fuegeMalHinzuBeiZahlUnd: [Lexer.Tokens] = [.parameter, .x, .pi, .euler, .lk]
		var hatErsetzt = true
		while hatErsetzt{
			for iToken in 0..<tokens.count - 1 {
				if(tokens[iToken].type == .zahl && fuegeMalHinzuBeiZahlUnd.contains(tokens[iToken + 1].type)){
					tokens.insert(Token(type: .mal, parameters: []), at: iToken + 1)
					continue
				}
			}
			hatErsetzt = false
		}
	}
	
	///Wandelt infix-Schreibweise zu postfix um
	///tut dies nach dem shunting yard Algorithmus
	private func shuntingYard(){
		for token in tokens {
			if NUMBER_TOKENS.contains(token.type){
				outputQueue.append(token)
				
			}else if FUNKTIONS_TOKENS.contains(token.type){
				operatorStack.append(token)
				
			}else if OPERATOREN_TOKENS.contains(token.type){
				//Leere Operatorstack (kommt auf die Regeln an)
				while !operatorStack.isEmpty{
					
					let topOp = operatorStack.last!
					
					if(
						!LINKE_KLAMMERN_TOKENS.contains(topOp.type) &&
						(
							topOp.precedence > token.precedence ||
							(
								topOp.precedence == token.precedence &&
								token.associativity == .links
							)
						)
						
					){
						outputQueue.append(operatorStack.popLast()!)
					}else{
						break
					}
				}
				operatorStack.append(token)
			}else if LINKE_KLAMMERN_TOKENS.contains(token.type){
				operatorStack.append(token)
				
			}else if RECHTE_KLAMMERN_TOKENS.contains(token.type){
				while true{
					if(operatorStack.isEmpty){
						mathematischeFehler.append("Klammersetzung")
						fehlgeschlagen = true
					}else{
						if LINKE_KLAMMERN_TOKENS.contains(operatorStack.last!.type){
							operatorStack.removeLast()
							break
						}
						outputQueue.append(operatorStack.popLast()!)
					}
				}
				if let topTokenType = operatorStack.last?.type{
					if FUNKTIONS_TOKENS.contains(topTokenType){
						outputQueue.append(operatorStack.popLast()!)
					}
				}
			}else{
				print("Typ nicht beachtet: \(token.type)")
			}
		}
		
		//Am Ende alle verbleibenden Tokens vom OperatorenStack zur Outputqueue hinzufügen
		while !operatorStack.isEmpty{
			let token = operatorStack.last!
			if LINKE_KLAMMERN_TOKENS.contains(token.type){
				mathematischeFehler.append("Klammersetzung")
				fehlgeschlagen = true
			}else if !RECHTE_KLAMMERN_TOKENS.contains(token.type){ //Rechte Klammern werden ignoriert
				outputQueue.append(operatorStack.popLast()!)
			}
		}
	}
	
	private func outputQueueToMathTree(){
		self.outputFunktion = postfixToTree()
		if(hasUsed < outputQueue.count){
			mathematischeFehler.append("Operatoren nicht richtig verbunden")
			fehlgeschlagen = true
			messagePublisher.sendeNachricht("Operatoren nicht richtig verbunden", farbe: .red)
		}
	}
	
	var hasUsed = 0 //welche Tokens schon zur Funktion hinzugefügt wurden
	private func postfixToTree() -> FunktionProt{
		if outputQueue.count - hasUsed - 1 < 0{
			mathematischeFehler.append("Fehlende Operanten")
			fehlgeschlagen = true
			return EulerZahl()
		}
		let token = outputQueue[outputQueue.count - hasUsed - 1]
		hasUsed += 1
		switch token.type{
		//Werte
		case .zahl:
			return Zahl(Float(token.parameters.first!)!)
		case .x:
			return XWert()
		case .euler:
			return EulerZahl()
		case .pi:
			return Pi()
		case .parameter:
			do{
				if(dataModel.addParameter(name: token.parameters.first ?? "-")){
					return try ParameterSlave(name: try ParameterNames(str: token.parameters.first ?? "-"), dataModel: dataModel)
				}else{
					mathematischeFehler.append("Unbekannter Parameter: \(token.parameters.first ?? "?-?")")
					fehlgeschlagen = true
					return Zahl(.nan)
				}
			}catch{
				mathematischeFehler.append("Unbekannter Parameter: \(token.parameters.first ?? "?-?")")
				fehlgeschlagen = true
				return Zahl(.nan)
			}
		
		//Nodes
		case .log:
			return Log(a: postfixToTree(), b: postfixToTree())
			
		case .sin:
			return Sinus(postfixToTree())
		case .cos:
			return Cosinus(postfixToTree())
		case .tan:
			return Tangens(postfixToTree())
			
		case .plus:
			return Addieren(a: postfixToTree(), b: postfixToTree())
		case .minus:
			let b = postfixToTree()
			let a = postfixToTree()
			return Subtrahieren(a: a, b: b)
			
		case .mal:
			return Multiplizieren(a: postfixToTree(), b: postfixToTree())
		case .geteilt:
			let b = postfixToTree()
			let a = postfixToTree()
			return Dividieren.init(a: a, b: b)
		case .bruch:
			let b = postfixToTree()
			let a = postfixToTree()
			return Dividieren.init(a: a, b: b)
			
		case .potenz:
			let b = postfixToTree()
			let a = postfixToTree()
			return Potenz.init(a, b)
			
		case .wurzel:
			let rad = postfixToTree()
			let exp = postfixToTree()
			return Wurzel(exp: exp, rad: rad)
		
		default:
			mathematischeFehler.append("Token konnte nicht verarbeitet werden: \(token.type)")
			return Zahl(1)
		}
	}
	
	///Schreibt bruch zu geteilt um, da shunting yard infix operatoren braucht und bruch im prefix stil ist
	private func bruchZuGeteilt(){
		var continueSearch = true
		
		while continueSearch{
			var pointer = 0
			var state = 0
			var bruchIndex = -1
			var geteiltIndex = -1
			var klammernAuf = 0
			while pointer < tokens.count{
				let tokenType = tokens[pointer].type
				switch state{
				case 0:
					if(tokenType == .bruch){
						bruchIndex = pointer
						state = 1
					}
					break
				case 1:
					if(tokenType == .lgk){
						state = 2
						klammernAuf += 1
					}else{
						mathematischeFehler.append("Klammersetzung!")
						fehlgeschlagen = true
					}
					break
				case 2:
					if(tokenType == .lgk){
						klammernAuf += 1
					}else if(tokenType == .rgk){
						klammernAuf -= 1
					}
					if(klammernAuf == 0){
						geteiltIndex = pointer
					}
				default:
					fatalError("unknown state: \(state)")
				}
				
				pointer += 1
			}
			if(bruchIndex + geteiltIndex > 1 && state == 2){
				tokens.remove(at: bruchIndex)
				tokens.insert(Token(type: .geteilt, parameters: []), at: geteiltIndex)
				continue
			}else if (state > 0){
				mathematischeFehler.append("Bruch invalide")
				fehlgeschlagen = true
			}
			continueSearch = false
		}
	}
}
