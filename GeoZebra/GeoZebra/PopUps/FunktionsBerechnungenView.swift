//
//  FunktionsBerechnungenView.swift
//  GeoZebra
//
//  Created by Benedict on 22.01.22.
//

import Foundation
import SwiftUI

struct FunktionsBerechnungView: View{
	let data: DataModel
	@ObservedObject var fEConfig = funktionsEditorConfig
	
	func viewLoaded(){
		
	}
	
	@State var yWertInput = ""
	@State var yWertOutput = ""
	
	@State var ableitungInput = ""
	@State var ableitungOutput = ""
	
	@State var integralUntenInput = ""
	@State var integralObenInput = ""
	@State var integralOutput = ""
	
	@State var flaecheUntenInput = ""
	@State var flaecheObenInput = ""
	@State var flaecheOutput = ""
	
	var body: some View {
		VStack(spacing: 15){
			Text("Funktionsberechnungen:")
				.font(.title2)
				.padding(.bottom, 20)
				.onAppear(perform: {
					viewLoaded()
				})
			
			//yWert
			HStack(spacing: 0){
				Text("y = f(")
				TextField("x", text: $yWertInput, onCommit: {
					if let number = Float(yWertInput.replacingOccurrences(of: ",", with: ".")){
						yWertOutput = "\(data.funktionen[fEConfig.funktionId!]!.calculate(x:number))"
					}
				}).onChange(of: yWertInput, perform: {_ in yWertOutput = ""})
					.frame(width: 60)
					.multilineTextAlignment(.center)
					.textFieldStyle(.plain)
					.font(.body.bold())
				Text(")")
				Button(action: {
					if let number = Float(yWertInput.replacingOccurrences(of: ",", with: ".")){
						yWertOutput = "\(data.funktionen[fEConfig.funktionId!]!.calculate(x:number))"
					}}){Image(systemName: "equal.circle")}.buttonStyle(.borderless)
					.padding([.leading, .trailing], 5)
				Text("\(yWertOutput.replacingOccurrences(of: "nan", with: "undefiniert"))")
			}
			
			//Ableitung
			HStack(spacing: 0){
				Text("d/dx: f'(")
				TextField("x", text: $ableitungInput, onCommit: {
					if let number = Float(ableitungInput.replacingOccurrences(of: ",", with: ".")){
						ableitungOutput = "\(data.funktionen[fEConfig.funktionId!]!.ableitungY(x:number))"
					}
				}).onChange(of: ableitungInput, perform: {_ in ableitungOutput = ""})
					.frame(width: 60)
					.multilineTextAlignment(.center)
					.textFieldStyle(.plain)
					.font(.body.bold())
				Text(")")
				Button(action: {
					if let number = Float(ableitungInput){
					ableitungOutput = "\(data.funktionen[fEConfig.funktionId!]!.ableitungY(x:number))"
					}}){Image(systemName: "equal.circle")}.buttonStyle(.borderless)
					.padding([.leading, .trailing], 5)
				Text("\(ableitungOutput.replacingOccurrences(of: "nan", with: "undefiniert"))")
			}
			
			//MARK: Integral
			HStack(spacing: 0){
				Text("Integral: I [")
				TextField("unten", text: $integralUntenInput, onCommit: {berechneIntegral()})
					.onChange(of: integralUntenInput, perform: {_ in integralOutput = ""})
					.frame(width: 60)
					.multilineTextAlignment(.center)
					.textFieldStyle(.plain)
					.font(.body.bold())
				Text(", ")
				TextField("oben", text: $integralObenInput, onCommit: {berechneIntegral()})
					.onChange(of: integralObenInput, perform: {_ in integralOutput = ""})
					.frame(width: 60)
					.multilineTextAlignment(.center)
					.textFieldStyle(.plain)
					.font(.body.bold())
				Text("]")
				Button(action: {berechneIntegral()}){Image(systemName: "equal.circle")}.buttonStyle(.borderless)
					.padding([.leading, .trailing], 5)
				Text("\(integralOutput.replacingOccurrences(of: "nan", with: "undefiniert"))")
			}
			
			//MARK: Fläche
			HStack(spacing: 0){
				Text("Fläche: A [")
				TextField("unten", text: $flaecheUntenInput, onCommit: {berechneFlaeche()})
					.onChange(of: flaecheUntenInput, perform: {_ in flaecheOutput = ""})
					.frame(width: 60)
					.multilineTextAlignment(.center)
					.textFieldStyle(.plain)
					.font(.body.bold())
				Text(", ")
				TextField("oben", text: $flaecheObenInput, onCommit: {berechneFlaeche()})
					.onChange(of: flaecheObenInput, perform: {_ in flaecheOutput = ""})
					.frame(width: 60)
					.multilineTextAlignment(.center)
					.textFieldStyle(.plain)
					.font(.body.bold())
				Text("]")
				Button(action: {berechneFlaeche()}){Image(systemName: "equal.circle")}.buttonStyle(.borderless)
					.padding([.leading, .trailing], 5)
				Text("\(flaecheOutput.replacingOccurrences(of: "nan", with: "undefiniert"))")
			}
			
			
			Button(action: {
				fEConfig.zeigeFunktionsBerechnungen = false
			}){
				Text("Fertig")
			}.keyboardShortcut(KeyEquivalent.escape, modifiers: [])
				.padding(.top, 20)
			
		}
		.foregroundColor(.black)
		.padding(50)
		.background(Color(NSColor.windowBackgroundColor))
		.cornerRadius(20)
	}
	
	private func berechneIntegral(){
		if let numberUnten = Float(integralUntenInput.replacingOccurrences(of: ",", with: ".")){
			if let numberOben = Float(integralObenInput.replacingOccurrences(of: ",", with: ".")){
				integralOutput = "\(data.funktionen[fEConfig.funktionId!]!.berechneIntegral(untereGrenze: numberUnten, obereGrenze: numberOben))"
			}
		}
	}
	
	private func berechneFlaeche(){
		if let numberUnten = Float(flaecheUntenInput.replacingOccurrences(of: ",", with: ".")){
			if let numberOben = Float(flaecheObenInput.replacingOccurrences(of: ",", with: ".")){
				flaecheOutput = "\(data.funktionen[fEConfig.funktionId!]!.berechneFlaeche(untereGrenze: numberUnten, obereGrenze: numberOben))"
			}
		}
	}
}
