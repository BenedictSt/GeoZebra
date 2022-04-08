//
//  Addieren.swift
//  GeoZebra
//
//  Created by Benedict on 25.12.21.
//

import Foundation

class Addieren: FunktionProt{
	let a: FunktionProt
	let b: FunktionProt
	
	init(a: FunktionProt, b: FunktionProt){
		self.a = a
		self.b = b
	}
	
	func calculate(x: Float) -> Float {
		return a.calculate(x: x) + b.calculate(x: x)
	}
	
	func derivative(x: Float) -> Float {
		
		//		if(type(of: a) == type(of: XWert()) && type(of: b) == type(of: XWert())){
		//			return 2
		//		}
		//		if(type(of: a) == type(of: XWert())){
		//			return 1 + b.derivative()
		//		}
		//		if(type(of: b) == type(of: XWert())){
		//			return a.derivative() + 1
		//		}
		
		return a.derivative(x: x) + b.derivative(x: x)
	}
	
	func getString() -> String {
		return "(\(a.getString()) + \(b.getString()))"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return a.getDefinitionslückenBedingungen() + b.getDefinitionslückenBedingungen()
	}
}

class Subtrahieren: FunktionProt{
	let a: FunktionProt
	let b: FunktionProt
	
	/**
	 a - b
	 */
	init(a: FunktionProt, b: FunktionProt){
		self.a = a
		self.b = b
	}
	
	func calculate(x: Float) -> Float {
		return a.calculate(x: x) - b.calculate(x: x)
	}
	
	func derivative(x: Float) -> Float {
		
		//		if(type(of: a) == type(of: XWert()) && type(of: b) == type(of: XWert())){
		//			return 2
		//		}
		//		if(type(of: a) == type(of: XWert())){
		//			return 1 + b.derivative()
		//		}
		//		if(type(of: b) == type(of: XWert())){
		//			return a.derivative() + 1
		//		}
		
		return a.derivative(x: x) - b.derivative(x: x)
	}
	
	func getString() -> String {
		return "(\(a.getString()) - \(b.getString()))"
	}
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return a.getDefinitionslückenBedingungen() + b.getDefinitionslückenBedingungen()
	}
}
