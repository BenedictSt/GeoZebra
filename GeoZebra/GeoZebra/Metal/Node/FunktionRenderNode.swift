//
//  line.swift
//  GeoZebra
//
//  Created by Benedict on 22.12.21.
//


import Foundation
import MetalKit

class FunktionRenderNode: Primitive {
	let funktion: Funktion
	let viewPortBegrenzungen: ViewPortBegrenzungen
	init(dev: MTLDevice, equation: Funktion,viewPortBegrenzungen: ViewPortBegrenzungen){
		self.funktion = equation
		self.viewPortBegrenzungen = viewPortBegrenzungen
		super.init(withDevice: dev)
	}
	
	///Falls der Graph niergends im Anzeigebereich definiert ist, muss ein Vectorset da sein, da verticies und indices nicht leer sein darf
	override func buildDefaultVertices() {
		vertices = [
			Vertex(position: SIMD3<Float>(-1,1,100000000), color: SIMD4<Float>(0,0,0,1)),
			Vertex(position: SIMD3<Float>(-1,-1,100000000), color: SIMD4<Float>(0,1,0,1)),
			Vertex(position: SIMD3<Float>(1,1,100000000), color: SIMD4<Float>(0,0,1,0.5)),
		]
		indices = [0,1,2]
	}

	func calculate() {
		let color = funktion.getFarbe()
		let unten: Float = viewPortBegrenzungen.links 	//untere Grenze
		let oben: Float = viewPortBegrenzungen.rechts	//obere Grenze
		let seitenVerhaeltniss = viewPortBegrenzungen.seitenverhaeltnis
		let numberOfPoints = 100*viewPortBegrenzungen.precision
		let lineWidth: Float = 0.000106 * funktion.breite + 0.0029
		
		//clear
		vertices = []
		indices = []
		
		//Das hier ist wichtig, da Funktionen vorher nicht auf Definitionslücken getestet werden.
		//Wenn eine Funktion an x0 nicht definiert ist, x0 aber zwischen gezeichneten Punkten liegt,
		//würde über die Definitionslücke drüber gezeichnet werden. Daher wird getestet und bei einem "unnormal"
		//hohen wert der Differenz des neuen und letzten Punktes die beiden Punkte nicht verbundne werden
		var mSum: Float = 0 //Summe der momentanen Änderungsrate in den gezeichneten Punkten
		var mCount = 0 //Anzahl der gezeichneten Punkte
		
		for i in (0..<numberOfPoints){
			let x = unten + ((oben-unten) / Float(numberOfPoints-1))*Float(i)
			let y = funktion.calculate(x: x)
			
			//Das hier ist da, weil der Durchmesser einer Funktion konstant bleiben soll und daher
			//von der Ableitung abhängig ist.
			let m:Float = funktion.ableitungY(x: x) //momentane Änderungsrate
			let xWidthOffset = (lineWidth / sqrt(m*m+1))
			let yWidthOffset = (xWidthOffset * m)
			
			let position = viewPortBegrenzungen.transfromPoint(vector: SIMD3<Float>(x,y,0))
			let position2 = position + SIMD3<Float>(-yWidthOffset,+xWidthOffset/seitenVerhaeltniss,0)
			
			vertices.append(Vertex(position: position, color: color)) // top
			vertices.append(Vertex(position: position2, color: color)) // bottom
			if(!m.isNaN){
				mSum += abs(m)
				mCount += 1
			}
			let avgM = mSum / Float(mCount+1)
		
			//Sucht Definitionslücken:
			//Wenn die Steigung viel größer ist als "normal", dann werden die punkte nicht verbunden
			if(i != 0 && abs(m) <= abs(avgM)*20){
				//Verbinde die Punkte
				let index0 = i * 2 + 1
				indices.append(contentsOf: [
					UInt16(index0-3),
					UInt16(index0-2),
					UInt16(index0-1),

					UInt16(index0-2),
					UInt16(index0-1),
					UInt16(index0)
				])
			}
		}
		
		if(indices.isEmpty){
			buildDefaultVertices() //Weil darf nicht leer sein!
		}
		
		super.buildBuffers(device: dev)
		super.buildPipelineState(device: dev)
		super.buildDepthStencil(device: dev)
	}
}
