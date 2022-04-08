//
//  Funktionseditor.swift
//  GeoZebra
//
//  Created by Benedict on 23.12.21.
//
import SwiftUI

struct Funktionseditor: View {
	@State var data: DataModel
	@Binding var zeigeFehler: [String]
	@ObservedObject var fEConfig = funktionsEditorConfig
	
	var body: some View {
		HStack{
			
			let hatFunktion = fEConfig.funktionId != nil
			
			VStack{
				Button(action: {
					if let funktionsId = fEConfig.funktionId{
						data.funktionen[funktionsId]!.sichtbar.toggle()
						data.update = UUID()
					}
				}){
					if let funktionsId = fEConfig.funktionId{
						Image(systemName: data.funktionen[funktionsId]?.sichtbar ?? false ? "eye" : "eye.slash")
							.resizable()
					}else{
						Image(systemName: "eye")
							.resizable()
					}
				}.buttonStyle(.borderless)
					.foregroundColor(hatFunktion ? .accentColor : .gray)
					.frame(width: 30, height: 30, alignment: .center)
					.disabled(!hatFunktion)
					.keyboardShortcut("d", modifiers: .command)
				
				Button(action: {
					if let _ = fEConfig.funktionId{
						fEConfig.zeigeFunktionseinstellungen = true
						fEConfig.zeigeFunktionsBerechnungen = false
					}
				}){
					Image(systemName: "paintbrush.fill")
						.resizable()
						.frame(width: 25, height: 25, alignment: .center)
				}.buttonStyle(.borderless)
					.foregroundColor(hatFunktion ? .accentColor : .gray)
					.frame(width: 30, height: 30, alignment: .center)
					.keyboardShortcut("o", modifiers: .command)
				
				Button(action: {
					if let _ = fEConfig.funktionId{
						fEConfig.zeigeFunktionseinstellungen = false
						fEConfig.zeigeFunktionsBerechnungen = true
					}
				}){
					Image(systemName: "bolt.fill")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 30, height: 30, alignment: .center)
				}.buttonStyle(.borderless)
					.foregroundColor(hatFunktion ? .accentColor : .gray)
					.frame(width: 30, height: 30, alignment: .center)
					.keyboardShortcut("b", modifiers: .command)
			}
			
			LaTexEditor(data: data)
				.frame(height: 80, alignment: .center)
				.foregroundColor(.red)
				.offset(x: 0, y: -26)
			VStack{
				Button(action: {
					fEConfig.eingabe.append(.enter)
				}){
					Image(systemName: "return")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 20, height: 20, alignment: .center)
						.foregroundColor(.accentColor)
				}.buttonStyle(.borderless)
				if let funktionsId = fEConfig.funktionId{
					if let funktion = data.funktionen[funktionsId]{
						if(!funktion.fehlerUndWarungen.isEmpty){
							Button(action: {
								if(zeigeFehler.isEmpty){
									zeigeFehler = funktion.fehlerUndWarungen
								}else{
									zeigeFehler = []
								}
							}){
								Image(systemName: "exclamationmark.triangle")
									.resizable()
									.frame(width: 20, height: 20)
									.foregroundColor(funktion.schwererFehler ? .red : .yellow )
							}.buttonStyle(.borderless)
						}
					}
				}
			}.id("a\(fEConfig.updateId)")
			VStack{
				HStack{
					Button(action: {
						fEConfig.eingabe.append(.bruch)
					}){
						Image("Bruch")
					}
					.buttonStyle(.borderless)
					
					Button(action: {
						fEConfig.eingabe.append(.potenz)
					}){
						Image("Potenz")
					}
					.buttonStyle(.borderless)
				}.frame(width: 100, height: 40, alignment: .center)
				HStack{
					Button(action: {
						fEConfig.eingabe.append(.wurzel)
					}){
						Image("Wurzel")
					}.buttonStyle(.borderless)
					Button(action: {
						fEConfig.eingabe.append(.nteWurzel)
					}){
						Image("nte-Wurzel")
					}.buttonStyle(.borderless)
				}.frame(width: 100, height: 40, alignment: .center)
				
			}.frame(width: 200, height: 80, alignment: .center)
		}
		.padding(.bottom, 5)
	}
}
