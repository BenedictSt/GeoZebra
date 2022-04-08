//
//  Funktion.swift
//  GeoZebra
//
//  Created by Benedict on 08.02.22.
//

import Foundation
import AppKit

///Verwaltet eine Funktion mit ihrem Inhalt
class Funktion: FunktionProt{
    //Funktion als abstrakter Syntaxbaum, konform zu <FunktionProt>
    public var interneFunktion: FunktionProt
    
    ///Latex Darstellung der Funktion
	public var latex: String
	
	public var fehlerUndWarungen: [String]
	public var schwererFehler: Bool
    
    //MARK: Visuelle Attribute für die Funktion
    public var sichtbar = true //Ob die Funktion im Graphenfenster angezeigt werden soll
    public var breite: Float = 50 //Wie breit/dick die Funktion im Graphenfenster ist
    public var farbe: NSColor //Farbe der Funktion im Graphenfenster
    
    ///Initialisiert eine Funktion
    init(funktion: FunktionProt, _ farbe: NSColor = NSColor.red, latex: String = ""){
        self.interneFunktion = funktion
        self.farbe = farbe
        self.latex = latex
		self.fehlerUndWarungen = []
		self.schwererFehler = false
    }
    
    ///Gibt die Farbe der Funktion in Form eines SIMD4<Float> zurück
    ///
    ///Ist wichtig, weil der Metal Renderer die Farbe als Vektor braucht und nicht als NSColor
    ///- Returns: Farbe der Funktion als SIMD4<Float>
    public func getFarbe() -> SIMD4<Float>{
        let rot = Float(self.farbe.redComponent)
        let gruen = Float(self.farbe.greenComponent)
        let blau = Float(self.farbe.blueComponent)
        let alpha = Float(self.farbe.alphaComponent)
        return SIMD4<Float>(rot, gruen, blau, alpha)
    }
    
    ///Berechnet den Wert der Funktion, aber setzt x nicht.
    ///
    ///- Warning: Nicht benutzen um den y-Wert der Funktion zu berechnen! Nutze : .calculateY(x: Float)
	func calculate(x: Float) -> Float{
		return interneFunktion.calculate(x: x)
    }
    
    ///Berechnet den Wert der ersten Ableitung der Funktion, aber setzt x nicht.
    ///
    ///- Warning: Nicht benutzen um den y-Wert der Ableitung zu berechnen! Nutze : .ableitungY(x: Float)
	func derivative(x: Float) -> Float {
		return interneFunktion.derivative(x: x)
    }
    
    ///Gibt die Funktion in Form eines Strings zurück
    ///
    ///Einfache Darstellung: z.B. "f(x) = x^2"
    ///- Returns: Funktion in einfacher Darstellung als String
    func getString() -> String {
        return "f(x) = \(interneFunktion.getString())"
    }
    
    ///private Initialisierung, um eine Funktion kopieren zu können
	private init(f: FunktionProt, fa: NSColor, l: String, b: Float, e: [String], s: Bool){
        self.interneFunktion = f
        self.latex = l
        self.farbe = fa
        self.breite = b
        self.sichtbar = true
		self.fehlerUndWarungen = e
		self.schwererFehler = s
    }
    
    ///Liefert eine Kopie der Funktion
    ///- Returns: Kopie der Funktion
    func copy() -> Funktion{
		return Funktion(f: interneFunktion, fa: farbe, l: latex, b: breite, e: fehlerUndWarungen, s: schwererFehler)
    }
	
	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {fatalError("nicht implementiert")}
}
