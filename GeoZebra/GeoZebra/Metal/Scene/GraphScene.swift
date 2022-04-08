//
//  CubeScene.swift
//  GeoZebra
//
//  Created by Benedict on 22.12.21.
//


import MetalKit

///Scene in der die Graphen gezeichnet werden
class GraphScene: MetalScene {
	var viewPortBegrenzungen: ViewPortBegrenzungen
	
	var lastUpdateId: UUID = UUID()
	var lastTextId = UUID()
	
	var renderedText: [Primitive] = [] //Array mit Zeichen->Primitives, die auf das Canvas gezeichnet sind
	
	//Als Ersatz für Objects:
	var funktionenNodes: [FunktionRenderNode] = []
	var koordinatenSystemRef: KoordinatenSystem
	
	var debugVar: Float = 0
	//MARK: Konstanten
	final let translateFactor: Float = -2.4
	
	init(device: MTLDevice, data: DataModel, viewPortBegrenzungen: ViewPortBegrenzungen) {
		self.viewPortBegrenzungen = viewPortBegrenzungen
		self.koordinatenSystemRef = KoordinatenSystem(withDevice: device, data: data)
		super.init(device: device)
		
		//MARK: Konfiguriere Koordinatensystem
		koordinatenSystemRef.update()
		koordinatenSystemRef.translate(direction: SIMD3<Float>(0,0,translateFactor))
		add(child: koordinatenSystemRef)
		
		//MARK: Fügt Funktionen zur Renderqueue hinzu
		for funktionId in data.funktionenIds{
			if(data.funktionen[funktionId]!.sichtbar){
				let graph = FunktionRenderNode(dev: device, equation: data.funktionen[funktionId]!, viewPortBegrenzungen: viewPortBegrenzungen)
				graph.translate(direction: SIMD3<Float>(0,0,translateFactor))
				graph.calculate()
				funktionenNodes.append(graph)
				add(child: graph)
			}
		}
	}
	
	override func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
		if(viewPortBegrenzungen.updateId != lastUpdateId){
			updateFunktionen()
			lastUpdateId = viewPortBegrenzungen.updateId
		}
		renderText()
		super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
	}
	
	private func updateFunktionen(){
		funktionenNodes.forEach({$0.calculate()})
		koordinatenSystemRef.update()
//		print("Anzahl verticies: \(self.koordinatenSystemRef.vertices.count) +\(self.funktionenNodes.map({$0.vertices.count}).reduce(0, +)) + \(self.renderedText.map({$0.vertices.count}).reduce(0, +))")
	}
	
	///Rendert den Text zur Canvas
	private func renderText(){
		if(lastTextId != viewPortBegrenzungen.textId){
			for primitive in renderedText{
				remove(child: primitive)
			}
			renderedText = []
			for zahl in viewPortBegrenzungen.text{
				let primitives = zahl.getPrimitives(device: device, viewPortBegrenzungen: viewPortBegrenzungen)
				for primitive in primitives {
					primitive.translate(direction: SIMD3<Float>(0,0,translateFactor+0.000001))
					add(child: primitive)
					renderedText.append(primitive)
				}
			}
			lastTextId = viewPortBegrenzungen.textId
		}
	}
}
