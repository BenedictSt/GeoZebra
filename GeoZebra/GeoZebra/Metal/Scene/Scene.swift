//
//  Scene.swift
//  GeoZebra
//
//  Created by Benedict on 22.12.21.
//

import MetalKit

class MetalScene: Node {
    var device: MTLDevice!
    var sceneConstraints = SceneConstraints()
    var objects: [Primitive] = []
    
    init(device: MTLDevice) {
        self.device = device
        super.init()
        sceneConstraints.projectionMatrix = matrix_float4x4(degreesFov: 45, aspectRatio: 1, nearZ: 0.1, farZ: 100)
		
    }
    
    override func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        commandEncoder.setVertexBytes(&sceneConstraints, length: MemoryLayout<SceneConstraints>.stride, index: 2)
        super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
    }
}
