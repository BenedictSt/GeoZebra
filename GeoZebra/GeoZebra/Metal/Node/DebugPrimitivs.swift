//
//  DebugPrimitivs.swift
//  GeoZebra
//
//  Created by Benedict on 02.01.22.
//

import Foundation
import MetalKit

///Einfach nur ein Primitive zum Testen und Debuggen
class DebugPrimitive: Primitive {
	
	let viewPortBegrenzungen: ViewPortBegrenzungen
	
	init(withDevice device: MTLDevice, viewPortBegrenzungen: ViewPortBegrenzungen) {
		self.viewPortBegrenzungen = viewPortBegrenzungen
		super.init(withDevice: device)
	}
	
	override func buildDefaultVertices() {
		vertices = [
			Vertex(position: SIMD3<Float>(-1,1,0), color: SIMD4<Float>(1,0,0,1)),
			Vertex(position: SIMD3<Float>(-1,-1,0), color: SIMD4<Float>(1,0,0,1)),
			Vertex(position: SIMD3<Float>(1,1,0), color: SIMD4<Float>(0,0,1,1)),
			Vertex(position: SIMD3<Float>(1,-1,0), color: SIMD4<Float>(0,1,0,1)),
		]
		indices = [
			0,1,2,	1,2,3
		]
	}
	
	func update(){
		let oben = viewPortBegrenzungen.oben // - 3.4
		let unten = viewPortBegrenzungen.unten // + 3.5
		let rechts = viewPortBegrenzungen.rechts // - 2.4
		let links = viewPortBegrenzungen.links // + 7
		
		vertices = [
			Vertex(position: SIMD3<Float>(links,oben,0), color: SIMD4(0,0,1,1)),
			Vertex(position: SIMD3<Float>(links,unten,0), color: SIMD4(1,0,0,1)),
			Vertex(position: SIMD3<Float>(rechts,oben,0), color: SIMD4(1,1,0,1)),
			Vertex(position: SIMD3<Float>(rechts,unten,0), color: SIMD4(0,1,0,1)),
		]
		
		indices = [
			0,1,2,
			1,2,3
		]
		
		super.buildBuffers(device: dev)
		super.buildPipelineState(device: dev)
		super.buildDepthStencil(device: dev)
	}
}
