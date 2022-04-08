//
//  Zahlen.swift
//  GeoZebra
//
//  Created by Benedict on 23.12.21.
//

import Foundation

///Zahl in einer Funktion / Gleichung
class Zahl: FunktionProt{
	let wert: Float
	
	init(_ wert: Float) {
		self.wert = wert
	}
	
	func calculate(x: Float) -> Float {
		return wert
	}
	
	func derivative(x: Float) -> Float {
		return 0
	}
	
	func getString() -> String {
		return "\(wert)"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return []
	}
}

///Zahl in einer Funktion, die dem x-Wert entspricht
class XWert: FunktionProt{
	var x: Float = 0
	init(_ x: Float = 0){
		self.x = x
	}
	
	func calculate(x: Float) -> Float {
		return x
	}
	
	func derivative(x: Float) -> Float {
		return 1
	}
	
	func getString() -> String {
		return "x"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return []
	}
}

///Zahl(π) in einer Funktion / Gleichung
class Pi: FunktionProt{
	func calculate(x: Float) -> Float {
		return Float.pi
	}
	
	func derivative(x: Float) -> Float {
		return 1
	}
	
	func getString() -> String {
		return "π"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return []
	}
}

///Zahl(e ~ 2.718...) in einer Funktion / Gleichung
class EulerZahl: FunktionProt{
	func calculate(x: Float) -> Float {
		return 2.71828182845904523536028747135266249775724
	}
	
	func derivative(x: Float) -> Float {
		return 1
	}
	func getString() -> String {
		return "e"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return []
	}
}
