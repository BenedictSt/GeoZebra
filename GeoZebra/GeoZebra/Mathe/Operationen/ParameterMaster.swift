//
//  Parameter.swift
//  GeoZebra
//
//  Created by Benedict on 31.12.21.
//

import Foundation
import SwiftUI
/*
Tools:
 - Animation
 - Slider
 - Stepper
 - Random Number
 */


class ParameterMaster{
	let viewPortBegrenzungen: ViewPortBegrenzungen
	var references: Int = 0
	public enum ParameterNames: String{
		case A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
		
		init(str: String) throws{
			switch str.uppercased(){
			case "A": self = .A
			case "B": self = .B
			case "C": self = .C
			case "D": self = .D
			case "E": self = .E
			case "F": self = .F
			case "G": self = .G
			case "H": self = .H
			case "I": self = .I
			case "J": self = .J
			case "K": self = .K
			case "L": self = .L
			case "M": self = .M
			case "N": self = .N
			case "O": self = .O
			case "P": self = .P
			case "Q": self = .Q
			case "R": self = .R
			case "S": self = .S
			case "T": self = .T
			case "U": self = .U
			case "V": self = .V
			case "W": self = .W
			case "X": self = .X
			case "Y": self = .Y
			case "Z": self = .Z
			default: throw ParameterErrors.invalidName
			}
		}
		enum ParameterErrors: Error{
			case invalidName
		}
	}
	
	var name: ParameterNames
	var _animation: ParameterAnimation
	var animation: ParameterAnimation {
		set{
			//damit deinited werden kann (retain cycle vermeiden)
			if(_animation.animationsTyp != newValue.animationsTyp){
				_animation.isPlaying = false
			}
			_animation = newValue
		}
		get{ return _animation}
	}
	
	init(name: ParameterNames, wert: Float = 1, viewPortBegrenzungen: ViewPortBegrenzungen){
		self.name = name
		self._animation = AnimationZahl(viewPortBegrenzungen: viewPortBegrenzungen)
		self._animation.setSettings(1, nil, nil, nil)
		self.viewPortBegrenzungen = viewPortBegrenzungen
	}
	
	func getValue() -> Float{
		return animation.getValue()
	}
}



//MARK: - ParameterSlave
///Parameter um ihn in Gleichungen zu benutzen
///bezieht seine Wert von dem Master Paramter der im DataModel gespeichert ist
class ParameterSlave: FunktionProt{
	typealias ParameterNames = ParameterMaster.ParameterNames
	
	let name: ParameterNames
	let master: ParameterMaster
	
	init(name: ParameterNames, dataModel: DataModel) throws{
		self.name = name
		guard let master = dataModel.parameter[name] else{
			throw GenericError.error
		}
		self.master = master
		master.references += 1
	}

	func calculate(x: Float) -> Float {
		return master.getValue()
	}

	func derivative(x: Float) -> Float {
		return 0
	}

	func getString() -> String {
		return name.rawValue
	}

	func getDefinitionslückenBedingungen() -> [DefinitionsBedingung] {
		return []
	}
	
	deinit{
		master.references -= 1
	}
}

enum GenericError: Error{
	case error
}
