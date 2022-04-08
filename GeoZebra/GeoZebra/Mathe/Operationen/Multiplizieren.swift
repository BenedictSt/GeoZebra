//
//  Multiplizieren.swift
//  GeoZebra
//
//  Created by Benedict on 25.12.21.
//

import Foundation

class Multiplizieren: FunktionProt{
	let a: FunktionProt
	let b: FunktionProt
	
	init(a: FunktionProt, b: FunktionProt){
		self.a = a
		self.b = b
	}
	
	func calculate(x: Float) -> Float {
		return a.calculate(x: x) * b.calculate(x: x)
	}
	
	func derivative(x: Float) -> Float {
		return (a.derivative(x: x) * b.calculate(x: x)) +  (b.derivative(x: x) * a.calculate(x: x)) //Produktregel
	}
	
	func getString() -> String {
		return "(\(a.getString()) * \(b.getString()))"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return a.getDefinitionslückenBedingungen() + b.getDefinitionslückenBedingungen()
	}
}
