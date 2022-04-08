//
//  line.swift
//  GeoZebra
//
//  Created by Benedict on 22.12.21.
//


import Foundation
import MetalKit

class KoordinatenSystem: Primitive {
	
	let data: DataModel
	let viewPortBegrenzungen: ViewPortBegrenzungen
	let koordinatenSettings: KoordinatenSettings
	
	init(withDevice device: MTLDevice, data: DataModel) {
		self.data = data
		self.viewPortBegrenzungen = data.viewPortBegrenzungen
		self.koordinatenSettings = data.koordinatenSettings
		super.init(withDevice: device)
	}
	
	override func buildDefaultVertices() {
		vertices = [
			Vertex(position: SIMD3<Float>(-1,1,1000), color: SIMD4<Float>(0,0,0,1)),//rot
			Vertex(position: SIMD3<Float>(-1,-1,1000), color: SIMD4<Float>(0,1,0,1)),//grün
			Vertex(position: SIMD3<Float>(1,1,1000), color: SIMD4<Float>(0,0,1,0.5)),//blau
		]
		indices = [
			0,1,2
			
		]
	}
	
	///Damit die Liner "schöne" Vielfache / Teile von 1 sind
	private func rundeSteps(_ eigentlich: Float) -> Float {
		let hunderter = (2...50).map({Float($0) * 100})
		let fuenfer = (5...20).map({Float($0) * 5})
		let einer = (3...20).map({Float($0)})
		let bruchteile = (0...15).map({1 / Float(pow(Float(2), Float($0)))})
		let multiplesOfOne: [Float] = bruchteile.reversed() + [0.75, 1, 1.5, 2, 2.5] + einer + fuenfer + hunderter

		return multiplesOfOne.first(where: { $0 > eigentlich}) ?? eigentlich
	}
	
	func update(){
		viewPortBegrenzungen.text = [] //Clear all Displayed Text
		
		//Wenn kein Koordinatensystem nicht gezeichnet werden soll: clear und exit
		if(koordinatenSettings.markerLayout == 0){
			buildDefaultVertices()
			commit(scale: false)
			return
		}
		
		let renderText = koordinatenSettings.renderText
		
		let color = koordinatenSettings.color
		//Grenzen:
		let x0: Float = viewPortBegrenzungen.links
		let x1: Float = viewPortBegrenzungen.rechts
		let y0: Float = viewPortBegrenzungen.unten
		let y1: Float = viewPortBegrenzungen.oben
		
		let xReverseFactor: Float = viewPortBegrenzungen.getXreverse() //damit nach der Transformation die Koordinaten echte Canvas Koordinaten bleiben
		let yReverseFactor: Float = viewPortBegrenzungen.getYreverse() //damit nach der Transformation die Koordinaten echte Canvas Koordinaten bleiben
		let sV: Float = 1/viewPortBegrenzungen.seitenverhaeltnis //Das Seitenverhältnis
		
		
		let xNumberOfLiners: Int = 30
		let xLinerStep = rundeSteps(viewPortBegrenzungen.width / Float(xNumberOfLiners - 15))
		let xFirstLiner = Float(abs(viewPortBegrenzungen.links) - Float(abs(viewPortBegrenzungen.links).truncatingRemainder(dividingBy: xLinerStep)) ) * Float(viewPortBegrenzungen.links < 0 ? -1 : 1) - xLinerStep
		
		let yNumberOfLiners: Int = 30
		let yLinerStep = rundeSteps(viewPortBegrenzungen.height / Float(yNumberOfLiners - 10))
		let yFirstLiner = Float(abs(viewPortBegrenzungen.unten) - Float(abs(viewPortBegrenzungen.unten).truncatingRemainder(dividingBy: yLinerStep)) ) * Float(viewPortBegrenzungen.unten < 0 ? -1 : 1) - yLinerStep
		
		//Breiten
		let LineWidth: Float = koordinatenSettings.lineWidth
		let LinerWidth: Float = 0.005
		
		//MARK: -Achsen:
		vertices = [
			//X-Achse:
			Vertex(position: SIMD3<Float>(x0,0+LineWidth*yReverseFactor*sV,0), color: color),
			Vertex(position: SIMD3<Float>(x0,0-LineWidth*yReverseFactor*sV,0), color: color),
			Vertex(position: SIMD3<Float>(x1,0+LineWidth*yReverseFactor*sV,0), color: color),
			Vertex(position: SIMD3<Float>(x1,0-LineWidth*yReverseFactor*sV,0), color: color),
			
			//Y-Achse:
			Vertex(position: SIMD3<Float>(0+LineWidth*xReverseFactor,y0,0), color: color),
			Vertex(position: SIMD3<Float>(0-LineWidth*xReverseFactor,y0,0), color: color),
			Vertex(position: SIMD3<Float>(0+LineWidth*xReverseFactor,y1,0), color: color),
			Vertex(position: SIMD3<Float>(0-LineWidth*xReverseFactor,y1,0), color: color),
			
			//Pfeile:
			//x-Pfeil
			Vertex(position: SIMD3<Float>(x1,0,0), color: color),
			Vertex(position: SIMD3<Float>(x1-4*(LineWidth*4*xReverseFactor),0+(LineWidth*4*sV*yReverseFactor),0), color: color),
			Vertex(position: SIMD3<Float>(x1-4*(LineWidth*4*xReverseFactor),0-(LineWidth*4*sV*yReverseFactor),0), color: color),
			
			//y-Pfeil
			Vertex(position: SIMD3<Float>(0,y1,0), color: color),
			Vertex(position: SIMD3<Float>(0+LineWidth*4*xReverseFactor,y1-(LineWidth*12*sV*yReverseFactor),0), color: color),
			Vertex(position: SIMD3<Float>(0-LineWidth*4*xReverseFactor,y1-(LineWidth*12*sV*yReverseFactor),0), color: color),
		]
		indices = [
			0,1,2,	1,2,3,
			4,5,6,	5,6,7,
			8,9,10,
			11,12,13
		]

		//Fals keine Markierungen gezeichnet werden sollen
		if(koordinatenSettings.markerLayout == 1){
			commit()
			return
		}
		
		//MARK: -Markierungen
		var index = 13
		let markerColor = koordinatenSettings.markerColor
		
		//x liners
		for i in (0..<xNumberOfLiners){
			let xPos: Float = xFirstLiner + xLinerStep * Float(i)
			let zeroPoint = koordinatenSettings.markerLayout == 2 ? 0 : viewPortBegrenzungen.unten - 5
			let height = koordinatenSettings.markerLayout == 2 ? LinerWidth * 1.75 * sV : viewPortBegrenzungen.oben - viewPortBegrenzungen.unten + 20
			let newVertices = [
				Vertex(position: SIMD3<Float>(xPos+LinerWidth*xReverseFactor*0.35,zeroPoint+height*yReverseFactor,0), color: markerColor),
				Vertex(position: SIMD3<Float>(xPos+LinerWidth*xReverseFactor*0.35,zeroPoint-height*yReverseFactor,0), color: markerColor),
				Vertex(position: SIMD3<Float>(xPos-LinerWidth*xReverseFactor*0.35,zeroPoint+height*yReverseFactor,0), color: markerColor),
				Vertex(position: SIMD3<Float>(xPos-LinerWidth*xReverseFactor*0.35,zeroPoint-height*yReverseFactor,0), color: markerColor),
			]
			index += 4
			vertices.append(contentsOf: newVertices)
			if(i != 0){
				indices.append(contentsOf: [
					UInt16(index-3),
					UInt16(index-2),
					UInt16(index-1),
					
					UInt16(index-2),
					UInt16(index-1),
					UInt16(index)
				])
			}
			
			//Rendert Liner Wert zum Display
			if(renderText){
				let positionVonLiner = viewPortBegrenzungen.transfromPoint(vector: SIMD3<Float>(xPos,0,0))
				let zahlVonNachkommastellen = Int((-0.2 * viewPortBegrenzungen.width + 3).rounded())
				viewPortBegrenzungen.text.append(RenderNumber(zahl: xPos, position: positionVonLiner, nachkommastellen: zahlVonNachkommastellen))
			}
			
		}
		
		//y liners
		for i in (0..<yNumberOfLiners){
			let yPos: Float = yFirstLiner + yLinerStep * Float(i)
			let zeroPoint = koordinatenSettings.markerLayout == 2 ? 0 : viewPortBegrenzungen.links - 5
			let width = koordinatenSettings.markerLayout == 2 ? LinerWidth * 1.75: viewPortBegrenzungen.rechts - viewPortBegrenzungen.links + 20
			let newVertices = [
				Vertex(position: SIMD3<Float>(zeroPoint+width*xReverseFactor,yPos+LinerWidth*sV*yReverseFactor*0.35,0), color: markerColor),
				Vertex(position: SIMD3<Float>(zeroPoint-width*xReverseFactor,yPos+LinerWidth*sV*yReverseFactor*0.35,0), color: markerColor),
				Vertex(position: SIMD3<Float>(zeroPoint+width*xReverseFactor,yPos-LinerWidth*sV*yReverseFactor*0.35,0), color: markerColor),
				Vertex(position: SIMD3<Float>(zeroPoint-width*xReverseFactor,yPos-LinerWidth*sV*yReverseFactor*0.35,0), color: markerColor),
			]
			index += 4
			vertices.append(contentsOf: newVertices)
			if(i != 0){
				indices.append(contentsOf: [
					UInt16(index-3),
					UInt16(index-2),
					UInt16(index-1),
					
					UInt16(index-2),
					UInt16(index-1),
					UInt16(index)
				])
			}
			
			//Rendert Liner Wert zum Display
			if(renderText){
				if(yPos != 0){
					let positionVonLiner = viewPortBegrenzungen.transfromPoint(vector: SIMD3<Float>(0,yPos,0))
					let zahlVonNachkommastellen = Int((-0.2 * viewPortBegrenzungen.height + 3).rounded())
					viewPortBegrenzungen.text.append(RenderNumber(zahl: yPos, position: positionVonLiner, anchor: .links, nachkommastellen: zahlVonNachkommastellen))
				}
			}
		}
		
		commit()
	}
	
	///normalisiert die Vektoren und updatet buffer
	private func commit(scale: Bool = true){
		if(scale){
			viewPortBegrenzungen.transformVectorSet(vertices: &vertices)
		}
		super.buildBuffers(device: dev)
		super.buildPipelineState(device: dev)
		super.buildDepthStencil(device: dev)
	}
}
