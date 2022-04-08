//
//  WelcomeView.swift
//  
//
//  Created by Benedict on 05.03.22.
//

import Foundation
import SwiftUI

struct WelcomeView: View{
	@State var state = 0
	var body: some View {
		ZStack{
			switch state {
			case 0:
				LicenseView(state: $state)
			default:
				VStack{
					Text("Es ist ein Fehler aufgetreten")
					Button(action: {
						exit(1)
					}){
						Text("Schließen!")
					}
				}
			}
		}
		.frame(width: 1000, height: 600, alignment: .center)
		.background(Color.white)
		.cornerRadius(20)
		.shadow(radius: 10)
	}
}
