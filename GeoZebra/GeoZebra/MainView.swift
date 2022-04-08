//
//	MainView.swift
//	GeoZebra
//
//	Created by Benedict on 22.12.21.
//

import SwiftUI

struct MainView: View {
	@Binding var resetGraph: UUID
	@ObservedObject var data: DataModel
	@ObservedObject var fEConfig = funktionsEditorConfig
	@ObservedObject var localMessagePublisher = messagePublisher
	
	@State var zeigeKoordinateneinstellungen = false
	@Binding var zeigeAppEinstellungen: Bool
	@State var zeigeFehler: [String] = []
	
	@AppStorage("geozebra_prefered_fps", store: .standard) var preferedFps: Int = 20
	@AppStorage("geozebra_prefered_precision", store: .standard) var preferedPrecision: Int = 50
	@AppStorage("geozebra_prefered_animation_precision", store: .standard) var preferedAnimation: Int = 10
	@AppStorage("geozebra_hasAgreedToLicense", store: .standard) var agreedLicense: Bool = false
	
	var body: some View {
		if(zeigeAppEinstellungen){
			GeoZebraPreferences(zeigeAppEinstellungen: $zeigeAppEinstellungen)
				.onDisappear(){
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
						resetGraph = UUID();
						data.update = UUID()
					}
				}
		}else{
			GeometryReader{ reader in
				ZStack{
					if(!localMessagePublisher.messages.isEmpty){
						MessagePublisherView(parentSize: reader.size)
					}
					HStack{
						VStack{
							//MARK: Einstellungen oben
							HStack{
								Button(action: {zeigeAppEinstellungen = true}){Image(systemName: "gear").resizable().frame(width: 25, height: 25, alignment: .center)}.buttonStyle(.borderless).foregroundColor(.gray)
									.frame(width: 30, height: 30, alignment: .center)
								
								Button(action: {data.addParameter(); resetGraph = UUID()}){Image(systemName: "slider.vertical.3").resizable().frame(width: 25, height: 25, alignment: .center)}.buttonStyle(.borderless)
									.frame(width: 30, height: 30, alignment: .center)
									.foregroundColor(.accentColor)
								
								Button(action: {
									fEConfig.funktionId = data.addFunktion(Funktion(funktion: Dividieren(a: Zahl(1), b: Zahl(0))))
									resetGraph = UUID()
								}){
									Image(systemName: "square.and.pencil")
										.resizable()
										.frame(width: 25, height: 25, alignment: .center)
								}
								.buttonStyle(.borderless)
								.foregroundColor(.accentColor)
								.frame(width: 30, height: 30, alignment: .center)
							}.padding(.top, 10)
							
							//MARK: Funktionsliste
							ScrollView{
								VStack{
									if(!data.parameter.isEmpty){
										HStack(spacing: 20){
											Text("Parameter:")
												.font(.headline)
											Button(action: {data.pauseAllAnimations()}){Image(systemName: "pause.fill").resizable().frame(width: 15, height: 15)}.buttonStyle(.borderless).foregroundColor(.accentColor)
											Button(action: {data.playAllAnimations()}){Image(systemName: "play.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 15, height: 15)}.buttonStyle(.borderless).foregroundColor(.accentColor)
										}
										
										ForEach(Array(data.parameter.keys).sorted(by: {$0.rawValue < $1.rawValue}), id: \.self){ paramterKey in
											Text("Parameter: \(data.parameter[paramterKey]!.name.rawValue)")
												.padding(5)
												.frame(width: 260, height: 30, alignment: .leading)
												.background(Color.gray.opacity(paramterKey == fEConfig.parameterId ? 0.4 : 0.2))
												.cornerRadius(8)
												.onTapGesture {
													fEConfig.funktionId = nil
													fEConfig.parameterId = paramterKey
												}
												.contextMenu(menuItems: {
													Button(action: {
														if(data.parameter[paramterKey]!.references == 0){
															fEConfig.parameterId = nil
															data.parameter[paramterKey] = nil
															resetGraph = UUID()
														}else{
															messagePublisher.sendeNachricht("Löschen fehlgeschlagen: Es gibt aktive Referenzen auf diesen Parameter.")
														}
													}){
														Text("Löschen")
													}
												})
										}
									}
									Text("Funktionen:")
										.font(.headline)
									ForEach(data.funktionenIds, id: \.self){ funktionId in
										FunktionInTabelle(data: data, funktionId: funktionId)
											.padding(20)
									}
									
								}.frame(width: 300, alignment: .top)
									.id("\(data.update)Funktionen & Parameter")
							}.frame(width: 300, height: reader.size.height-300, alignment: .topLeading)
								.onTapGesture {
									fEConfig.funktionId = nil
									fEConfig.parameterId = nil
								}
							
							//MARK: Grapheinstellungen unten links
							GraphEinstellungen(zeigekoordinateneinstellungen: $zeigeKoordinateneinstellungen, viewPortBegrenzungen: data.viewPortBegrenzungen)
								.frame(width: 300, height: 300, alignment: .topLeading)
						}
						
						//rechte Seite
						VStack(spacing: 0){
							
							//MARK: Funktionseditor oben
							if(fEConfig.funktionId != nil){
								Funktionseditor(data: data, zeigeFehler: $zeigeFehler)
									.id("Funktionseditor \(data.update)")
							}else if(fEConfig.parameterId != nil){
								ParameterEditor(data: data)
									.onAppear(){resetGraph = UUID()}
									.onDisappear(){resetGraph = UUID()}
									.id("parameterEditor - \(String(describing: fEConfig.parameterId))")
							}
							
							//MARK: GraphenFenster
							ZStack{
								GeometryReader{ metalReader in
									Color.clear
										.zIndex(2)
									
									MetalViewWrapper(width: metalReader.size.width, height: metalReader.size.height, dataModel: data, viewPortBegrenzungen: data.viewPortBegrenzungen)
										.frame(width: metalReader.size.width, height: metalReader.size.height)
										.id("\(resetGraph) metalView")
										.onChange(of: metalReader.size, perform: {_ in resetGraph = UUID()})
										.onChange(of: data.update, perform: {_ in resetGraph = UUID()})
										.zIndex(20)
										.onAppear(perform: {
											data.viewPortBegrenzungen.fps = preferedFps
											data.viewPortBegrenzungen.precision = preferedPrecision
											ANIMATION_PRECISION = Float(preferedAnimation) / 10
										})
								}
								
								//MARK: Graph overlays
								if(fEConfig.zeigeFunktionseinstellungen){
									FunktionsEinstellungen(data: data)
										.shadow(radius: 5)
										.zIndex(40)
								}
								if(fEConfig.zeigeFunktionsBerechnungen){
									FunktionsBerechnungView(data: data)
										.shadow(radius: 5)
										.zIndex(40)
								}
								if(zeigeKoordinateneinstellungen){
									KoorinatenEinstellungenView(data: data, zeigeKoordinateneinstellungen: $zeigeKoordinateneinstellungen)
										.shadow(radius: 5)
										.zIndex(40)
								}
								if(!zeigeFehler.isEmpty && fEConfig.funktionId != nil){
									VStack{
										Text("Fehler:")
											.font(.title)
											.underline()
											.padding(.bottom, 20)
										ForEach(zeigeFehler, id: \.self){ fehler in
											Text(fehler)
										}
										Button(action:{
											zeigeFehler = []
										}){Text("Fertig")}.keyboardShortcut(KeyEquivalent.escape, modifiers: []).padding(.top, 20)
									}
										.padding(20)
										.background(Color.white)
										.cornerRadius(20)
										.shadow(radius: 7)
								}
							}.frame(alignment: .center)
						}
					}
					.disabled(!agreedLicense)
					.blur(radius: agreedLicense ? 0 : 1.5)
					.id("mainView \(agreedLicense ? "enabled" : "disabled")")
					
					if(!agreedLicense){
						Color(CGColor(gray: 0, alpha: 0.01))
						WelcomeView()
							.frame(width: 1000, height: 600, alignment: .center)
					}
				}
				.id("g - \(reader.size)")
				.onChange(of: fEConfig.funktionId){_ in zeigeFehler = []}
				.onChange(of: reader.size){ _ in
					resetGraph = UUID();
					data.update = UUID()
				}
			}
		}
	}
}
