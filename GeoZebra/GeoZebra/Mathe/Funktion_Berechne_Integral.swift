//
//  Funktion_Berechne_Integral.swift
//  GeoZebra
//
//  Created by Benedict on 08.02.22.
//

import Foundation
fileprivate let ACCURACY_FOR_INTEGRAL = 10000

extension Funktion{
	func berechneIntegral(untereGrenze: Float, obereGrenze: Float) -> Float{
		let dx: Float = (obereGrenze - untereGrenze) / Float(ACCURACY_FOR_INTEGRAL)
		if(dx < 0){
			return Float.nan
		}
		var integralSumme: Float = 0
		
		for i in 0..<ACCURACY_FOR_INTEGRAL{
			let x = untereGrenze + Float(i) * dx
			integralSumme += dx * calculate(x: x)
		}
		return integralSumme
	}
	
	func berechneFlaeche(untereGrenze: Float, obereGrenze: Float) -> Float{
		let dx: Float = (obereGrenze - untereGrenze) / Float(ACCURACY_FOR_INTEGRAL)
		if(dx < 0){
			return Float.nan
		}
		var flaecheSumme: Float = 0
		
		for i in 0..<ACCURACY_FOR_INTEGRAL{
			let x = untereGrenze + Float(i) * dx
			flaecheSumme += dx * abs(calculate(x: x))
		}
		return flaecheSumme
	}
}
