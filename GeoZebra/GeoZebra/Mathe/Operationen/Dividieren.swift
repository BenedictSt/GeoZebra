//
//  Dividieren.swift
//  GeoZebra
//
//  Created by Benedict on 25.12.21.
//

import Foundation

/**
 Rechnet a / b
 - Parameter a: Zähler
 - Parameter b: Nenner
 */
class Dividieren: FunktionProt{
	let a: FunktionProt
	let b: FunktionProt
	
	/**
	 Rechnet a / b
	 - Parameter a: Zähler
	 - Parameter b: Nenner
	 */
	init(a: FunktionProt, b: FunktionProt){
		self.a = a
		self.b = b
	}
	
	func calculate(x: Float) -> Float {
		return a.calculate(x: x) / b.calculate(x: x)
	}
	
	func derivative(x: Float) -> Float {
		return (a.derivative(x: x) / b.calculate(x: x)) +  (a.calculate(x: x) * (-1*(pow(b.calculate(x: x), -2)))*b.derivative(x: x)) //Siehe Notizen zu Dividieren
	}
	
	func getString() -> String {
		return "(\(a.getString()) / \(b.getString()))"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return [DefinitionsBedingung(funktion: b, typ: .gleich, wert: 0)] + a.getDefinitionslückenBedingungen() + b.getDefinitionslückenBedingungen()
	}
}
