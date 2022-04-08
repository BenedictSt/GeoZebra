//
//  Animationen.swift
//  GeoZebra
//
//  Created by Benedict on 11.02.22.
//

import Foundation

enum Animationstypen: String, CaseIterable, Identifiable{
	case Zahl = "Zahl"
	case Slider = "Slider"
	case Stepper = "Stepper"
	case Animation = "Animation"
	
	var id: String {self.rawValue}
}

protocol ParameterAnimation{
	var viewPortBegrenzungen: ViewPortBegrenzungen { get }
	var isPlaying: Bool {get set}
	var animationsTyp: Animationstypen { get }
	func getValue() -> Float
	func reset() 
	func setSettings(_ w1: Float?,_ w2: Float?,_ w3: Float?,_ w4: Float?)
	func getSettings() -> (w1: Float?,w2: Float?,w3: Float?,w4: Float?)
}

class AnimationZahl: ParameterAnimation{
	let viewPortBegrenzungen: ViewPortBegrenzungen
	
	var isPlaying: Bool = false
	let animationsTyp: Animationstypen = .Zahl
	
	var wert: Float = 1
	
	func getValue() -> Float {
		return wert
	}
	
	func reset(){
		wert = 1
		viewPortBegrenzungen.update()
	}
	
	///- Parameter wert: Wert der Zahl
	///- Parameter w2: unused
	///- Parameter w3: unused
	///- Parameter w4: unused
	func setSettings(_ wert: Float?, _ w2: Float? = nil, _ w3: Float? = nil, _ w4: Float? = nil)  {
		self.wert = wert!
		viewPortBegrenzungen.update()
	}
	
	func getSettings() -> (w1: Float?, w2: Float?, w3: Float?, w4: Float?) {
		return (wert, nil,nil,nil)
	}
	
	init(viewPortBegrenzungen: ViewPortBegrenzungen){
		self.viewPortBegrenzungen = viewPortBegrenzungen
	}
}

class AnimationSlider: ParameterAnimation{
	let viewPortBegrenzungen: ViewPortBegrenzungen
	
	var isPlaying: Bool = false
	let animationsTyp: Animationstypen = .Slider
	
	var wert: Float = 1
	var min: Float = -5
	var max: Float = 5
	
	func getValue() -> Float {
		return wert
	}
	
	func reset(){
		wert = 1
		viewPortBegrenzungen.update()
	}
	
	///- Parameter wert: Wert der Zahl
	///- Parameter w2: Min
	///- Parameter w3: max
	///- Parameter w4: unused
	func setSettings(_ wert: Float?, _ minP: Float? = nil, _ maxP: Float? = nil, _ w4: Float? = nil)  {
		if let wert = wert{
			self.wert = wert
		}
		if let minN = minP {
			if(min < max){
				min = minN
			}else{
				messagePublisher.sendeNachricht("untere Grenze muss kleiner sein als obere")
			}
			if(self.wert < minN){
				self.wert = minN
			}
		}
		if let maxN = maxP {
			if(maxN > min){
				max = maxN
			}else{
				messagePublisher.sendeNachricht("obere Grenze muss größer sein als untere")
			}
			if(self.wert > maxN){
				self.wert = maxN
			}
		}
		viewPortBegrenzungen.update()
	}
	
	func getSettings() -> (w1: Float?, w2: Float?, w3: Float?, w4: Float?) {
		return (wert, min,max,nil)
	}
	
	init(viewPortBegrenzungen: ViewPortBegrenzungen){
		self.viewPortBegrenzungen = viewPortBegrenzungen
	}
}

class AnimationStepper: ParameterAnimation{
	let viewPortBegrenzungen: ViewPortBegrenzungen
	
	var isPlaying: Bool = false
	let animationsTyp: Animationstypen = .Stepper
	
	var wert: Float = 1
	var min: Float = -5
	var max: Float = 5
	var step: Float = 1
	
	func getValue() -> Float {
		return wert
	}
	
	func reset(){
		wert = 1
		viewPortBegrenzungen.update()
	}
	
	///- Parameter wert: Wert der Zahl
	///- Parameter w2: Min
	///- Parameter w3: max
	///- Parameter w4: step
	func setSettings(_ wert: Float?, _ minP: Float? = nil, _ maxP: Float? = nil, _ w4: Float? = nil)  {
		if let wert = wert{
			self.wert = wert
			if(self.wert > max){
				self.wert = max
			} else if(self.wert < min){
				self.wert = min
			}
		}
		if let minN = minP {
			if(min < max){
				min = minN
			}else{
				messagePublisher.sendeNachricht("untere Grenze muss kleiner sein als obere")
			}
			if(self.wert < minN){
				self.wert = minN
			}
		}
		if let maxN = maxP {
			if(maxN > min){
				max = maxN
			}else{
				messagePublisher.sendeNachricht("obere Grenze muss größer sein als untere")
			}
			if(self.wert > maxN){
				self.wert = maxN
			}
		}
		if let step = w4{
			self.step = step
		}
		viewPortBegrenzungen.update()
	}
	
	func getSettings() -> (w1: Float?, w2: Float?, w3: Float?, w4: Float?) {
		return (wert, min,max,step)
	}
	
	init(viewPortBegrenzungen: ViewPortBegrenzungen){
		self.viewPortBegrenzungen = viewPortBegrenzungen
	}
}

var ANIMATION_PRECISION: Float = 1

class AnimationVerlauf: ParameterAnimation{
	var viewPortBegrenzungen: ViewPortBegrenzungen
	var isPlaying: Bool = false {
		didSet{
			if(isPlaying){
				initTimer()
			}else{
				timer?.invalidate() //ist wichtig, weil der Timer sonst eine strong reference to self hat und dann die Animation nicht deinitialisiert werden kann
				timer = nil
			}
		}
	}
	var animationsTyp: Animationstypen = .Animation
	
	
	/* MARK: Animationsmuster
	 0: linear
	 1: loop
	 */
	var animationsMuster: Int = 0
	
	var wert: Float = 0
	var speed: Float = 1
	var min: Float = -5
	var max: Float = 5
	
	private var direction = false
	var timer: Timer? = nil
	
	@objc func animateStep(){
		switch animationsMuster{
		case 0:
			wert += speed / ANIMATION_PRECISION
			if(wert > max){
				wert = min
			}
		case 1:
			wert += (direction ? 1 : -1)*speed / ANIMATION_PRECISION
			if(wert > max){
				direction = false
			}
			if(wert < min){
				direction = true
			}
		default:
			fatalError("Animation nicht implementiert")
		}
		
		self.viewPortBegrenzungen.update()
	}
	
	func getValue() -> Float {
		return wert
	}
	
	func reset() {
		wert = min
		initTimer()
	}
	
	///- Parameter w1: Animationsmuster
	///- Parameter w2: speed
	///- Parameter w3: min
	///- Parameter w4: max
	func setSettings(_ w1: Float?, _ w2: Float?, _ w3: Float?, _ w4: Float?) {
		if let w1 = w1 {
			animationsMuster = Int(w1)
		}
		if let w2 = w2 {
			speed = w2
		}
		if let w3 = w3 {
			if(w3 < max){
				min = w3
			}else{
				messagePublisher.sendeNachricht("untere Grenze muss kleiner sein als obere")
			}
		}
		if let w4 = w4 {
			if(w4 > min){
				max = w4
			}else{
				messagePublisher.sendeNachricht("obere Grenze muss größer sein als untere")
			}
		}
		reset()
	}
	
	func getSettings() -> (w1: Float?, w2: Float?, w3: Float?, w4: Float?) {
		return (Float(animationsMuster), speed, min, max)
	}
	
	init(viewPortBegrenzungen: ViewPortBegrenzungen){
		self.viewPortBegrenzungen = viewPortBegrenzungen
		initTimer()
	}
	
	private func initTimer(){
		timer?.invalidate()
		timer = nil
		timer = Timer.scheduledTimer(timeInterval: Double(1 / ANIMATION_PRECISION), target: self, selector: #selector(animateStep), userInfo: nil, repeats: true)
	}
}
