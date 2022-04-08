//
//  Node.swift
//  GeoZebra
//
//  Created by Benedict on 22.12.21.
//


import MetalKit

class Node {
	var childern: [Node] = []
	
	func add(child: Node) {
		childern.append(child)
	}
	
	func remove(child: Node){
		childern.removeAll(where: {$0 === child})
	}
	
	func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
		childern.forEach{ $0.render(commandEncoder: commandEncoder, deltaTime: deltaTime) }
	}
}
