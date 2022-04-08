//
//  GeoZebraPreferences.swift
//  GeoZebra
//
//  Created by Benedict on 29.01.22.
//

import SwiftUI

struct GeoZebraPreferences: View {
	@Binding var zeigeAppEinstellungen: Bool
	@AppStorage("geozebra_prefered_fps", store: .standard) var preferedFps: Int = 20
	@AppStorage("geozebra_prefered_precision", store: .standard) var preferedPrecision: Int = 50
	@AppStorage("geozebra_prefered_animation_precision", store: .standard) var preferedAnimation: Int = 10
	
	@State var showCredits = false
	
	var body: some View {
		if(showCredits){
			CreditsView(zeigeCredits: $showCredits)
		}else{
			VStack{
				Text("Einstellungen:")
					.font(.title2)
					.padding(.bottom, 20)
				
				//MARK: FPS
				HStack{
					Image(systemName: "speedometer")
						.font(.title3)
						.frame(width: 20, alignment: .leading)
					Text("FPS: \(preferedFps)")
						.frame(width: 110, alignment: .leading)
					Slider(value: fpsProxy, in: 10...30)
						.frame(width: 150)
					Button(action: {preferedFps = 20}){Image(systemName: "arrow.uturn.backward.circle.fill")}.buttonStyle(.borderless)
				}
				
				//MARK: Genauigkeit
				HStack{
					Image(systemName: preferedPrecision < 50 ? "dial.min" : "dial.max")
						.font(.title3)
						.frame(width: 20, alignment: .leading)
					Text("Genauigkeit: \(preferedPrecision)%")
						.frame(width: 110, alignment: .leading)
					Slider(value: precisionProxy, in: 1...99)
						.frame(width: 150)
					Button(action: {preferedPrecision = 50}){Image(systemName: "arrow.uturn.backward.circle.fill")}.buttonStyle(.borderless)
				}
				
				//MARK: Animation Genauigkeit
				HStack{
					Image(systemName: "speedometer")
						.font(.title3)
						.frame(width: 20, alignment: .leading)
					Text("Animation Ticks: \(preferedAnimation)%")
						.frame(width: 110, alignment: .leading)
					Slider(value: animationProxy, in: 1...100)
						.frame(width: 150)
					Button(action: {preferedAnimation = 10}){Image(systemName: "arrow.uturn.backward.circle.fill")}.buttonStyle(.borderless)
				}
				
				Button(action: {
					showCredits = true
				}, label: {
					Text("Credits")
				})
				
				Button(action: {
					zeigeAppEinstellungen = false
				}){Text("Fertig")}
					.buttonStyle(.bordered)
					.padding(.top, 20)
					.keyboardShortcut(KeyEquivalent.escape, modifiers: [])
			}
		}
	}
	
	var fpsProxy: Binding<Double>{
		Binding<Double>(get: {
			return Double(preferedFps)
		}, set: {
			preferedFps = Int($0)
		})
	}
	var precisionProxy: Binding<Double>{
		Binding<Double>(get: {
			return Double(preferedPrecision)
		}, set: {
			preferedPrecision = Int($0)
		})
	}
	
	var animationProxy: Binding<Double>{
		Binding<Double>(get: {
			return Double(preferedAnimation)
		}, set: {
			preferedAnimation = Int($0)
		})
	}
}

fileprivate struct CreditsView: View{
	@Binding var zeigeCredits: Bool
	@State var selectedCredit: creditItem? = nil
	var body: some View{
		ZStack{
			Button(action: {
				zeigeCredits = false
			}){
				Text("zurück")
			}.position(x: 60, y: 40)
			
			ScrollView(showsIndicators: false){
				VStack(spacing: 30){
					ForEach(creditList, id: \.self){ credit in
						VStack(alignment: .leading, spacing: 10){
							Color.clear
								.frame(height: 2)
							Text(credit.name)
								.font(.title.bold())
							
							Button(action: {
								//expand credit
								if( selectedCredit == credit){
									selectedCredit = nil
								}else{
									selectedCredit = credit
								}
							}){
								Text("\(credit.licenceShort) \(selectedCredit != credit ? "􀆈" : "􀆇")")
									.font(.body)
									.foregroundColor(.secondary)
							}.buttonStyle(BorderlessButtonStyle())
							
							if(selectedCredit == credit){
								ZStack{
									Text(credit.licenceLong)
										.multilineTextAlignment(.leading)
										.padding(20)
										.foregroundColor(.black)
								}
								.background(Color(red: 0.84, green: 0.84, blue: 0.84, opacity: 1.0)) // #d7d7d7
								.cornerRadius(10)
							}
							
							Button(action: {
								//open in Safari
								guard let url = URL(string: credit.link) else { return }
								NSWorkspace.shared.open(url)
								
							}){
								HStack(spacing: 3){
									Text("􀎬")
										.foregroundColor(.blue)
									Text("\(credit.link)")
										.underline()
										.foregroundColor(.blue)
								}
							}.buttonStyle(BorderlessButtonStyle())
						}.padding([.leading, .trailing], 30)
						Color.clear
							.frame(height: 2)
					}
				}
			}
			.padding(.top, 60)
		}
	}
}
