//
//  MetalViewWrapper.swift
//  GeoZebra
//
//  Created by Benedict on 22.12.21.
//


import Foundation
import SwiftUI

///Ein Wrapper  mit dem man ein MetalView(MTKView) in swiftUI anzeigen kann
struct MetalViewWrapper: NSViewRepresentable {
	let width: CGFloat
	let height: CGFloat
	let dataModel: DataModel
	let viewPortBegrenzungen: ViewPortBegrenzungen
	
	func makeNSView(context: Context) -> NSView {
		let view = NSView(frame: NSRect(x: 0, y: 0, width: width, height: height))
		viewPortBegrenzungen.setSeitenverhaeltnis(width: Float(width), height: Float(height))
		view.addSubview(MetalView(frame: NSRect(x: 0, y: 0, width: width, height: height), data: dataModel, viewPortBegrenzungen: viewPortBegrenzungen))	
		
		return view
	}
	
	func updateNSView(_ nsView: NSView, context: Context) {
		nsView.frame = NSRect(x: 0, y: 0, width: 500, height: 500)
	}
}
