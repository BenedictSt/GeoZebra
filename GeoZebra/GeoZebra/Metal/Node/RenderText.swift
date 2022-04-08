//
//  RenderText.swift
//  GeoZebra
//
//  Created by Benedict on 16.01.22.
//

import Foundation
import MetalKit

///Struct die eine Zahl plus Position auf der Canvas erhält und die dann auch die Vertex Daten, die diese Zahl representieren erstellt
struct RenderNumber{
	///Alle Zeichen, die GeoZebra in den Graphen schreiben kann
	///- Zeichen: 1 2 3 4 5 6 7 8 9 0 , -
	public enum digits: String{
		case d1 = "1"
		case d2 = "2"
		case d3 = "3"
		case d4 = "4"
		case d5 = "5"
		case d6 = "6"
		case d7 = "7"
		case d8 = "8"
		case d9 = "9"
		case d0 = "0"
		case dMinus = "-"
		case dKomma = ","
	}
	
	public enum anchors{
		case oben, unten, rechts, links
	}
	
	let number: Float //Wert der zurenderen Zahl
	let position: SIMD3<Float> //Position des Ankers
	let anchor: anchors //Position des Ankers an der Zahl, also an welcher Seite es ausgerichtet werden soll
	let runden: Float //Auf wie viele Nachkommastellen gerundet werden soll als = 10 ^ nachkommastellen
	
	/// - Parameter zahl: Wert der Zahl, die zum Screen gerendert werden soll
	/// - Parameter position: Position auf die der Text gerendert werden soll, muss schon auf die Canvas gemapped sein!
	/// - Parameter anchor: Für die Mitte welcher Seite die Position gilt
	/// - Parameter nachkommastellen: Auf wie viele Nachkommastellen die Zahl gerundet werden soll: Standartmäßg: 1
	init(zahl: Float, position: SIMD3<Float>, anchor: anchors = .oben, nachkommastellen: Int = 1){
		self.number = zahl
		self.position = position
		self.anchor = anchor
		self.runden = Float(pow(10.0, Float(max(1,nachkommastellen))))
	}
	
	///Teilt Zahlen in Zeichen auf und erstellt Array von Primitives, die auf die Canvas gemapped sind und die Zahl representieren
	///- Parameter device: Auf welchem MLTDevice der Text erscheinen soll
	///- Parameter viewPortBegrenzungen: Begrenzungen um genau zu wissen, wo die Zahlen von ihrer Position im Koordinatensystem auf der Canvas sind
	///- Returns: Ein Array an Primitives, die 1:1 in einer Scene gerendert werden können und die Zahl darstellen
	func getPrimitives(device: MTLDevice, viewPortBegrenzungen: ViewPortBegrenzungen) -> [Primitive]{
		let DIGIT_WIDTH: Float = 0.013
		let SCALE_FACTOR: Float = 0.0005
		
		//Ordnet die Ziffer ihrer Position im Text und dem Offset richtig an
		func transformZiffer(ziffer: inout Primitive, positionInText: Int, xOffset: Float, yOffset: Float){
			ziffer.translate(direction: position) //Schiebt auf allgemeine Position des Textes
			ziffer.translate(direction: SIMD3<Float>(DIGIT_WIDTH * Float(positionInText),0,0)) //Passt es der Position im Text entsprechend an
			ziffer.translate(direction: SIMD3<Float>(xOffset, yOffset, 0)) //Passt es dem Anker entsprechend an
			ziffer.scale(axis: SIMD3<Float>(SCALE_FACTOR,-SCALE_FACTOR,1)) //Spigelt es, weil sonst steht die Zahl auf dem Kopf
		}
		
		
		var asString = String(round(number * runden) / runden) //gerundet auf eine Nachkommastelle
		if(asString.hasSuffix(".0")){
			asString = asString.replacingOccurrences(of: ".0", with: "")
		}
		
		var xOffset: Float = 0
		var yOffset: Float = 0
		switch anchor {
		case .oben:
			xOffset = (Float(asString.count) * DIGIT_WIDTH) / -2
			yOffset = -0.015
		case .unten:
			xOffset = (Float(asString.count) * DIGIT_WIDTH) / -2
			yOffset = 0.115
		case .rechts:
			xOffset = 0.115 - (Float(asString.count) * DIGIT_WIDTH)
			yOffset = 0.012
		case .links:
			xOffset = 0.015
			yOffset = 0.012
		}
		
		var outputPrimitives: [Primitive] = []
		for positionInText in 0..<asString.count{
			var primitive: Primitive = { () -> Primitive in
				switch asString[positionInText]{
				case "0":
					return Ziffer_0(withDevice: device)
				case "1":
					return Ziffer_1(withDevice: device)
				case "2":
					return Ziffer_2(withDevice: device)
				case "3":
					return Ziffer_3(withDevice: device)
				case "4":
					return Ziffer_4(withDevice: device)
				case "5":
					return Ziffer_5(withDevice: device)
				case "6":
					return Ziffer_6(withDevice: device)
				case "7":
					return Ziffer_7(withDevice: device)
				case "8":
					return Ziffer_8(withDevice: device)
				case "9":
					return Ziffer_9(withDevice: device)
				case "-":
					return Ziffer_Minus(withDevice: device)
				case ".":
					return Ziffer_Komma(withDevice: device)
				default:
					print("can't render: \(asString[positionInText])")
					return Ziffer_Komma(withDevice: device)
				}
			}()
			
			transformZiffer(ziffer: &primitive, positionInText: positionInText, xOffset: xOffset, yOffset: yOffset)
			outputPrimitives.append(primitive)
		}
		return outputPrimitives
	}
}
