//
//  ParameterEditor.swift
//  GeoZebra
//
//  Created by Benedict on 11.02.22.
//

import Foundation
import SwiftUI

struct ParameterEditor: View {
	@State var data: DataModel
	@ObservedObject var fEConfig = funktionsEditorConfig
	
	@State var selectedAnimation: Animationstypen
	@State var number1: Float = 0
	
	var body: some View {
		HStack{
			HStack{
				Text("Parameter \(fEConfig.parameterId?.rawValue ?? "fehler"):")
				Picker("", selection: $selectedAnimation){
					ForEach(Animationstypen.allCases) { typ in
						Text(typ.rawValue).tag(typ)
					}
				}.onChange(of: selectedAnimation, perform: { _ in
					switch selectedAnimation {
					case .Zahl:
						data.parameter[fEConfig.parameterId!]!.animation = AnimationZahl(viewPortBegrenzungen: data.viewPortBegrenzungen)
					case .Slider:
						data.parameter[fEConfig.parameterId!]!.animation = AnimationSlider(viewPortBegrenzungen: data.viewPortBegrenzungen)
					case .Stepper:
						data.parameter[fEConfig.parameterId!]!.animation = AnimationStepper(viewPortBegrenzungen: data.viewPortBegrenzungen)
					case .Animation:
						data.parameter[fEConfig.parameterId!]!.animation = AnimationVerlauf(viewPortBegrenzungen: data.viewPortBegrenzungen)
					}
				}).frame(width: 100)
				
				switch selectedAnimation{
				case .Zahl:
					AnimationZahlEditorView(data: data)
				case .Slider:
					AnimationSliderEditorView(data: data)
				case .Stepper:
					AnimationStepperEditorView(data: data)
				case .Animation:
					AnimationsVerlaufEditorView(data: data)
				}
			}.frame(height: 80, alignment: .leading)
		}
	}
	
	init(data: DataModel){
		self.data = data
		self.selectedAnimation = data.parameter[funktionsEditorConfig.parameterId!]!.animation.animationsTyp
	}
}

fileprivate struct AnimationZahlEditorView: View{
	@State var data: DataModel
	@ObservedObject var fEConfig = funktionsEditorConfig
	@State var numberTfStr = ""
	
	func load(){
		numberTfStr = String(data.parameter[fEConfig.parameterId!]!.animation.getSettings().w1!)
	}
	
	var body: some View{
		HStack{
			TextField("Wert", text: $numberTfStr, onCommit: {
				if let newValue = Float(numberTfStr.replacingOccurrences(of: ",", with: ".")){
					data.parameter[fEConfig.parameterId!]!.animation.setSettings(newValue, nil, nil, nil)
				}else{
					numberTfStr = String(data.parameter[fEConfig.parameterId!]!.animation.getSettings().w1!)
				}
			}).frame(width: 100)
		}.onAppear(perform: {
			load()
		})
	}
}

fileprivate struct AnimationSliderEditorView: View{
	@State var data: DataModel
	@ObservedObject var fEConfig = funktionsEditorConfig
	@State var sliderValue: Float = 1
	@State var minTfStr = ""
	@State var maxTfStr = ""
	
	func load(){
		sliderValue = data.parameter[fEConfig.parameterId!]!.animation.getSettings().w1!
		minTfStr = String(data.parameter[fEConfig.parameterId!]!.animation.getSettings().w2 ?? -5)
		maxTfStr = String(data.parameter[fEConfig.parameterId!]!.animation.getSettings().w3 ?? 5)
	}
	
	var body: some View{
		HStack{
			Text("\(sliderValue)")
				.bold()
				.frame(width: 100)
			
			//Min
			TextField("min", text: $minTfStr, onCommit: {
				if let newValue = Float(minTfStr.replacingOccurrences(of: ",", with: ".")){
					data.parameter[fEConfig.parameterId!]!.animation.setSettings(nil, newValue, nil, nil)
				}
				load()
			}).frame(width: 50)
			
			//Slider
			Slider(value: $sliderValue, in: (Float(minTfStr) ?? -5.0)...(Float(maxTfStr) ?? 5.0))
				.frame(width: 400)
				.onChange(of: sliderValue, perform: {_ in
					data.parameter[fEConfig.parameterId!]!.animation.setSettings(sliderValue, nil, nil, nil)
				})
			
			//Max
			TextField("max", text: $maxTfStr, onCommit: {
				if let newValue = Float(maxTfStr.replacingOccurrences(of: ",", with: ".")){
					data.parameter[fEConfig.parameterId!]!.animation.setSettings(nil, nil, newValue, nil)
				}
				load()
			}).frame(width: 50)
		}.onAppear(perform: {
			load()
		})
	}
}

fileprivate struct AnimationStepperEditorView: View{
	@State var data: DataModel
	@ObservedObject var fEConfig = funktionsEditorConfig
	@State var stepperValue: Float = 1
	@State var minTfStr = ""
	@State var maxTfStr = ""
	@State var stepTfStr = "W"
	
	func load(){
		stepperValue = data.parameter[fEConfig.parameterId!]!.animation.getSettings().w1!
		minTfStr = String(data.parameter[fEConfig.parameterId!]!.animation.getSettings().w2 ?? -5)
		maxTfStr = String(data.parameter[fEConfig.parameterId!]!.animation.getSettings().w3 ?? 5)
		stepTfStr = String(data.parameter[fEConfig.parameterId!]!.animation.getSettings().w4 ?? 1)
	}
	
	var body: some View{
		HStack{
			Text("\(stepperValue)")
				.bold()
				.frame(width: 100)
			
			//Min
			TextField("min", text: $minTfStr, onCommit: {
				if let newValue = Float(minTfStr.replacingOccurrences(of: ",", with: ".")){
					data.parameter[fEConfig.parameterId!]!.animation.setSettings(nil, newValue, nil, nil)
				}
				load()
			}).frame(width: 50)
			
			//Slider
			Stepper("", value: $stepperValue, in: (Float(minTfStr) ?? -5)...(Float(maxTfStr) ?? 5), step: Float(stepTfStr) ?? 0)
				.frame(width: 20)
				.onChange(of: stepperValue, perform: {_ in
					data.parameter[fEConfig.parameterId!]!.animation.setSettings(stepperValue, nil, nil, nil)
				})
			
			//Max
			TextField("max", text: $maxTfStr, onCommit: {
				if let newValue = Float(maxTfStr.replacingOccurrences(of: ",", with: ".")){
					data.parameter[fEConfig.parameterId!]!.animation.setSettings(nil, nil, newValue, nil)
				}
				load()
			}).frame(width: 50)
			
			//Step
			Text("Schritt:")
			TextField("step", text: $stepTfStr, onCommit: {
				if let newValue = Float(stepTfStr.replacingOccurrences(of: ",", with: ".")){
					data.parameter[fEConfig.parameterId!]!.animation.setSettings(nil, nil, nil, newValue)
				}
				load()
			}).frame(width: 50)
		}.onAppear(perform: {
			load()
		})
	}
}

fileprivate struct AnimationsVerlaufEditorView: View{
	@State var data: DataModel
	@ObservedObject var fEConfig = funktionsEditorConfig
	@State var isPlaying = true
	@State var animationsTyp = 0
	
	func load(){
		isPlaying = data.parameter[fEConfig.parameterId!]!.animation.isPlaying
		animationsTyp = Int(data.parameter[fEConfig.parameterId!]!.animation.getSettings().w1!)
	}
	var body: some View{
		HStack{
			Picker("", selection: $animationsTyp){
				Text("Linear").tag(0)
				Text("Loop").tag(1)
			}.onChange(of: animationsTyp, perform: { _ in
				data.parameter[fEConfig.parameterId!]!.animation.setSettings(Float(animationsTyp), nil, nil, nil)
			}).frame(width: 100)
			
			Button(action: {
				data.parameter[fEConfig.parameterId!]!.animation.isPlaying.toggle()
				load()
			}){
				Image(systemName: isPlaying ? "pause.fill" : "play.fill")
			}.buttonStyle(.borderless)
				.foregroundColor(.accentColor)
		}.onAppear(perform: {
			load()
		})
	}
}
