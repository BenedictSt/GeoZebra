//
//  FunktionsEinstellungen.swift
//  GeoZebra
//
//  Created by Benedict on 30.12.21.
//

import SwiftUI

struct FunktionsEinstellungen: View {
	
	let data: DataModel
	@State var choosenColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
	@State var choosenWidth: Float = 0
	
	@ObservedObject var fEConfig = funktionsEditorConfig
	
	func viewLoaded(){
		if let funktionsId = fEConfig.funktionId{
			self.choosenColor = data.funktionen[funktionsId]!.farbe.cgColor
			self.choosenWidth = data.funktionen[funktionsId]!.breite
		}else{
			fEConfig.zeigeFunktionseinstellungen = false
		}
	}
    var body: some View {
		VStack{
			Text("Funktionseinstellungen")
				.font(.title3)
				.onChange(of: fEConfig.funktionId, perform: { _ in
					viewLoaded()
				})
				.onAppear(perform: {
					viewLoaded()
				})
			
			ColorPicker("Farbe:", selection: $choosenColor, supportsOpacity: false)
				.onChange(of: choosenColor, perform: { _ in
					data.funktionen[fEConfig.funktionId!]!.farbe = NSColor(cgColor: choosenColor)!
					fEConfig.updateId = UUID()
					data.viewPortBegrenzungen.update()
				})
			HStack{
				let defaultColors = [NSColor.red.cgColor,NSColor.green.cgColor,NSColor.blue.cgColor,NSColor.orange.cgColor]
				ForEach(defaultColors, id: \.self){ color in
					Circle()
						.foregroundColor(Color(color))
						.frame(width: 25, height: 25, alignment: .center)
						.onTapGesture {
							self.choosenColor = color
						}
				}
			}
			
			HStack{
				Text("Breite")
				Button(action: {
					self.choosenWidth = 50
				}){
					Image(systemName: "arrow.uturn.backward")
				}.buttonStyle(.borderless)
					.foregroundColor(.accentColor)
			}
			Slider(value: $choosenWidth, in: 1...200)
				.frame(width: 175)
				.onChange(of: choosenWidth, perform: { _ in
					data.funktionen[fEConfig.funktionId!]!.breite = self.choosenWidth
					data.viewPortBegrenzungen.update()
				})
			
			Button(action: {
				fEConfig.zeigeFunktionseinstellungen = false
				data.viewPortBegrenzungen.update()
			}){
				Text("Fertig")
					.foregroundColor(.black)
			}.keyboardShortcut(KeyEquivalent.escape, modifiers: [])
				
		}
			.padding(50)
			.background(Color(NSColor.windowBackgroundColor))
			.cornerRadius(20)
    }
}
