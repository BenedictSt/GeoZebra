//
//  ViewPortBegrenzung.swift
//  GeoZebra
//
//  Created by Benedict on 19.01.22.
//

import Foundation

///Verwaltet die ViewPort Begrenzungen
class ViewPortBegrenzungen: ObservableObject{
	@Published public private(set) var updateId = UUID()
	
	//MARK: Grenzen
	public private(set) var links: Float = -3
	public private(set) var rechts: Float = 3
	public private(set) var unten: Float = -3
	public private(set) var oben: Float = 3
	
	public private(set) var zoomFactor: Float = 1
	public private(set) var seitenverhaeltnis: Float = 1 // 1:1 x:y; x = 1
	
	//MARK: Zum mappen von echten Koordinaten zu Canvas-Space
	private var xM: Float = 1	//multipliziere mit echtem x-Wert
	private var xN: Float = -1	//addiere zu echtem nach multiplizierten x-Wert
	private var yM: Float = 1	//multipliziere mit echtem y-Wert
	private var yN: Float = -1	//addiere zu echtem nach multiplizierten y-Wert
	
	//MARK: Text-Rendering
	var text: [RenderNumber] = [] {didSet{textId = UUID()}}//Array mit RenderNumberBuildern (updatet textId automatisch, wenn ein neuer Text hinzugefügt wird
	public private(set) var textId = UUID()
	
	//MARK: Andere
	public var fps: Int = 20
	public var precision: Int = 50
	
	///Muss aufgerufen werden, nachdem sich etwas geändert hat
	///- Wichtig, damit die GraphScene weiss, dass sie sich updaten muss
	///- Wichtig, damit die Werte, für die Transformation ausgeführt werden
	func update(){
		checkBounds()
		updateValuesForTransformation()
		updateId = UUID()
	}
	///Updated die Werte für die Transformation
	private func updateValuesForTransformation(){
		xM = (rechts - links) / 2
		xN = 1 - (rechts / xM)
		
		yM = (oben - unten) / 2
		yN = 1 - (oben / yM)
	}
	
	///Prüft und korrigiert ggf. wenn die Grenzen größer oder kleiner als das Minimum sind
	private func checkBounds(){
		let MAX: Float = 20_000
		let MIN: Float = 0.005
		if abs(links) > MAX {
			links = links.sign == .minus ? -MAX : MAX
		}else if abs(links) < MIN{
			links = links.sign == .minus ? -MIN : MIN
		}
		if abs(rechts) > MAX {
			rechts = rechts.sign == .minus ? -MAX : MAX
		}else if abs(rechts) < MIN{
			rechts = rechts.sign == .minus ? -MIN : MIN
		}
		if abs(oben) > MAX {
			oben = oben.sign == .minus ? -MAX : MAX
		}else if abs(oben) < MIN{
			oben = oben.sign == .minus ? -MIN : MIN
		}
		if abs(unten) > MAX {
			unten = unten.sign == .minus ? -MAX : MAX
		}else if abs(unten) < MIN{
			unten = unten.sign == .minus ? -MIN : MIN
		}
	}
	
	///Scrollt entlang der x-Achse
	///- Parameter deltaX: Wert um den gescrollt werden soll
	func scrollX(_ deltaX: Float){
		links -= deltaX
		rechts -= deltaX
		update()
	}
	
	///Scrollt entlang der x-Achse
	///- Parameter procent: Wert um wie viel Prozent von der Breite des Koordinatensystems gescrollt werden soll
	func scrollX(percent: Float){
		let deltaX = (rechts - links) * percent
		links -= deltaX
		rechts -= deltaX
		update()
	}
	
	///Scrollt entlang der y-Achse
	///- Parameter deltaY: Wert um den gescrollt werden soll
	func scrollY(_ deltaY: Float){
		unten += deltaY
		oben += deltaY
		update()
	}
	
	///Scrollt entlang der y-Achse
	///- Parameter procent: Wert um wie viel Prozent von der Höhe des Koordinatensystems gescrollt werden soll
	func scrollY(percent: Float){
		let deltaY = (oben - unten) * percent
		unten += deltaY
		oben += deltaY
		update()
	}
	
	///Zoomt.
	///- Parameter factor: Factor um den gezoomt werden soll
	func zoom(_ factor: Float){
		if(factor.sign == .minus){return}
		if(zoomFactor == 0){return}
		links /= factor
		rechts /= factor
		unten /= factor
		oben /= factor
		zoomFactor *= factor
		update()
	}
	
	///Setzt den Zoom wert auf den Ursprungswert (100%)
	func resetZoom(){
		zoom(1/zoomFactor)
		update()
	}
	
	///Setzt das Seitenverhältnis (wichtig fürs mapping)
	///- Parameter width: Breite des MetalViews
	///- Parameter height: Höhe des MetalViews
	func setSeitenverhaeltnis(width: Float, height: Float){
		self.seitenverhaeltnis =  1 / (width / height)
	}
	
	///Macht, dass eine x-Einheit gleich viele Pixel groß ist wie eine y-Einheit (1:1)
	func normalizeToSquare(){
		let newHeight = width * seitenverhaeltnis
		let middle = unten + (height * 0.5)
		oben = middle + (newHeight * 0.5)
		unten = middle - (newHeight * 0.5)
		update()
	}
	
	///Zentriert den Graphen auf den Ursprung
	func centerOrigin(){
		oben = (oben - unten) / 2
		unten = -oben
		rechts = (rechts - links) / 2
		links = -rechts
		update()
	}
	
	init(){
		update()
	}
}

///Erweiterung, die Methoden zur Verfügung stellt um von echten Koordinaten zu Canvas space zu mappen
extension ViewPortBegrenzungen{
	func transformPoint(x: Float, y: Float) -> (x: Float, y: Float){
		let xE = x / xM + xN
		let yE = y / yM + yN
		return (x: xE, y: yE)
	}
	
	func transfromPoint(vector: SIMD3<Float>) -> SIMD3<Float>{
		return vector / SIMD3<Float>(xM, yM, 1) + SIMD3<Float>(xN, yN, 0) //nutzt SIMD Operationen, da diese schneller sind
	}
	
	func transformPointSet(points: inout [SIMD3<Float>]){
		for index in points.indices{
			points[index] = transfromPoint(vector: points[index])
		}
	}
	
	func transformVectorSet(vertices: inout [Vertex]){
		for index in vertices.indices{
			vertices[index].position = transfromPoint(vector: vertices[index].position)
		}
	}
	
	func getXreverse() -> Float{
		return xM
	}
	
	func getYreverse() -> Float{
		return yM
	}
	
	///von canvas space zu koordinatenspace
	func transformPointReversed(x: Float, y: Float) -> (x: Float, y: Float){
		let xE = (x - xN) * xM
		let yE = (y - yN) * yM
		return (x: xE, y: yE)
	}
}


///Erweiterung um die Grenzen manuell zu setzen
extension ViewPortBegrenzungen{
	
	///Setzt neuen Wert für die linke Grenze
	///- Parameter neueGrenze: neue linke Grenze
	func setzteLinks(_ neueGrenze: Float) {
		if(neueGrenze >= rechts){
			messagePublisher.sendeNachricht("untere Grente darf nicht größer sein als obere Grenze", farbe: .red)
			return
		}
		links = neueGrenze
		update()
	}
	
	///Setzt neuen Wert für die rechte Grenze
	///- Parameter neueGrenze: neue rechte Grenze
	func setzteRechts(_ neueGrenze: Float) {
		if(neueGrenze <= links){
			messagePublisher.sendeNachricht("obere Grente darf nicht kleiner sein als untere Grenze", farbe: .red)
			return
		}
		rechts = neueGrenze
		update()
	}
	
	
	///Setzt neuen Wert für die untere Grenze
	///- Parameter neueGrenze: neue untere Grenze
	func setzteUnten(_ neueGrenze: Float) {
		if(neueGrenze >= oben){
			messagePublisher.sendeNachricht("untere Grente darf nicht größer sein als obere Grenze", farbe: .red)
			return
		}
		unten = neueGrenze
		update()
	}
	
	///Setzt neuen Wert für die obere Grenze
	///- Parameter neueGrenze: neue obere Grenze
	func setzteOben(_ neueGrenze: Float) {
		if(neueGrenze <= unten){
			messagePublisher.sendeNachricht("obere Grente darf nicht kleiner sein als untere Grenze", farbe: .red)
			return
		}
		oben = neueGrenze
		update()
	}
	
	func resetGrenzen(){
		unten = -3
		oben = 3
		rechts = 3
		links = -3
		zoomFactor = 1
		update()
	}
}

extension ViewPortBegrenzungen{
	///Breite des Koordinatensystems abs(rechts - links)
	var width: Float {
		get{
			return abs(rechts - links)
		}
	}
	
	///Höhe des Koordinatensystems abs(oben - unten)
	var height: Float {
		get{
			return abs(oben - unten)
		}
	}
}
