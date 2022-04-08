//
//  KoordinatenEinstellungenView.swift
//  GeoZebra
//
//  Created by Benedict on 18.01.22.
//

import Foundation
import SwiftUI

struct KoorinatenEinstellungenView: View{
	let data: DataModel
	@Binding var zeigeKoordinateneinstellungen: Bool
	@State var choosenColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
	@State var choosenMarkerColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
	@State var selectedLayout = 2
	
	
	func viewLoaded(){
		choosenColor = data.koordinatenSettings.colorUI
		choosenMarkerColor = data.koordinatenSettings.markerColorUI
		selectedLayout = data.koordinatenSettings.markerLayout
	}
	var body: some View {
		VStack(spacing: 20){
			Text("Koordinateneinstellungen:")
				.font(.title2)
				.onAppear(perform: {
					viewLoaded()
				})
			
			VStack{
				ColorPicker("Farbe:", selection: $choosenColor, supportsOpacity: false)
					.onChange(of: choosenColor, perform: { _ in
						data.koordinatenSettings.colorUI = choosenColor
						data.viewPortBegrenzungen.update()
						data.viewPortBegrenzungen.update()
					})
				HStack{
					let defaultColors = [NSColor.black.cgColor,CGColor(red: 0, green: 0.54, blue: 0.95, alpha: 1)]
					ForEach(defaultColors, id: \.self){ color in
						Circle()
							.foregroundColor(Color(color))
							.frame(width: 25, height: 25, alignment: .center)
							.onTapGesture {
								self.choosenColor = color
							}
					}
				}
			}
			
			HStack{
				LayoutView(selectedLayout: $selectedLayout, thisButton: 0)
				LayoutView(selectedLayout: $selectedLayout, thisButton: 1)
				LayoutView(selectedLayout: $selectedLayout, thisButton: 2)
				LayoutView(selectedLayout: $selectedLayout, thisButton: 3)
			}.onChange(of: selectedLayout, perform: { _ in
				data.koordinatenSettings.markerLayout = selectedLayout
				data.viewPortBegrenzungen.update()
			})
			
			ColorPicker("Marker:", selection: $choosenMarkerColor, supportsOpacity: false)
				.onChange(of: choosenMarkerColor, perform: { _ in
					data.koordinatenSettings.markerColorUI = choosenMarkerColor
					data.viewPortBegrenzungen.update()
				})
			
			Button(action: {
				zeigeKoordinateneinstellungen = false
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


fileprivate struct LayoutView: View{
	@Binding var selectedLayout: Int
	let thisButton: Int
	
	var body: some View{
		let isThisButton = selectedLayout == thisButton
		let widthHeight: CGFloat = isThisButton ? 38 : 35
		VStack(spacing: 2){
			Button(action: {
				selectedLayout = thisButton
			}){
				Image("KoordinatensystemButtons\(thisButton)")
					.resizable()
					.frame(width: widthHeight, height: widthHeight)
				
			}
			.buttonStyle(.borderless)
			.frame(width: widthHeight, height: widthHeight)
			
			Rectangle()
				.frame(width: 25, height: 2, alignment: .center)
				.foregroundColor(isThisButton ? .accentColor : .clear)
				.cornerRadius(2)
			
		}
	}
}
