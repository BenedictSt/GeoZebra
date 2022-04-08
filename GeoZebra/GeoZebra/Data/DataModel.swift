//
//  DataModel.swift
//  GeoZebra
//
//  Created by Benedict on 25.12.21.
//

import Foundation
import AppKit

class DataModel: ObservableObject{
	typealias ParameterName = ParameterMaster.ParameterNames
	
	@Published var update = UUID()
	var parameter: [ParameterName : ParameterMaster] = [:]
	var funktionen: [UUID : Funktion] = [:]
	var funktionenIds: [UUID] = []
	var viewPortBegrenzungen = ViewPortBegrenzungen()
	var koordinatenSettings: KoordinatenSettings
	
	init(){
		koordinatenSettings = KoordinatenSettings()
		_ = addFunktion(Funktion(funktion: Potenz(XWert(), Zahl(2)), NSColor(hue: 0.31, saturation: 1, brightness: 0.63, alpha: 1.0), latex: "x^2"))
		_ = addFunktion(Funktion(funktion: Wurzel(exp: Zahl(2), rad: XWert()), latex: "\\\\sqrt{x}"))
		_ = addFunktion(Funktion(funktion: Sinus(XWert()), NSColor.blue, latex: "sinx"))
	}
	
	/**
	 Fügt eine Funktion hinzu
	 - Parameter funktion_: Die Funktion, die hinzugefügt werden soll
	 */
	public func addFunktion(_ funktion: Funktion) -> UUID{
		let id = UUID()
		self.funktionen[id] = funktion
		self.funktionenIds.append(id)
		return id
	}
	
	/**
	Entfernt eine Funktion aus dem Datenmodel
	- Parameter id: Id der zu löschenden Funktion
	 */
	public func removeFunktion(id: UUID){
		self.funktionen[id] = nil
		self.funktionenIds.removeAll(where: {$0 == id})
	}
	
	//MARK: Parameter
	///Fuegt einen neuen Parameter zu den Parametern hinzu
	func addParameter() {
		let parameterNamenSortiert: [ParameterName] = [.A,.B,.C,.D,.E,.F,.G,.H,.I,.J,.K,.L,.M,.N,.O,.P,.Q,.R,.S,.T,.U,.V,.W,.X,.Y,.Z]
		
		let neuerName = parameterNamenSortiert.first(where: {!self.parameter.keys.contains($0)})
		if let neuerName = neuerName{
			parameter[neuerName] = ParameterMaster(name: neuerName, viewPortBegrenzungen: viewPortBegrenzungen)
			messagePublisher.sendeNachricht("Neuer Parameter hinzugefügt: \(neuerName.rawValue)", farbe: .green)
		}else{
			messagePublisher.sendeNachricht("Kann nicht mehr Parameter hinzufügen.", farbe: .red)
		}
	}
	
	///Fuegt einen neuen Parameter mit definiertem Namen hinzu
	///
	///- Parameter name: Name des Parameters, z.B. "A" oder "B"
	///- Returns: ob der Parameter hinzugefügt werden konnt, bzw. ob der Parameter schon existierte
	func addParameter(name: String) -> Bool{
		do{
			let parameterKey: ParameterName = try ParameterName(str: name)
			if(self.parameter[parameterKey] == nil){
				parameter[parameterKey] = ParameterMaster(name: parameterKey, viewPortBegrenzungen: viewPortBegrenzungen)
			}
			return true
		}catch{
			return false
		}
	}
	
	///Pausiert alle Animationen von Parametern
	public func pauseAllAnimations(){
		for x in parameter{
			x.value.animation.isPlaying = false
		}
		messagePublisher.sendeNachricht("Alle Animationen pausiert.")
	}
	
	///Startet alle Animationen von Parametern
	public func playAllAnimations(){
		for x in parameter{
			x.value.animation.isPlaying = true
		}
		messagePublisher.sendeNachricht("Alle Animationen gestartet.")
	}
	
	//MARK: Funktionen
	///Findet welche Funktion an dem Punkt im Koordiantensystem ist
	public func findFunctionAtPoint(x: Float, y: Float) -> UUID?{
		var closestFunction: UUID?
		var closestError: Float = 100_000
		for funktionsId in funktionenIds {
			let error: Float = abs(y - funktionen[funktionsId]!.calculate(x: x))
			if(error < viewPortBegrenzungen.height / 50 && error < closestError){
				closestError = error
				closestFunction = funktionsId
			}
		}
		return closestFunction
	}
}
