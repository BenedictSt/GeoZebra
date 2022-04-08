//
//  Log.swift
//  GeoZebra
//
//  Created by Benedict on 26.12.21.
//

import Foundation

class Log: FunktionProt{
	let a: FunktionProt //
	let b: FunktionProt //Basis
	
	/**
	 log_b (a)
	 */
	init(a: FunktionProt, b: FunktionProt) {
		self.a = a
		self.b = b
	}
	
	func calculate(x: Float) -> Float {
		return logC(val: a.calculate(x: x), forBase: b.calculate(x: x))
	}
	
	func derivative(x: Float) -> Float {
		return .nan
		return (1 / a.calculate(x: x)) * a.derivative(x: x) //TODO: aktuell nur für ln
	}
	
	func getString() -> String {
		return "log{\(a.getString())}{\(b.getString())}"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return [DefinitionsBedingung(funktion: a, typ: .kleinerGleichAls, wert: 0)] + a.getDefinitionslückenBedingungen() + b.getDefinitionslückenBedingungen()
	}
	
}

fileprivate func logC(val: Float, forBase base: Float) -> Float {
	return log(val)/log(base)
}
