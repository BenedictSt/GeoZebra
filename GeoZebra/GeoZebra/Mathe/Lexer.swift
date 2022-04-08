//
//  Lexer.swift
//  GeoZebra
//
//  Created by Benedict on 26.12.21.
//

import Foundation

//Lexer ist ein Lexer und verarbeitet einen Inputstream im Latexformat zu einem Tokenstream
class Lexer{
	//MARK: - Kontanten
	private let ZIFFERN = "0123456789".toStringArray()
	private let KOMMATA = ".,".toStringArray()
	private let PARAMETER_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toStringArray()
	private let FUNKTION_NAME_ALPHABET = "abcdfghijklmnopqrstuvw".toStringArray() // [a...w]\{e}
	private let TRENNZEICHEN = "(){} []"
	private let replaceCCtoTokenDict: [String : Tokens] = [
		"x" : .x,
		"+" : .plus,
		"-" : .minus,
		"/" : .geteilt,
		"*" : .mal,
		"^" : .potenz,
		"(" : .lk,
		")" : .rk,
		"{" : .lgk,
		"}" : .rgk,
		"[" : .lek,
		"]" : .rek,
		"e" : .euler,
		"π" : .pi,
		"=" : .gleich,
		"y" : .y,
		"_" : .unterstrich,
		"Ö" : .log,
		"Ü" : .ln,
		"ö" : .sin,
		"ü" : .cos,
		"ä" : .tan,
		"Ä" : .wurzel,
		"@" : .bruch,
	]
	private static let ersetzungsRegeln: [(ersetze: String, durch: String)] = [
		("\\sqrt", "Ä"),
		("\\frac", "@"),
		("\\sin", "ö"),
		("\\cos", "ü"),
		("\\tan", "ä"),
		("\\log", "Ö"),
		("\\ln", "Ü"),
		("\\pi", "π"),
		("pi", "π"),
		("\\%", "%"),
		("\\cdot", "*"),
		("\\times", "*"),
		("\\div", "/"),
		("\\left(", "("),
		("\\right)", ")"),
		("\\left{", "{"),
		("\\righ}", "}"),
		("\\left[", "["),
		("\\right]", "]"),
		("\\left|", "|"),
		("\\right|", "|"),
	]
	
	
	//MARK: - Variablen
	private var pointer = 0 //Welches Zeichen vom Inputstream gerade tokenised wird
	private var zahlHatKomma = false
	private var aktuelleZahlZiffern = ""
	private var inputStream: Array<String>
	private var outputTokens: [Token] = []
	private var mathematischeFehler: [String] = []
	
	init(str input: String){
		self.inputStream = Lexer.wendeErsetzungsRegelnAn(input).toStringArray()
		tokenize()
		prettyPrintTokens()
	}
	
	///Liefert die Ergebnise vom Lexer
	/// - Returns: **tokens**: ein Array mit den Tokens in der Reihenfolge wie im Input; **fehler**: Array mit eventuellen Fehlern die beim lexen aufgetreten sein können
	public func getTokens() -> (tokens: [Token], fehler: [String]){
		return (outputTokens, mathematischeFehler)
	}
	
	///Visualisiert die output Tokens in der Konsole
	private func prettyPrintTokens(){
		print("\n\n-------- Tokens: --------\n")
		outputTokens.forEach({print("> \($0.type) : \($0.parameters)")})
		print("\n mathematische Fehler: \(mathematischeFehler)")
	}
	
	///Wendet statische Ersetzungsregeln an, um den Inputstream in ein einheitliches Format zu bringen
	static private func wendeErsetzungsRegelnAn(_ str: String) -> String{
		var tmp = str
		ersetzungsRegeln.forEach({
			tmp = tmp.replacingOccurrences(of: $0.ersetze, with: $0.durch)
		})
		return tmp
	}
	
	///Geht den InputStram Zeichen für Zeichen durch und sucht nach Tokens
	private func tokenize(){
		while (pointer < inputStream.count) {
			findNextToken()
			pointer += 1
		}
		finishNumber() //Wenn man Ende noch eine Zahl offen ist, wird diese abgeschlossen und zum output hinzugefügt
	}
	
	///Arbeitet das aktuelle Zeichen des Inputstreams ab und fuegt entsprechend Tokens zum Output hinzu
	private func findNextToken(){
		let cc = inputStream[pointer] //Eingabesymbol
		for rep in replaceCCtoTokenDict{
			if(cc == rep.key){
				finishNumber()
				outputTokens.append(Token(type: rep.value, parameters: []))
				return
			}
		}
		
		if PARAMETER_ALPHABET.contains(cc){
			finishNumber()
			outputTokens.append(Token(type: .parameter, parameters: [cc]))
			return
		}
		
		if FUNKTION_NAME_ALPHABET.contains(cc){
			finishNumber()
			outputTokens.append(Token(type: .funktionsname, parameters: [cc]))
			return
		}
		
		if TRENNZEICHEN.contains(cc){
			finishNumber()
			return
		}
		
		if ZIFFERN.contains(cc){
			aktuelleZahlZiffern += cc
			if(outputTokens.count > 1){
				let finalTokensLastIndex = outputTokens.count - 1
				if(outputTokens[finalTokensLastIndex].type == .unterstrich && outputTokens[finalTokensLastIndex - 1].type == .log){
					//normalerweise folgt auf ein log_ eine "{", wenn nicht, ist die Zahl nur ein Token lang und kann hier schon beendet werden
					finishNumber()
					return
				}
			}
			return
		}
		
		if KOMMATA.contains(cc){
			if(!zahlHatKomma){
				zahlHatKomma = true
				aktuelleZahlZiffern += "."
				return
			}else{
				finishNumber()
				mathematischeFehler.append("Lexer.zuvieleKommata: >\(aktuelleZahlZiffern)<")
				return
			}
		}
		mathematischeFehler.append("Lexer.ungültige Eingabe: \(cc)")
	}
	
	///Wenn der aktuelle Token eine Zahl ist, dann erstellt diese Funktion einen Zahl-Token mit dem Wert und reset den Automaten um neue Zustände annehmen zu können
	///- Description: Da eine Zahl aus mehr als einem Zeichen bestehen kann, müssen diese akkumuliert werden und dann am Ende zu einer Zahl zusammengefügt.
	private func finishNumber(){
		if(!aktuelleZahlZiffern.isEmpty){
			let wert = Float(aktuelleZahlZiffern)
			if let wert = wert{
				outputTokens.append(Token(type: .zahl, parameters: ["\(wert)"]))
			}else{
				mathematischeFehler.append("Lexer.keine Zahl: >\(aktuelleZahlZiffern)<")
			}
			aktuelleZahlZiffern = ""
			zahlHatKomma = false
		}
	}
}
