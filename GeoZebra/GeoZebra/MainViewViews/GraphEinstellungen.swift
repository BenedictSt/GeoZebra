//
//  GraphEinstellungen.swift
//  GeoZebra
//
//  Created by Benedict on 24.01.22.
//

import Foundation
import SwiftUI

struct GraphEinstellungen: View{
	@Binding var zeigekoordinateneinstellungen: Bool
	@ObservedObject var viewPortBegrenzungen: ViewPortBegrenzungen
	@State var links = ""
	@State var rechts = ""
	@State var unten = ""
	@State var oben = ""
	
	private func loadCurrentSettings(){
		self.links = "\(viewPortBegrenzungen.links.round(places: 5))"
		self.rechts = "\(viewPortBegrenzungen.rechts.round(places: 5))"
		self.unten = "\(viewPortBegrenzungen.unten.round(places: 5))"
		self.oben = "\(viewPortBegrenzungen.oben.round(places: 5))"
	}
	
	var body: some View{
		VStack{
			//MARK: Zoomeinstellungen
			HStack{
				Button(action: {
					viewPortBegrenzungen.zoom(0.9)
				}){
					Image(systemName: "minus.magnifyingglass")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 20, height: 20)
				}
				.buttonStyle(.borderless)
				.foregroundColor(.accentColor)
				
				Button(action: {
					viewPortBegrenzungen.resetZoom()
				}){
					Image(systemName: "1.magnifyingglass")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 20, height: 20)
				}
				.buttonStyle(.borderless)
				.foregroundColor(.accentColor)
				
				Button(action: {
					viewPortBegrenzungen.zoom(1.1)
				}){
					Image(systemName: "plus.magnifyingglass")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 20, height: 20)
				}
				.buttonStyle(.borderless)
				.foregroundColor(.accentColor)
			}
			
			//MARK: Grenzeinstellungen
			VStack{
				TextField("oben", text: $oben, onCommit: {commitOben()})
					.frame(width: 100)
					.textFieldStyle(.roundedBorder)
					.multilineTextAlignment(.center)
				HStack{
					TextField("links", text: $links, onCommit: {commitLinks()})
						.frame(width: 100)
						.textFieldStyle(.roundedBorder)
						.multilineTextAlignment(.center)
					
					Button(action: {viewPortBegrenzungen.centerOrigin()}){Image(systemName: "dot.squareshape.split.2x2").resizable().frame(width: 20, height: 20)}
					.buttonStyle(.borderless)
					.foregroundColor(.accentColor)
					
					TextField("rechts", text: $rechts, onCommit: {commitRechts()})
						.frame(width: 100)
						.textFieldStyle(.roundedBorder)
						.multilineTextAlignment(.center)
				}
				TextField("unten", text: $unten, onCommit: {commitUnten()})
					.frame(width: 100)
					.textFieldStyle(.roundedBorder)
					.multilineTextAlignment(.center)
			}
				.frame(width: 300, alignment: .center)
				.padding([.top, .bottom], 15)
			
			HStack(spacing: 20){
				Button(action: {viewPortBegrenzungen.normalizeToSquare()}){Image(systemName: "squareshape.split.3x3").resizable().frame(width: 20, height: 20)}.buttonStyle(.borderless).foregroundColor(.accentColor)
				Button(action: {viewPortBegrenzungen.resetGrenzen()}){Image(systemName: "arrow.counterclockwise").resizable().aspectRatio(contentMode: .fit).frame(width: 20, height: 20)}.buttonStyle(.borderless).foregroundColor(.accentColor)
				Button(action: {zeigekoordinateneinstellungen.toggle()}){Image(systemName: "gearshape.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 20, height: 20)}.buttonStyle(.borderless).foregroundColor(.accentColor).keyboardShortcut("k")
			}
		}
		.onAppear(perform: {
			loadCurrentSettings()
		})
		.onChange(of: viewPortBegrenzungen.updateId, perform: {_ in
			loadCurrentSettings()
		})
	}
	
	private func getGrenzwertAsFloat(str: String) -> Float?{
		let allowedChars = "0123456789,.-"
		let correctedString = String(str.map({allowedChars.contains($0) ? $0 : Character("")})).replacingOccurrences(of: ",", with: ".")
		return Float(correctedString)
	}
	
	private func commitLinks(){
		if let neueGrenze = getGrenzwertAsFloat(str: links){
			viewPortBegrenzungen.setzteLinks(neueGrenze)
		}
		loadCurrentSettings()
	}
	
	private func commitRechts(){
		if let neueGrenze = getGrenzwertAsFloat(str: rechts){
			viewPortBegrenzungen.setzteRechts(neueGrenze)
		}
		loadCurrentSettings()
	}
	
	private func commitUnten(){
		if let neueGrenze = getGrenzwertAsFloat(str: unten){
			viewPortBegrenzungen.setzteUnten(neueGrenze)
		}
		loadCurrentSettings()
	}
	
	private func commitOben(){
		if let neueGrenze = getGrenzwertAsFloat(str: oben){
			viewPortBegrenzungen.setzteOben(neueGrenze)
		}
		loadCurrentSettings()
	}
}
