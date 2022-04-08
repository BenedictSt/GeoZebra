//
//  Wurzel.swift
//  GeoZebra
//
//  Created by Benedict on 26.12.21.
//

import Foundation

class Wurzel: FunktionProt{
	let a: FunktionProt //Wurzelekponent
	let b: FunktionProt //Radikand
	
	init(exp: FunktionProt, rad: FunktionProt){
		self.a = exp
		self.b = rad
	}
	
	func calculate(x: Float) -> Float {
		return pow(b.calculate(x: x), (1 / a.calculate(x: x)))
	}
	
	func derivative(x: Float) -> Float {
		Potenz(b, Dividieren(a: Zahl(1), b: a)).derivative(x: x)
	}
	
	func getString() -> String {
		return "rt{\(a.getString())}{\(b.getString())}"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		
		//Wenn der Exponent eine ganze und ungerade Zahl ist, dann darf der Radikand negativ sein
		if(type(of: a) == Zahl.self
		   && (a as! Zahl).wert.truncatingRemainder(dividingBy: 1) == 0
		   && (a as! Zahl).wert.truncatingRemainder(dividingBy: 2) == 1){
			return a.getDefinitionslückenBedingungen() + b.getDefinitionslückenBedingungen()
		}
		
		return [DefinitionsBedingung(funktion: b, typ: .kleinerAls, wert: 0)]
	}
}
