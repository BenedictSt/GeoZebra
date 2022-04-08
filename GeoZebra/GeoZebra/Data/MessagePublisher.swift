//
//  MessagePublisher.swift
//  GeoZebra
//
//  Created by Benedict on 24.01.22.
//

import Foundation
import SwiftUI

///Verwaltet die Nachrichten und Fehlermeldungen, die von der App dem User angezeigt werden sollen
class MessagePublisher: ObservableObject{
	public struct Message{
		let nachricht: String
		let color: Color
		let id: UUID
	}
	///Queue an Nachrichten, die der Reihe nach angezeigt werden soll
	@Published var messages: [Message] = []
	
	///Zeigt die Nachricht unten im Fenster an
	///falls schon eine Nachricht angezeigt wird, wird diese Nachricht hinten angereiht und später gezeigt
	///- Parameter text: Text der Nachricht
	///- Parameter farbe: Farbe des Textes; standard: schwarz
	func sendeNachricht(_ text: String, farbe: Color = .black){
		let messageId = UUID()
		messages.append(Message(nachricht: text, color: farbe, id: messageId))
		
		//Lösche Nachricht wieder
		DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
			self.messages.removeAll(where: {$0.id == messageId})
		})
	}
}

let messagePublisher = MessagePublisher()

///View, der eine Nachricht anzeigen kann
struct MessagePublisherView: View{
	@State var parentSize: CGSize
	@ObservedObject var localMessagePublisher = messagePublisher
	
	var body: some View{
		HStack{
			Text(localMessagePublisher.messages.first?.nachricht ?? "-")
				.foregroundColor(localMessagePublisher.messages.first?.color ?? .black)
				.zIndex(300)
				.padding(20)
		}.background(Color(red: 0.85, green: 0.85, blue: 0.85, opacity: 1.0))
			.cornerRadius(15)
			.zIndex(300)
			.position(x: parentSize.width / 2, y: parentSize.height - 50)
			.onTapGesture {
				if(!localMessagePublisher.messages.isEmpty){
					localMessagePublisher.messages.removeFirst()
				}
			}
	}
}
