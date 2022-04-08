//
//  Koordinatensystemeinstellungen.swift
//  GeoZebra
//
//  Created by Benedict on 30.12.21.
//

import SwiftUI

class KoordinatenSettings{
	/* MARKERLAYOUT:
	 0: nichts
	 1: nur Koordinatenachsen
	 2: Koordinatenachsen mit kleinen Markern
	 3: Koordinatenachsen mit Linien
	 */
	var markerLayout = 2
	var color: SIMD4<Float> = SIMD4(0,0,0,1)
	var markerColor: SIMD4<Float> = SIMD4(0,0,0,1)
	var lineWidth: Float = 0.0027
	var renderText = true //Ob Bei Linern der Wert gerendert werden soll
	var colorUI: CGColor{
		get{
			return CGColor(red: CGFloat(color.x), green: CGFloat(color.y), blue: CGFloat(color.z), alpha: CGFloat(color.w))
		}
		set{
			guard let newColor = newValue.components?.map({Float($0)}) else {
				fatalError("color not accesible")
			}
			if newColor.count < 4{
				self.color = SIMD4<Float>(0,0,0,1)
				return
			}
			
			self.color = SIMD4<Float>(newColor[0],newColor[1],newColor[2],newColor[3])
		}
	}
	
	var markerColorUI: CGColor{
		get{
			return CGColor(red: CGFloat(markerColor.x), green: CGFloat(markerColor.y), blue: CGFloat(markerColor.z), alpha: CGFloat(markerColor.w))
		}
		set{
			guard let newColor = newValue.components?.map({Float($0)}) else {
				fatalError("color not accesible")
			}
			if newColor.count < 4{
				self.markerColor = SIMD4<Float>(0,0,0,1)
				return
			}
			
			self.markerColor = SIMD4<Float>(newColor[0],newColor[1],newColor[2],newColor[3])
		}
	}
}
