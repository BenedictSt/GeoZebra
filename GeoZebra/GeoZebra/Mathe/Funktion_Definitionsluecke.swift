//
//  Funktion_Definitionsluecke.swift
//  GeoZebra
//
//  Created by Benedict on 08.02.22.
//

import Foundation

//TODO: mal schauen was aus den Definitionslücken wird
//Definitionslücke, wenn Funktion <typ> <wert> | z.B. Definitionslücke, wenn Addieren(1,x) <= 0

struct DefinitionsBedingung{
	public enum Vergleichszeichen: String{
		case größerAls = ">"
		case größerGleichAls = ">="
		case gleich = "="
		case unGleich = "!="
		case kleinerGleichAls = "<="
		case kleinerAls = "<"
	}
	var funktion: FunktionProt
	var typ: Vergleichszeichen
	var wert: Float
}
/*
 struct DefinitionsLücke{
 var wert: Float
 var typ: DefinitionsBedingung.Vergleichszeichen
 }
 */
/*
 class DefinitionsLückenFinder{
 /*
  Keine Gute Lösung.
  Vorrübergehend(sehr wahrscheinlich für immer) wird nur das .gleich beachtet, da die anderen Definitionslücken sich beim zeichnen mehr oder weniger von alleine lösen
  
  */
 
 /**
  Nimmt eine Bedingung für eine Definitionslücke an und gibt alle Definitionslücken, die sich daraus ergeben zurück
  - Parameter funktion: Die Funktion auf die die Bedingung angewendet wird
  - Parameter bedingung: Die Bedingung, die erfüllt sein muss, damit es eine Definitionlücke gibt
  - Returns:Ein Array mit allen Definitionslücken, die sich aus der Bedingung ergeben
  */
 public func löseAuf(bedingung: DefinitionsBedingung) -> [DefinitionsLücke]{
 fatalError("method not implemented")
 }
 }
 */
/*
 extension Funktion{
 func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
 return interneFunktion.getDefinitionslückenBedingungen()
 }
 }
 */
