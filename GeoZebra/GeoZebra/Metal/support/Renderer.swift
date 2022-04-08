//
//  Renderer.swift
//  GeoZebra
//
//  Created by Benedict on 22.12.21.
//


import MetalKit

class Renderer: NSObject {
    var commandQueue: MTLCommandQueue!
    var scenes: [MetalScene] = []
	let data: DataModel
	let viewPortBegrenzungen: ViewPortBegrenzungen
	
	init(device: MTLDevice, data: DataModel, viewPortBegrenzungen: ViewPortBegrenzungen) {
		self.data = data
		self.viewPortBegrenzungen = viewPortBegrenzungen
        super.init()
        createCommandQueue(device: device)
        scenes.append(GraphScene(device: device, data: data, viewPortBegrenzungen: viewPortBegrenzungen))
		
    }
    
    //MARK: Builders
    func createCommandQueue(device: MTLDevice) {
        commandQueue = device.makeCommandQueue()
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
    
    func draw(in view: MTKView) {
        // Get the current drawable and descriptor
        guard let drawable = view.currentDrawable,
            let renderPassDescriptor = view.currentRenderPassDescriptor else {
                return
        }
        // Create a buffer from the commandQueue
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
       
        let deltaTime = 1 / Float(view.preferredFramesPerSecond)
        
        scenes.forEach{ $0.render(commandEncoder: commandEncoder!,
                                  deltaTime: deltaTime) }
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
