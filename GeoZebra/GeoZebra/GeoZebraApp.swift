//
//  GeoZebraApp.swift
//  GeoZebra
//
//  Created by Benedict on 22.12.21.
//

import SwiftUI

@main
struct GeoZebraApp: App {
	@AppStorage("geozebra_hasAgreedToLicense", store: .standard) var agreedLicense: Bool = false
	
	@State var resetGraph = UUID()
	@ObservedObject var data: DataModel = DataModel()
	@State var zeigeAppEinstellungen = false {
		didSet{
			data.update = UUID()
		}
	}
	
	var body: some Scene {
		WindowGroup{
			MainView(resetGraph: $resetGraph, data: data, zeigeAppEinstellungen: $zeigeAppEinstellungen)
				.frame(minWidth: 1400, idealWidth: 1500, maxWidth: 3000, minHeight: 800, idealHeight: 1000, maxHeight: 2000, alignment: .center)
				.environment(\.colorScheme, .light)
				.preferredColorScheme(.light)
				.onAppear {
					NSWindow.allowsAutomaticWindowTabbing = false
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
						resetGraph = UUID()
						data.update = UUID()
					}
				}
		}
		.commands {
			CommandGroup(replacing: .appSettings, addition: {
				Button(action: {zeigeAppEinstellungen.toggle()}){Text("Einstellungen")}.keyboardShortcut(",", modifiers: [.command])
			})
			CommandMenu("Graph", content: {
				if(agreedLicense){
					Button(action: {resetGraph = UUID(); data.update = UUID()}){Text("Neu Laden")}.keyboardShortcut("r", modifiers: [.command, .option])
				VStack{
					Text("Achsen:")
					Button(action: {data.viewPortBegrenzungen.scrollX(-0.5)}){Text("Rechts")}.keyboardShortcut(.rightArrow, modifiers: [.command])
					Button(action: {data.viewPortBegrenzungen.scrollX(0.5)}){Text("Links")}.keyboardShortcut(.leftArrow, modifiers: [.command])
					Button(action: {data.viewPortBegrenzungen.scrollY(0.5)}){Text("Oben")}.keyboardShortcut(.upArrow, modifiers: [.command])
					Button(action: {data.viewPortBegrenzungen.scrollY(-0.5)}){Text("Unten")}.keyboardShortcut(.downArrow, modifiers: [.command])
					Divider()
					Button(action: {data.viewPortBegrenzungen.resetGrenzen()}){Text("Reset Achsen")}.keyboardShortcut("r", modifiers: [.command])
					Button(action: {data.viewPortBegrenzungen.centerOrigin()}){Text("Zentrieren")}.keyboardShortcut(".", modifiers: [.command])
					Button(action: {data.viewPortBegrenzungen.normalizeToSquare()}){Text("Equalize Achsen")}.keyboardShortcut("#", modifiers: [.command])
				}
				Text("Zoom:")
				Button(action: {data.viewPortBegrenzungen.zoom(1.1)}){Text("Zoom Out")}.keyboardShortcut("+", modifiers: [.command])
				Button(action: {data.viewPortBegrenzungen.zoom(0.9)}){Text("Zoom In")}.keyboardShortcut("-", modifiers: [.command])
				Button(action: {data.viewPortBegrenzungen.resetZoom()}){Text("Reset Zoom")}.keyboardShortcut("0", modifiers: [.command])
				}
			})
			CommandGroup(replacing: .newItem) {}
		}
	}
}
