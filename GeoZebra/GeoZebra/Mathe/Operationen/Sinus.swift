//
//  Sinus.swift
//  GeoZebra
//
//  Created by Benedict on 25.12.21.
//

import Foundation

class Sinus: FunktionProt{
	let a: FunktionProt
	
	init(_ a: FunktionProt){
		self.a = a
	}
	
	func calculate(x: Float) -> Float {
		sin(a.calculate(x: x))
	}
	
	func derivative(x: Float) -> Float {
		cos(a.calculate(x: x)) * a.derivative(x: x)
	}
	func getString() -> String {
		return "sin(\(a.getString()))"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return a.getDefinitionslückenBedingungen()
	}
}

class Cosinus: FunktionProt{
	let a: FunktionProt
	
	init(_ a: FunktionProt){
		self.a = a
	}
	
	func calculate(x: Float) -> Float {
		cos(a.calculate(x: x))
	}
	
	func derivative(x: Float) -> Float {
		-sin(a.calculate(x: x)) * a.derivative(x: x)
	}
	func getString() -> String {
		return "cos(\(a.getString()))"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return a.getDefinitionslückenBedingungen()
	}
}

class Tangens: FunktionProt{
	let a: FunktionProt
	
	init(_ a: FunktionProt){
		self.a = a
	}
	
	func calculate(x: Float) -> Float {
		tan(a.calculate(x: x))
	}
	
	func derivative(x: Float) -> Float {
		tan(a.calculate(x: x)) * a.derivative(x: x)
	}
	func getString() -> String {
		return "tan(\(a.getString()))"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return a.getDefinitionslückenBedingungen()
	}
}
