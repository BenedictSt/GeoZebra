//
//  MetalView.swift
//  GeoZebra
//
//  Created by Benedict on 22.12.21.
//

import MetalKit

class MetalView: MTKView {
	var renderer: Renderer!
	var data: DataModel
	var viewPortBegrenzungen: ViewPortBegrenzungen
	
	init(frame frameRect: CGRect, data: DataModel, viewPortBegrenzungen: ViewPortBegrenzungen) {
		guard let defaultDevice = MTLCreateSystemDefaultDevice() else {
			fatalError("Device loading error")
		}
		self.data = data
		self.viewPortBegrenzungen = viewPortBegrenzungen
		super.init(frame: frameRect, device: defaultDevice)
	}
	
	required init(coder: NSCoder) {
		self.data = DataModel()
		self.viewPortBegrenzungen = ViewPortBegrenzungen()
		super.init(coder: coder)
	}
	
	func createRenderer(device: MTLDevice){
		renderer = Renderer(device: device, data: data, viewPortBegrenzungen: viewPortBegrenzungen)
		delegate = renderer
	}
	
	override func viewDidMoveToWindow() {
		guard let defaultDevice = MTLCreateSystemDefaultDevice() else {
			fatalError("Device loading error")
		}
		device = defaultDevice
		depthStencilPixelFormat = .depth32Float
		colorPixelFormat = .bgra8Unorm
		clearColor = MTLClearColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
		preferredFramesPerSecond = viewPortBegrenzungen.fps
		createRenderer(device: defaultDevice)
	}
	
	
	func update(){
		renderer = Renderer(device: self.device!, data: data, viewPortBegrenzungen: viewPortBegrenzungen)
		delegate = renderer
	}
	
	override func scrollWheel(with event: NSEvent) {
		let zoomFactorInverse: Float = 1.0 / viewPortBegrenzungen.zoomFactor
		viewPortBegrenzungen.scrollY(Float((event.cgEvent?.getDoubleValueField(.scrollWheelEventDeltaAxis1))! / 10) * zoomFactorInverse)
		viewPortBegrenzungen.scrollX(Float((event.cgEvent?.getDoubleValueField(.scrollWheelEventDeltaAxis2))! / 10) * zoomFactorInverse)
	}
	
	override func rightMouseDown(with event: NSEvent) {
		//Wählt die Funktion unter dem Mauszeiger aus
		let xInWindow = ((event.locationInWindow.x-300) / self.frame.width) * 2 - 1
		let yInWindow = ((event.locationInWindow.y) / (self.frame.height - 20)) * 2 - 1
		let koordinatenLocationX = viewPortBegrenzungen.transformPointReversed(x: Float(xInWindow), y: Float(yInWindow)).x
		let koordinatenLocationY = viewPortBegrenzungen.transformPointReversed(x: Float(xInWindow), y: Float(yInWindow)).y + 0.2
		let functionId = data.findFunctionAtPoint(x: koordinatenLocationX, y: koordinatenLocationY)
		if let functionId = functionId {
			funktionsEditorConfig.funktionId = functionId
		}else{
			funktionsEditorConfig.funktionId = nil
		}
	}
	
	override func mouseDragged(with event: NSEvent) {
		let deltaX = event.deltaX / self.frame.width
		viewPortBegrenzungen.scrollX(percent: Float(deltaX) )
		let deltaY = event.deltaY / self.frame.height
		viewPortBegrenzungen.scrollY(percent: Float(deltaY))
	}
	
	override func magnify(with event: NSEvent) {
		viewPortBegrenzungen.zoom(Float(1 + event.magnification))
	}
}
