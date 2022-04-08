//
//  LexerKlasssen.swift
//  
//
//  Created by Benedict on 26.02.22.
//

import Foundation

extension Lexer{
	///Alle Token Types, die GeoZebra unterstützt
	public enum Tokens{
		//lk = linke Klammer
		//rgk = rechte geschweifte Klammer
		//lek = linke eckige Klammer
		//...
		case x, zahl, plus, minus, geteilt, mal, log, ln, sin, cos, tan, potenz, wurzel, parameter, bruch, lk, rk, lgk, rgk, lek, rek, euler, pi, gleich, y, funktionsname, unterstrich, absoluteEnd
	}
}

extension Lexer{
	///Token eines mathematischen Operators, Wert, Parameter, etc.
	public class Token{
		///Ob der Operator rechts oder linksausgerichtet ist
		///siehe Shunting Yard
		enum associativityValue{
			case links, rechts
		}
		
		let type: Tokens
		var parameters: [String]
		
		var precedence: Int {
			get{
				let table: [Tokens : Int] = [
					.x: 1,
					.plus: 2,
					.minus: 2,
					.geteilt: 3,
					.mal: 3,
					.potenz: 4,
					.lk: 10,
					.rk: 10,
					.lgk: 10,
					.rgk: 10,
					.lek: 10,
					.rek: 10,
					.euler: 1,
					.pi: 1,
					.y: 1,
					.log: 42,
					.ln: 42,
					.sin: 42,
					.cos: 42,
					.tan: 42,
					.funktionsname: 42,
					.wurzel: 4,
					.bruch: 3
				]
				return table[self.type, default: -1]
			}}
		
		///Wie die Reihenfolge der Operatoren ist (siehe shunting yard)
		var associativity: associativityValue {
			get{
				let table: [Tokens : associativityValue]  = [
					.plus : .links,
					.minus : .links,
					.geteilt : .links,
					.mal : .links,
					.potenz : .rechts,
					.wurzel : .rechts,
					.bruch : .links
				]
				return table[type, default: .links]
			}
		}
		
		init(type: Tokens, parameters: [String]){
			self.type = type
			self.parameters = parameters
		}
		
	}
}
