//
//  Function.swift
//  GeoZebra
//
//  Created by Benedict on 22.12.21.
//

import Foundation
import AppKit


///Bestandteil einer Funktion
///Alle Elemente einer Funktion müssen dieses Protokel implementieren
protocol FunktionProt{
	///Berechnet den y-Wert der Funktion für einen bestimmten x-Wert
	///
	///**y = f(x)**
	///- Parameter x: x-Wert für den der y-Wert berechnet werden soll
	///- Returns: y-Wert der Funktion an der stelle x
	func calculate(x: Float) -> Float
	
	///Berechnet Wert der Ableitung der Funktion
	///
	///Bzw. den Wert der Ableitung der Teilfunktion einer Funktion wenn die Klasse, von der Aufgerufen wird nicht die ganze Funktion darstellt
	///- Warning: Kann .nan zurückgeben immer .ableitungY() benutzen!
	///- Returns: Steigung der Funktion für x
	func derivative(x: Float) -> Float
	
	///Repräsentiert die Funktion als String
	///
	///z.B. pow(x,2) => x^2; mul((1+1),x) => (1+1) * x
	///- Returns: Darstellung der Teilfunktion als Text
	func getString() -> String
	
	///Gibt alle Bedingungen zurück für eine Definitionslücke (noch nicht fertig implementiert)
	///
	///Wenn eine der Bedingungen an der Stelle x0 erfüllt ist, liegt bei x0 eine Definitionslücke vor
	///- Returns: Ein Array mit moeglichen Definitionlücken
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung]
}

//Erweiterung zum setzten x-Werten vor der Berechnung
extension FunktionProt{
	///Berechnet den y-Wert der ersten Ableitung der Funktion für einen bestimmten x-Wert
	///
	///**y = f'(x)**
	///- Parameter x: x-Wert für den der y-Wert der ersten Ableitung berechnet werden soll
	///- Returns: y-Wert der ersten Ableitung an der stelle x
	func ableitungY(x: Float) -> Float{
		//MARK: Versucht den echten Wert der Ableitung über die Ableitungsregeln zu berechnen:
		let realDerivative = self.derivative(x: x)
		if(realDerivative.isNormal){
			return realDerivative
		}
		//MARK: Falls die echte Ableitung nicht berechnet werden kann, wird der Wert mit einem Steigungsdreieck angenähert
		let ACCURACY: Float = 0.00001
		let y1 = calculate(x: x)
		let y2 = calculate(x: x + ACCURACY)
		return (y2 - y1) / ACCURACY
	}
}
