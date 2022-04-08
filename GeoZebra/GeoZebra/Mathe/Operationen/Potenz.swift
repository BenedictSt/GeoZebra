//
//  Potenz.swift
//  GeoZebra
//
//  Created by Benedict on 25.12.21.
//

import Foundation

///Eine Potenzfunktion
class Potenz: FunktionProt{
	let a: FunktionProt //Basis
	let b: FunktionProt //Exponent
	
	/**
	 a^b
	 */
	init(_ a: FunktionProt, _ b: FunktionProt){
		self.a = a
		self.b = b
	}
	
	func calculate(x: Float) -> Float {
		pow(a.calculate(x: x), b.calculate(x: x))
	}
	
	func derivative(x: Float) -> Float {
		
//		let c = Potenz(EulerZahl(), Multiplizieren(a: Log(a: a, b: EulerZahl()), b: b)).calculate()
		let c = Potenz(a, b).calculate(x: x)
		let d = Log(a: a, b: EulerZahl()).derivative(x: x)
		let e = b.calculate(x: x)
		
		let f = Log(a: a, b: EulerZahl()).calculate(x: x)
		let g = b.derivative(x: x)
		
		return c * (d * e + (f*g))
	}
	
	func getString() -> String {
		return "(\(a.getString()) ^ \(b.getString()))"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return a.getDefinitionslückenBedingungen() + b.getDefinitionslückenBedingungen()
	}
}
