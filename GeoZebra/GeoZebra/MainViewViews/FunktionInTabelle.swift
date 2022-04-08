//
//  FunktionInTabelle.swift
//  GeoZebra
//
//  Created by Benedict on 26.12.21.
//

import SwiftUI

class FunktionsEditorConfig: ObservableObject{
	enum operatoren{
		case bruch, potenz, wurzel, nteWurzel, enter
	}
	@Published var updateId = UUID()
	
	@Published var funktionId: UUID? {
		didSet{
			zeigeFunktionseinstellungen = false
			zeigeFunktionsBerechnungen = false
			updateId = UUID()
		}
	}
	@Published var eingabe: [operatoren] = []{didSet{updateId = UUID()}}
	@Published var zeigeFunktionseinstellungen = false{didSet{updateId = UUID()}}
	@Published var zeigeFunktionsBerechnungen = false{didSet{updateId = UUID()}}
	
	//MARK: Parameter
	@Published var parameterId: ParameterMaster.ParameterNames?
}

let funktionsEditorConfig = FunktionsEditorConfig()

struct FunktionInTabelle: View {
	@State var data: DataModel
	@State var funktionId: UUID
	@State var keyboardKey: KeyEquivalent = "*"
	@ObservedObject var fEConfig = funktionsEditorConfig
	@State var updateId = UUID()
	var body: some View {
		GeometryReader{ reader in
			Button(action: {
				fEConfig.funktionId = funktionId
				fEConfig.parameterId = nil
			}){
				HStack(spacing: 5){
					ZStack{
						let hV = LatexPreview(data: data, currentFunktion: funktionId)
						hV
							.padding(.leading, 10)
							.frame(width: reader.size.width - 40, alignment: .leading)
							.id(updateId)
							.onChange(of: fEConfig.updateId, perform: {_ in
								if(fEConfig.funktionId == funktionId){
									hV.updateLatex(hV.wkWebView)
								}
							})
						Rectangle()
							.frame(width: reader.size.width - 40, alignment: .leading)
							.foregroundColor(.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.000001))
					}
					
					Button(action: {
						data.removeFunktion(id: funktionId)
						if(fEConfig.funktionId == funktionId){
							fEConfig.funktionId = nil
						}
						data.update = UUID()
					}){
						Image(systemName: "trash.fill")
							.foregroundColor(.red)
					}
					.frame(width: 25, alignment: .trailing)
					.id("\(funktionId) . \(fEConfig.updateId)")
					.buttonStyle(.borderless)
				}.frame(width: reader.size.width, height: 50, alignment: .leading)
					.background(
						HStack(spacing: 0){
							Rectangle()
								.foregroundColor(Color(data.funktionen[funktionId]?.farbe ?? .gray))
								.frame(width: 7)
								.id("indi: \(fEConfig.updateId) \(funktionId)")
							Color(NSColor(calibratedRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.1))
						}
					)
					.cornerRadius(8)
			}.keyboardShortcut(keyboardKey, modifiers: [.control])
				.onAppear(){
					let map: [Int : KeyEquivalent] = [
						0 : "1",
						1 : "2",
						2 : "3",
						3 : "4",
						4 : "5",
						5 : "6",
						6 : "7",
						7 : "8",
						8 : "9",
						9 : "0"
					]
					self.keyboardKey = map[data.funktionenIds.firstIndex(of: funktionId)!, default: "*"]
				}
				.buttonStyle(.borderless)
				.overlay(
					Color.gray
						.opacity(funktionId == fEConfig.funktionId ? 0.2 : 0.0)
						.cornerRadius(8)
						.blendMode(.multiply)
						.allowsHitTesting(false)
				)
				.contextMenu(menuItems: {
					if let funktion = data.funktionen[funktionId]{
						Button(action:{data.funktionen[funktionId]!.sichtbar.toggle();data.update = UUID()}){Text(funktion.sichtbar ? "Ausblenden" : "Einblenden")}
						Button(action:{fEConfig.funktionId = funktionId;_ = data.addFunktion(funktion.copy())}){Text("Duplizieren")}
						Divider()
						Button(action:{fEConfig.funktionId = funktionId;fEConfig.zeigeFunktionseinstellungen = true}){Text("Optionen")}
						Button(action:{fEConfig.funktionId = funktionId;fEConfig.zeigeFunktionsBerechnungen = true}){Text("Berechnungen")}
					}
				})
		}
	}
}
