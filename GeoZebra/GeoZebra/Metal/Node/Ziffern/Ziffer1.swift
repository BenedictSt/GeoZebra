//
//  Ziffer1.swift
//  GeoZebra
//
//  Created by Benedict on 07.01.22.
//

import Foundation
class Ziffer_1: Primitive {
	override func buildDefaultVertices() {
		vertices = []
		let positions: [SIMD3<Float>] = [
			SIMD3<Float>(4,8,0),SIMD3<Float>(5,8,0),SIMD3<Float>(4,9,0),SIMD3<Float>(5,9,0),SIMD3<Float>(4,9,0),SIMD3<Float>(5,9,0),SIMD3<Float>(4,10,0),SIMD3<Float>(5,10,0),SIMD3<Float>(5,7,0),SIMD3<Float>(6,7,0),SIMD3<Float>(5,8,0),SIMD3<Float>(6,8,0),SIMD3<Float>(5,8,0),SIMD3<Float>(6,8,0),SIMD3<Float>(5,9,0),SIMD3<Float>(6,9,0),SIMD3<Float>(5,9,0),SIMD3<Float>(6,9,0),SIMD3<Float>(5,10,0),SIMD3<Float>(6,10,0),SIMD3<Float>(5,10,0),SIMD3<Float>(6,10,0),SIMD3<Float>(5,11,0),SIMD3<Float>(6,11,0),SIMD3<Float>(5,32,0),SIMD3<Float>(6,32,0),SIMD3<Float>(5,33,0),SIMD3<Float>(6,33,0),SIMD3<Float>(5,33,0),SIMD3<Float>(6,33,0),SIMD3<Float>(5,34,0),SIMD3<Float>(6,34,0),SIMD3<Float>(5,34,0),SIMD3<Float>(6,34,0),SIMD3<Float>(5,35,0),SIMD3<Float>(6,35,0),SIMD3<Float>(6,6,0),SIMD3<Float>(7,6,0),SIMD3<Float>(6,7,0),SIMD3<Float>(7,7,0),SIMD3<Float>(6,7,0),SIMD3<Float>(7,7,0),SIMD3<Float>(6,8,0),SIMD3<Float>(7,8,0),SIMD3<Float>(6,8,0),SIMD3<Float>(7,8,0),SIMD3<Float>(6,9,0),SIMD3<Float>(7,9,0),SIMD3<Float>(6,9,0),SIMD3<Float>(7,9,0),SIMD3<Float>(6,10,0),SIMD3<Float>(7,10,0),SIMD3<Float>(6,10,0),SIMD3<Float>(7,10,0),SIMD3<Float>(6,11,0),SIMD3<Float>(7,11,0),SIMD3<Float>(6,31,0),SIMD3<Float>(7,31,0),SIMD3<Float>(6,32,0),SIMD3<Float>(7,32,0),SIMD3<Float>(6,32,0),SIMD3<Float>(7,32,0),SIMD3<Float>(6,33,0),SIMD3<Float>(7,33,0),SIMD3<Float>(6,33,0),SIMD3<Float>(7,33,0),SIMD3<Float>(6,34,0),SIMD3<Float>(7,34,0),SIMD3<Float>(6,34,0),SIMD3<Float>(7,34,0),SIMD3<Float>(6,35,0),SIMD3<Float>(7,35,0),SIMD3<Float>(7,6,0),SIMD3<Float>(8,6,0),SIMD3<Float>(7,7,0),SIMD3<Float>(8,7,0),SIMD3<Float>(7,7,0),SIMD3<Float>(8,7,0),SIMD3<Float>(7,8,0),SIMD3<Float>(8,8,0),SIMD3<Float>(7,8,0),SIMD3<Float>(8,8,0),SIMD3<Float>(7,9,0),SIMD3<Float>(8,9,0),SIMD3<Float>(7,9,0),SIMD3<Float>(8,9,0),SIMD3<Float>(7,10,0),SIMD3<Float>(8,10,0),SIMD3<Float>(7,10,0),SIMD3<Float>(8,10,0),SIMD3<Float>(7,11,0),SIMD3<Float>(8,11,0),SIMD3<Float>(7,31,0),SIMD3<Float>(8,31,0),SIMD3<Float>(7,32,0),SIMD3<Float>(8,32,0),SIMD3<Float>(7,32,0),SIMD3<Float>(8,32,0),SIMD3<Float>(7,33,0),SIMD3<Float>(8,33,0),SIMD3<Float>(7,33,0),SIMD3<Float>(8,33,0),SIMD3<Float>(7,34,0),SIMD3<Float>(8,34,0),SIMD3<Float>(7,34,0),SIMD3<Float>(8,34,0),SIMD3<Float>(7,35,0),SIMD3<Float>(8,35,0),SIMD3<Float>(8,5,0),SIMD3<Float>(9,5,0),SIMD3<Float>(8,6,0),SIMD3<Float>(9,6,0),SIMD3<Float>(8,6,0),SIMD3<Float>(9,6,0),SIMD3<Float>(8,7,0),SIMD3<Float>(9,7,0),SIMD3<Float>(8,7,0),SIMD3<Float>(9,7,0),SIMD3<Float>(8,8,0),SIMD3<Float>(9,8,0),SIMD3<Float>(8,8,0),SIMD3<Float>(9,8,0),SIMD3<Float>(8,9,0),SIMD3<Float>(9,9,0),SIMD3<Float>(8,9,0),SIMD3<Float>(9,9,0),SIMD3<Float>(8,10,0),SIMD3<Float>(9,10,0),SIMD3<Float>(8,31,0),SIMD3<Float>(9,31,0),SIMD3<Float>(8,32,0),SIMD3<Float>(9,32,0),SIMD3<Float>(8,32,0),SIMD3<Float>(9,32,0),SIMD3<Float>(8,33,0),SIMD3<Float>(9,33,0),SIMD3<Float>(8,33,0),SIMD3<Float>(9,33,0),SIMD3<Float>(8,34,0),SIMD3<Float>(9,34,0),SIMD3<Float>(8,34,0),SIMD3<Float>(9,34,0),SIMD3<Float>(8,35,0),SIMD3<Float>(9,35,0),SIMD3<Float>(9,4,0),SIMD3<Float>(10,4,0),SIMD3<Float>(9,5,0),SIMD3<Float>(10,5,0),SIMD3<Float>(9,5,0),SIMD3<Float>(10,5,0),SIMD3<Float>(9,6,0),SIMD3<Float>(10,6,0),SIMD3<Float>(9,6,0),SIMD3<Float>(10,6,0),SIMD3<Float>(9,7,0),SIMD3<Float>(10,7,0),SIMD3<Float>(9,7,0),SIMD3<Float>(10,7,0),SIMD3<Float>(9,8,0),SIMD3<Float>(10,8,0),SIMD3<Float>(9,8,0),SIMD3<Float>(10,8,0),SIMD3<Float>(9,9,0),SIMD3<Float>(10,9,0),SIMD3<Float>(9,31,0),SIMD3<Float>(10,31,0),SIMD3<Float>(9,32,0),SIMD3<Float>(10,32,0),SIMD3<Float>(9,32,0),SIMD3<Float>(10,32,0),SIMD3<Float>(9,33,0),SIMD3<Float>(10,33,0),SIMD3<Float>(9,33,0),SIMD3<Float>(10,33,0),SIMD3<Float>(9,34,0),SIMD3<Float>(10,34,0),SIMD3<Float>(9,34,0),SIMD3<Float>(10,34,0),SIMD3<Float>(9,35,0),SIMD3<Float>(10,35,0),SIMD3<Float>(10,4,0),SIMD3<Float>(11,4,0),SIMD3<Float>(10,5,0),SIMD3<Float>(11,5,0),SIMD3<Float>(10,5,0),SIMD3<Float>(11,5,0),SIMD3<Float>(10,6,0),SIMD3<Float>(11,6,0),SIMD3<Float>(10,6,0),SIMD3<Float>(11,6,0),SIMD3<Float>(10,7,0),SIMD3<Float>(11,7,0),SIMD3<Float>(10,7,0),SIMD3<Float>(11,7,0),SIMD3<Float>(10,8,0),SIMD3<Float>(11,8,0),SIMD3<Float>(10,8,0),SIMD3<Float>(11,8,0),SIMD3<Float>(10,9,0),SIMD3<Float>(11,9,0),SIMD3<Float>(10,31,0),SIMD3<Float>(11,31,0),SIMD3<Float>(10,32,0),SIMD3<Float>(11,32,0),SIMD3<Float>(10,32,0),SIMD3<Float>(11,32,0),SIMD3<Float>(10,33,0),SIMD3<Float>(11,33,0),SIMD3<Float>(10,33,0),SIMD3<Float>(11,33,0),SIMD3<Float>(10,34,0),SIMD3<Float>(11,34,0),SIMD3<Float>(10,34,0),SIMD3<Float>(11,34,0),SIMD3<Float>(10,35,0),SIMD3<Float>(11,35,0),SIMD3<Float>(11,3,0),SIMD3<Float>(12,3,0),SIMD3<Float>(11,4,0),SIMD3<Float>(12,4,0),SIMD3<Float>(11,4,0),SIMD3<Float>(12,4,0),SIMD3<Float>(11,5,0),SIMD3<Float>(12,5,0),SIMD3<Float>(11,5,0),SIMD3<Float>(12,5,0),SIMD3<Float>(11,6,0),SIMD3<Float>(12,6,0),SIMD3<Float>(11,6,0),SIMD3<Float>(12,6,0),SIMD3<Float>(11,7,0),SIMD3<Float>(12,7,0),SIMD3<Float>(11,7,0),SIMD3<Float>(12,7,0),SIMD3<Float>(11,8,0),SIMD3<Float>(12,8,0),SIMD3<Float>(11,31,0),SIMD3<Float>(12,31,0),SIMD3<Float>(11,32,0),SIMD3<Float>(12,32,0),SIMD3<Float>(11,32,0),SIMD3<Float>(12,32,0),SIMD3<Float>(11,33,0),SIMD3<Float>(12,33,0),SIMD3<Float>(11,33,0),SIMD3<Float>(12,33,0),SIMD3<Float>(11,34,0),SIMD3<Float>(12,34,0),SIMD3<Float>(11,34,0),SIMD3<Float>(12,34,0),SIMD3<Float>(11,35,0),SIMD3<Float>(12,35,0),SIMD3<Float>(12,3,0),SIMD3<Float>(13,3,0),SIMD3<Float>(12,4,0),SIMD3<Float>(13,4,0),SIMD3<Float>(12,4,0),SIMD3<Float>(13,4,0),SIMD3<Float>(12,5,0),SIMD3<Float>(13,5,0),SIMD3<Float>(12,5,0),SIMD3<Float>(13,5,0),SIMD3<Float>(12,6,0),SIMD3<Float>(13,6,0),SIMD3<Float>(12,6,0),SIMD3<Float>(13,6,0),SIMD3<Float>(12,7,0),SIMD3<Float>(13,7,0),SIMD3<Float>(12,7,0),SIMD3<Float>(13,7,0),SIMD3<Float>(12,8,0),SIMD3<Float>(13,8,0),SIMD3<Float>(12,31,0),SIMD3<Float>(13,31,0),SIMD3<Float>(12,32,0),SIMD3<Float>(13,32,0),SIMD3<Float>(12,32,0),SIMD3<Float>(13,32,0),SIMD3<Float>(12,33,0),SIMD3<Float>(13,33,0),SIMD3<Float>(12,33,0),SIMD3<Float>(13,33,0),SIMD3<Float>(12,34,0),SIMD3<Float>(13,34,0),SIMD3<Float>(12,34,0),SIMD3<Float>(13,34,0),SIMD3<Float>(12,35,0),SIMD3<Float>(13,35,0),SIMD3<Float>(13,2,0),SIMD3<Float>(14,2,0),SIMD3<Float>(13,3,0),SIMD3<Float>(14,3,0),SIMD3<Float>(13,3,0),SIMD3<Float>(14,3,0),SIMD3<Float>(13,4,0),SIMD3<Float>(14,4,0),SIMD3<Float>(13,4,0),SIMD3<Float>(14,4,0),SIMD3<Float>(13,5,0),SIMD3<Float>(14,5,0),SIMD3<Float>(13,5,0),SIMD3<Float>(14,5,0),SIMD3<Float>(13,6,0),SIMD3<Float>(14,6,0),SIMD3<Float>(13,6,0),SIMD3<Float>(14,6,0),SIMD3<Float>(13,7,0),SIMD3<Float>(14,7,0),SIMD3<Float>(13,31,0),SIMD3<Float>(14,31,0),SIMD3<Float>(13,32,0),SIMD3<Float>(14,32,0),SIMD3<Float>(13,32,0),SIMD3<Float>(14,32,0),SIMD3<Float>(13,33,0),SIMD3<Float>(14,33,0),SIMD3<Float>(13,33,0),SIMD3<Float>(14,33,0),SIMD3<Float>(13,34,0),SIMD3<Float>(14,34,0),SIMD3<Float>(13,34,0),SIMD3<Float>(14,34,0),SIMD3<Float>(13,35,0),SIMD3<Float>(14,35,0),SIMD3<Float>(14,1,0),SIMD3<Float>(15,1,0),SIMD3<Float>(14,2,0),SIMD3<Float>(15,2,0),SIMD3<Float>(14,2,0),SIMD3<Float>(15,2,0),SIMD3<Float>(14,3,0),SIMD3<Float>(15,3,0),SIMD3<Float>(14,3,0),SIMD3<Float>(15,3,0),SIMD3<Float>(14,4,0),SIMD3<Float>(15,4,0),SIMD3<Float>(14,4,0),SIMD3<Float>(15,4,0),SIMD3<Float>(14,5,0),SIMD3<Float>(15,5,0),SIMD3<Float>(14,5,0),SIMD3<Float>(15,5,0),SIMD3<Float>(14,6,0),SIMD3<Float>(15,6,0),SIMD3<Float>(14,6,0),SIMD3<Float>(15,6,0),SIMD3<Float>(14,7,0),SIMD3<Float>(15,7,0),SIMD3<Float>(14,7,0),SIMD3<Float>(15,7,0),SIMD3<Float>(14,8,0),SIMD3<Float>(15,8,0),SIMD3<Float>(14,8,0),SIMD3<Float>(15,8,0),SIMD3<Float>(14,9,0),SIMD3<Float>(15,9,0),SIMD3<Float>(14,9,0),SIMD3<Float>(15,9,0),SIMD3<Float>(14,10,0),SIMD3<Float>(15,10,0),SIMD3<Float>(14,10,0),SIMD3<Float>(15,10,0),SIMD3<Float>(14,11,0),SIMD3<Float>(15,11,0),SIMD3<Float>(14,11,0),SIMD3<Float>(15,11,0),SIMD3<Float>(14,12,0),SIMD3<Float>(15,12,0),SIMD3<Float>(14,12,0),SIMD3<Float>(15,12,0),SIMD3<Float>(14,13,0),SIMD3<Float>(15,13,0),SIMD3<Float>(14,13,0),SIMD3<Float>(15,13,0),SIMD3<Float>(14,14,0),SIMD3<Float>(15,14,0),SIMD3<Float>(14,14,0),SIMD3<Float>(15,14,0),SIMD3<Float>(14,15,0),SIMD3<Float>(15,15,0),SIMD3<Float>(14,15,0),SIMD3<Float>(15,15,0),SIMD3<Float>(14,16,0),SIMD3<Float>(15,16,0),SIMD3<Float>(14,16,0),SIMD3<Float>(15,16,0),SIMD3<Float>(14,17,0),SIMD3<Float>(15,17,0),SIMD3<Float>(14,17,0),SIMD3<Float>(15,17,0),SIMD3<Float>(14,18,0),SIMD3<Float>(15,18,0),SIMD3<Float>(14,18,0),SIMD3<Float>(15,18,0),SIMD3<Float>(14,19,0),SIMD3<Float>(15,19,0),SIMD3<Float>(14,19,0),SIMD3<Float>(15,19,0),SIMD3<Float>(14,20,0),SIMD3<Float>(15,20,0),SIMD3<Float>(14,20,0),SIMD3<Float>(15,20,0),SIMD3<Float>(14,21,0),SIMD3<Float>(15,21,0),SIMD3<Float>(14,21,0),SIMD3<Float>(15,21,0),SIMD3<Float>(14,22,0),SIMD3<Float>(15,22,0),SIMD3<Float>(14,22,0),SIMD3<Float>(15,22,0),SIMD3<Float>(14,23,0),SIMD3<Float>(15,23,0),SIMD3<Float>(14,23,0),SIMD3<Float>(15,23,0),SIMD3<Float>(14,24,0),SIMD3<Float>(15,24,0),SIMD3<Float>(14,24,0),SIMD3<Float>(15,24,0),SIMD3<Float>(14,25,0),SIMD3<Float>(15,25,0),SIMD3<Float>(14,25,0),SIMD3<Float>(15,25,0),SIMD3<Float>(14,26,0),SIMD3<Float>(15,26,0),SIMD3<Float>(14,26,0),SIMD3<Float>(15,26,0),SIMD3<Float>(14,27,0),SIMD3<Float>(15,27,0),SIMD3<Float>(14,27,0),SIMD3<Float>(15,27,0),SIMD3<Float>(14,28,0),SIMD3<Float>(15,28,0),SIMD3<Float>(14,28,0),SIMD3<Float>(15,28,0),SIMD3<Float>(14,29,0),SIMD3<Float>(15,29,0),SIMD3<Float>(14,29,0),SIMD3<Float>(15,29,0),SIMD3<Float>(14,30,0),SIMD3<Float>(15,30,0),SIMD3<Float>(14,30,0),SIMD3<Float>(15,30,0),SIMD3<Float>(14,31,0),SIMD3<Float>(15,31,0),SIMD3<Float>(14,31,0),SIMD3<Float>(15,31,0),SIMD3<Float>(14,32,0),SIMD3<Float>(15,32,0),SIMD3<Float>(14,32,0),SIMD3<Float>(15,32,0),SIMD3<Float>(14,33,0),SIMD3<Float>(15,33,0),SIMD3<Float>(14,33,0),SIMD3<Float>(15,33,0),SIMD3<Float>(14,34,0),SIMD3<Float>(15,34,0),SIMD3<Float>(14,34,0),SIMD3<Float>(15,34,0),SIMD3<Float>(14,35,0),SIMD3<Float>(15,35,0),SIMD3<Float>(15,1,0),SIMD3<Float>(16,1,0),SIMD3<Float>(15,2,0),SIMD3<Float>(16,2,0),SIMD3<Float>(15,2,0),SIMD3<Float>(16,2,0),SIMD3<Float>(15,3,0),SIMD3<Float>(16,3,0),SIMD3<Float>(15,3,0),SIMD3<Float>(16,3,0),SIMD3<Float>(15,4,0),SIMD3<Float>(16,4,0),SIMD3<Float>(15,4,0),SIMD3<Float>(16,4,0),SIMD3<Float>(15,5,0),SIMD3<Float>(16,5,0),SIMD3<Float>(15,5,0),SIMD3<Float>(16,5,0),SIMD3<Float>(15,6,0),SIMD3<Float>(16,6,0),SIMD3<Float>(15,6,0),SIMD3<Float>(16,6,0),SIMD3<Float>(15,7,0),SIMD3<Float>(16,7,0),SIMD3<Float>(15,7,0),SIMD3<Float>(16,7,0),SIMD3<Float>(15,8,0),SIMD3<Float>(16,8,0),SIMD3<Float>(15,8,0),SIMD3<Float>(16,8,0),SIMD3<Float>(15,9,0),SIMD3<Float>(16,9,0),SIMD3<Float>(15,9,0),SIMD3<Float>(16,9,0),SIMD3<Float>(15,10,0),SIMD3<Float>(16,10,0),SIMD3<Float>(15,10,0),SIMD3<Float>(16,10,0),SIMD3<Float>(15,11,0),SIMD3<Float>(16,11,0),SIMD3<Float>(15,11,0),SIMD3<Float>(16,11,0),SIMD3<Float>(15,12,0),SIMD3<Float>(16,12,0),SIMD3<Float>(15,12,0),SIMD3<Float>(16,12,0),SIMD3<Float>(15,13,0),SIMD3<Float>(16,13,0),SIMD3<Float>(15,13,0),SIMD3<Float>(16,13,0),SIMD3<Float>(15,14,0),SIMD3<Float>(16,14,0),SIMD3<Float>(15,14,0),SIMD3<Float>(16,14,0),SIMD3<Float>(15,15,0),SIMD3<Float>(16,15,0),SIMD3<Float>(15,15,0),SIMD3<Float>(16,15,0),SIMD3<Float>(15,16,0),SIMD3<Float>(16,16,0),SIMD3<Float>(15,16,0),SIMD3<Float>(16,16,0),SIMD3<Float>(15,17,0),SIMD3<Float>(16,17,0),SIMD3<Float>(15,17,0),SIMD3<Float>(16,17,0),SIMD3<Float>(15,18,0),SIMD3<Float>(16,18,0),SIMD3<Float>(15,18,0),SIMD3<Float>(16,18,0),SIMD3<Float>(15,19,0),SIMD3<Float>(16,19,0),SIMD3<Float>(15,19,0),SIMD3<Float>(16,19,0),SIMD3<Float>(15,20,0),SIMD3<Float>(16,20,0),SIMD3<Float>(15,20,0),SIMD3<Float>(16,20,0),SIMD3<Float>(15,21,0),SIMD3<Float>(16,21,0),SIMD3<Float>(15,21,0),SIMD3<Float>(16,21,0),SIMD3<Float>(15,22,0),SIMD3<Float>(16,22,0),SIMD3<Float>(15,22,0),SIMD3<Float>(16,22,0),SIMD3<Float>(15,23,0),SIMD3<Float>(16,23,0),SIMD3<Float>(15,23,0),SIMD3<Float>(16,23,0),SIMD3<Float>(15,24,0),SIMD3<Float>(16,24,0),SIMD3<Float>(15,24,0),SIMD3<Float>(16,24,0),SIMD3<Float>(15,25,0),SIMD3<Float>(16,25,0),SIMD3<Float>(15,25,0),SIMD3<Float>(16,25,0),SIMD3<Float>(15,26,0),SIMD3<Float>(16,26,0),SIMD3<Float>(15,26,0),SIMD3<Float>(16,26,0),SIMD3<Float>(15,27,0),SIMD3<Float>(16,27,0),SIMD3<Float>(15,27,0),SIMD3<Float>(16,27,0),SIMD3<Float>(15,28,0),SIMD3<Float>(16,28,0),SIMD3<Float>(15,28,0),SIMD3<Float>(16,28,0),SIMD3<Float>(15,29,0),SIMD3<Float>(16,29,0),SIMD3<Float>(15,29,0),SIMD3<Float>(16,29,0),SIMD3<Float>(15,30,0),SIMD3<Float>(16,30,0),SIMD3<Float>(15,30,0),SIMD3<Float>(16,30,0),SIMD3<Float>(15,31,0),SIMD3<Float>(16,31,0),SIMD3<Float>(15,31,0),SIMD3<Float>(16,31,0),SIMD3<Float>(15,32,0),SIMD3<Float>(16,32,0),SIMD3<Float>(15,32,0),SIMD3<Float>(16,32,0),SIMD3<Float>(15,33,0),SIMD3<Float>(16,33,0),SIMD3<Float>(15,33,0),SIMD3<Float>(16,33,0),SIMD3<Float>(15,34,0),SIMD3<Float>(16,34,0),SIMD3<Float>(15,34,0),SIMD3<Float>(16,34,0),SIMD3<Float>(15,35,0),SIMD3<Float>(16,35,0),SIMD3<Float>(16,0,0),SIMD3<Float>(17,0,0),SIMD3<Float>(16,1,0),SIMD3<Float>(17,1,0),SIMD3<Float>(16,1,0),SIMD3<Float>(17,1,0),SIMD3<Float>(16,2,0),SIMD3<Float>(17,2,0),SIMD3<Float>(16,2,0),SIMD3<Float>(17,2,0),SIMD3<Float>(16,3,0),SIMD3<Float>(17,3,0),SIMD3<Float>(16,3,0),SIMD3<Float>(17,3,0),SIMD3<Float>(16,4,0),SIMD3<Float>(17,4,0),SIMD3<Float>(16,4,0),SIMD3<Float>(17,4,0),SIMD3<Float>(16,5,0),SIMD3<Float>(17,5,0),SIMD3<Float>(16,5,0),SIMD3<Float>(17,5,0),SIMD3<Float>(16,6,0),SIMD3<Float>(17,6,0),SIMD3<Float>(16,6,0),SIMD3<Float>(17,6,0),SIMD3<Float>(16,7,0),SIMD3<Float>(17,7,0),SIMD3<Float>(16,7,0),SIMD3<Float>(17,7,0),SIMD3<Float>(16,8,0),SIMD3<Float>(17,8,0),SIMD3<Float>(16,8,0),SIMD3<Float>(17,8,0),SIMD3<Float>(16,9,0),SIMD3<Float>(17,9,0),SIMD3<Float>(16,9,0),SIMD3<Float>(17,9,0),SIMD3<Float>(16,10,0),SIMD3<Float>(17,10,0),SIMD3<Float>(16,10,0),SIMD3<Float>(17,10,0),SIMD3<Float>(16,11,0),SIMD3<Float>(17,11,0),SIMD3<Float>(16,11,0),SIMD3<Float>(17,11,0),SIMD3<Float>(16,12,0),SIMD3<Float>(17,12,0),SIMD3<Float>(16,12,0),SIMD3<Float>(17,12,0),SIMD3<Float>(16,13,0),SIMD3<Float>(17,13,0),SIMD3<Float>(16,13,0),SIMD3<Float>(17,13,0),SIMD3<Float>(16,14,0),SIMD3<Float>(17,14,0),SIMD3<Float>(16,14,0),SIMD3<Float>(17,14,0),SIMD3<Float>(16,15,0),SIMD3<Float>(17,15,0),SIMD3<Float>(16,15,0),SIMD3<Float>(17,15,0),SIMD3<Float>(16,16,0),SIMD3<Float>(17,16,0),SIMD3<Float>(16,16,0),SIMD3<Float>(17,16,0),SIMD3<Float>(16,17,0),SIMD3<Float>(17,17,0),SIMD3<Float>(16,17,0),SIMD3<Float>(17,17,0),SIMD3<Float>(16,18,0),SIMD3<Float>(17,18,0),SIMD3<Float>(16,18,0),SIMD3<Float>(17,18,0),SIMD3<Float>(16,19,0),SIMD3<Float>(17,19,0),SIMD3<Float>(16,19,0),SIMD3<Float>(17,19,0),SIMD3<Float>(16,20,0),SIMD3<Float>(17,20,0),SIMD3<Float>(16,20,0),SIMD3<Float>(17,20,0),SIMD3<Float>(16,21,0),SIMD3<Float>(17,21,0),SIMD3<Float>(16,21,0),SIMD3<Float>(17,21,0),SIMD3<Float>(16,22,0),SIMD3<Float>(17,22,0),SIMD3<Float>(16,22,0),SIMD3<Float>(17,22,0),SIMD3<Float>(16,23,0),SIMD3<Float>(17,23,0),SIMD3<Float>(16,23,0),SIMD3<Float>(17,23,0),SIMD3<Float>(16,24,0),SIMD3<Float>(17,24,0),SIMD3<Float>(16,24,0),SIMD3<Float>(17,24,0),SIMD3<Float>(16,25,0),SIMD3<Float>(17,25,0),SIMD3<Float>(16,25,0),SIMD3<Float>(17,25,0),SIMD3<Float>(16,26,0),SIMD3<Float>(17,26,0),SIMD3<Float>(16,26,0),SIMD3<Float>(17,26,0),SIMD3<Float>(16,27,0),SIMD3<Float>(17,27,0),SIMD3<Float>(16,27,0),SIMD3<Float>(17,27,0),SIMD3<Float>(16,28,0),SIMD3<Float>(17,28,0),SIMD3<Float>(16,28,0),SIMD3<Float>(17,28,0),SIMD3<Float>(16,29,0),SIMD3<Float>(17,29,0),SIMD3<Float>(16,29,0),SIMD3<Float>(17,29,0),SIMD3<Float>(16,30,0),SIMD3<Float>(17,30,0),SIMD3<Float>(16,30,0),SIMD3<Float>(17,30,0),SIMD3<Float>(16,31,0),SIMD3<Float>(17,31,0),SIMD3<Float>(16,31,0),SIMD3<Float>(17,31,0),SIMD3<Float>(16,32,0),SIMD3<Float>(17,32,0),SIMD3<Float>(16,32,0),SIMD3<Float>(17,32,0),SIMD3<Float>(16,33,0),SIMD3<Float>(17,33,0),SIMD3<Float>(16,33,0),SIMD3<Float>(17,33,0),SIMD3<Float>(16,34,0),SIMD3<Float>(17,34,0),SIMD3<Float>(16,34,0),SIMD3<Float>(17,34,0),SIMD3<Float>(16,35,0),SIMD3<Float>(17,35,0),SIMD3<Float>(17,0,0),SIMD3<Float>(18,0,0),SIMD3<Float>(17,1,0),SIMD3<Float>(18,1,0),SIMD3<Float>(17,1,0),SIMD3<Float>(18,1,0),SIMD3<Float>(17,2,0),SIMD3<Float>(18,2,0),SIMD3<Float>(17,2,0),SIMD3<Float>(18,2,0),SIMD3<Float>(17,3,0),SIMD3<Float>(18,3,0),SIMD3<Float>(17,3,0),SIMD3<Float>(18,3,0),SIMD3<Float>(17,4,0),SIMD3<Float>(18,4,0),SIMD3<Float>(17,4,0),SIMD3<Float>(18,4,0),SIMD3<Float>(17,5,0),SIMD3<Float>(18,5,0),SIMD3<Float>(17,5,0),SIMD3<Float>(18,5,0),SIMD3<Float>(17,6,0),SIMD3<Float>(18,6,0),SIMD3<Float>(17,6,0),SIMD3<Float>(18,6,0),SIMD3<Float>(17,7,0),SIMD3<Float>(18,7,0),SIMD3<Float>(17,7,0),SIMD3<Float>(18,7,0),SIMD3<Float>(17,8,0),SIMD3<Float>(18,8,0),SIMD3<Float>(17,8,0),SIMD3<Float>(18,8,0),SIMD3<Float>(17,9,0),SIMD3<Float>(18,9,0),SIMD3<Float>(17,9,0),SIMD3<Float>(18,9,0),SIMD3<Float>(17,10,0),SIMD3<Float>(18,10,0),SIMD3<Float>(17,10,0),SIMD3<Float>(18,10,0),SIMD3<Float>(17,11,0),SIMD3<Float>(18,11,0),SIMD3<Float>(17,11,0),SIMD3<Float>(18,11,0),SIMD3<Float>(17,12,0),SIMD3<Float>(18,12,0),SIMD3<Float>(17,12,0),SIMD3<Float>(18,12,0),SIMD3<Float>(17,13,0),SIMD3<Float>(18,13,0),SIMD3<Float>(17,13,0),SIMD3<Float>(18,13,0),SIMD3<Float>(17,14,0),SIMD3<Float>(18,14,0),SIMD3<Float>(17,14,0),SIMD3<Float>(18,14,0),SIMD3<Float>(17,15,0),SIMD3<Float>(18,15,0),SIMD3<Float>(17,15,0),SIMD3<Float>(18,15,0),SIMD3<Float>(17,16,0),SIMD3<Float>(18,16,0),SIMD3<Float>(17,16,0),SIMD3<Float>(18,16,0),SIMD3<Float>(17,17,0),SIMD3<Float>(18,17,0),SIMD3<Float>(17,17,0),SIMD3<Float>(18,17,0),SIMD3<Float>(17,18,0),SIMD3<Float>(18,18,0),SIMD3<Float>(17,18,0),SIMD3<Float>(18,18,0),SIMD3<Float>(17,19,0),SIMD3<Float>(18,19,0),SIMD3<Float>(17,19,0),SIMD3<Float>(18,19,0),SIMD3<Float>(17,20,0),SIMD3<Float>(18,20,0),SIMD3<Float>(17,20,0),SIMD3<Float>(18,20,0),SIMD3<Float>(17,21,0),SIMD3<Float>(18,21,0),SIMD3<Float>(17,21,0),SIMD3<Float>(18,21,0),SIMD3<Float>(17,22,0),SIMD3<Float>(18,22,0),SIMD3<Float>(17,22,0),SIMD3<Float>(18,22,0),SIMD3<Float>(17,23,0),SIMD3<Float>(18,23,0),SIMD3<Float>(17,23,0),SIMD3<Float>(18,23,0),SIMD3<Float>(17,24,0),SIMD3<Float>(18,24,0),SIMD3<Float>(17,24,0),SIMD3<Float>(18,24,0),SIMD3<Float>(17,25,0),SIMD3<Float>(18,25,0),SIMD3<Float>(17,25,0),SIMD3<Float>(18,25,0),SIMD3<Float>(17,26,0),SIMD3<Float>(18,26,0),SIMD3<Float>(17,26,0),SIMD3<Float>(18,26,0),SIMD3<Float>(17,27,0),SIMD3<Float>(18,27,0),SIMD3<Float>(17,27,0),SIMD3<Float>(18,27,0),SIMD3<Float>(17,28,0),SIMD3<Float>(18,28,0),SIMD3<Float>(17,28,0),SIMD3<Float>(18,28,0),SIMD3<Float>(17,29,0),SIMD3<Float>(18,29,0),SIMD3<Float>(17,29,0),SIMD3<Float>(18,29,0),SIMD3<Float>(17,30,0),SIMD3<Float>(18,30,0),SIMD3<Float>(17,30,0),SIMD3<Float>(18,30,0),SIMD3<Float>(17,31,0),SIMD3<Float>(18,31,0),SIMD3<Float>(17,31,0),SIMD3<Float>(18,31,0),SIMD3<Float>(17,32,0),SIMD3<Float>(18,32,0),SIMD3<Float>(17,32,0),SIMD3<Float>(18,32,0),SIMD3<Float>(17,33,0),SIMD3<Float>(18,33,0),SIMD3<Float>(17,33,0),SIMD3<Float>(18,33,0),SIMD3<Float>(17,34,0),SIMD3<Float>(18,34,0),SIMD3<Float>(17,34,0),SIMD3<Float>(18,34,0),SIMD3<Float>(17,35,0),SIMD3<Float>(18,35,0),SIMD3<Float>(18,1,0),SIMD3<Float>(19,1,0),SIMD3<Float>(18,2,0),SIMD3<Float>(19,2,0),SIMD3<Float>(18,2,0),SIMD3<Float>(19,2,0),SIMD3<Float>(18,3,0),SIMD3<Float>(19,3,0),SIMD3<Float>(18,3,0),SIMD3<Float>(19,3,0),SIMD3<Float>(18,4,0),SIMD3<Float>(19,4,0),SIMD3<Float>(18,4,0),SIMD3<Float>(19,4,0),SIMD3<Float>(18,5,0),SIMD3<Float>(19,5,0),SIMD3<Float>(18,5,0),SIMD3<Float>(19,5,0),SIMD3<Float>(18,6,0),SIMD3<Float>(19,6,0),SIMD3<Float>(18,6,0),SIMD3<Float>(19,6,0),SIMD3<Float>(18,7,0),SIMD3<Float>(19,7,0),SIMD3<Float>(18,7,0),SIMD3<Float>(19,7,0),SIMD3<Float>(18,8,0),SIMD3<Float>(19,8,0),SIMD3<Float>(18,8,0),SIMD3<Float>(19,8,0),SIMD3<Float>(18,9,0),SIMD3<Float>(19,9,0),SIMD3<Float>(18,9,0),SIMD3<Float>(19,9,0),SIMD3<Float>(18,10,0),SIMD3<Float>(19,10,0),SIMD3<Float>(18,10,0),SIMD3<Float>(19,10,0),SIMD3<Float>(18,11,0),SIMD3<Float>(19,11,0),SIMD3<Float>(18,11,0),SIMD3<Float>(19,11,0),SIMD3<Float>(18,12,0),SIMD3<Float>(19,12,0),SIMD3<Float>(18,12,0),SIMD3<Float>(19,12,0),SIMD3<Float>(18,13,0),SIMD3<Float>(19,13,0),SIMD3<Float>(18,13,0),SIMD3<Float>(19,13,0),SIMD3<Float>(18,14,0),SIMD3<Float>(19,14,0),SIMD3<Float>(18,14,0),SIMD3<Float>(19,14,0),SIMD3<Float>(18,15,0),SIMD3<Float>(19,15,0),SIMD3<Float>(18,15,0),SIMD3<Float>(19,15,0),SIMD3<Float>(18,16,0),SIMD3<Float>(19,16,0),SIMD3<Float>(18,16,0),SIMD3<Float>(19,16,0),SIMD3<Float>(18,17,0),SIMD3<Float>(19,17,0),SIMD3<Float>(18,17,0),SIMD3<Float>(19,17,0),SIMD3<Float>(18,18,0),SIMD3<Float>(19,18,0),SIMD3<Float>(18,18,0),SIMD3<Float>(19,18,0),SIMD3<Float>(18,19,0),SIMD3<Float>(19,19,0),SIMD3<Float>(18,19,0),SIMD3<Float>(19,19,0),SIMD3<Float>(18,20,0),SIMD3<Float>(19,20,0),SIMD3<Float>(18,20,0),SIMD3<Float>(19,20,0),SIMD3<Float>(18,21,0),SIMD3<Float>(19,21,0),SIMD3<Float>(18,21,0),SIMD3<Float>(19,21,0),SIMD3<Float>(18,22,0),SIMD3<Float>(19,22,0),SIMD3<Float>(18,22,0),SIMD3<Float>(19,22,0),SIMD3<Float>(18,23,0),SIMD3<Float>(19,23,0),SIMD3<Float>(18,23,0),SIMD3<Float>(19,23,0),SIMD3<Float>(18,24,0),SIMD3<Float>(19,24,0),SIMD3<Float>(18,24,0),SIMD3<Float>(19,24,0),SIMD3<Float>(18,25,0),SIMD3<Float>(19,25,0),SIMD3<Float>(18,25,0),SIMD3<Float>(19,25,0),SIMD3<Float>(18,26,0),SIMD3<Float>(19,26,0),SIMD3<Float>(18,26,0),SIMD3<Float>(19,26,0),SIMD3<Float>(18,27,0),SIMD3<Float>(19,27,0),SIMD3<Float>(18,27,0),SIMD3<Float>(19,27,0),SIMD3<Float>(18,28,0),SIMD3<Float>(19,28,0),SIMD3<Float>(18,28,0),SIMD3<Float>(19,28,0),SIMD3<Float>(18,29,0),SIMD3<Float>(19,29,0),SIMD3<Float>(18,29,0),SIMD3<Float>(19,29,0),SIMD3<Float>(18,30,0),SIMD3<Float>(19,30,0),SIMD3<Float>(18,30,0),SIMD3<Float>(19,30,0),SIMD3<Float>(18,31,0),SIMD3<Float>(19,31,0),SIMD3<Float>(18,31,0),SIMD3<Float>(19,31,0),SIMD3<Float>(18,32,0),SIMD3<Float>(19,32,0),SIMD3<Float>(18,32,0),SIMD3<Float>(19,32,0),SIMD3<Float>(18,33,0),SIMD3<Float>(19,33,0),SIMD3<Float>(18,33,0),SIMD3<Float>(19,33,0),SIMD3<Float>(18,34,0),SIMD3<Float>(19,34,0),SIMD3<Float>(18,34,0),SIMD3<Float>(19,34,0),SIMD3<Float>(18,35,0),SIMD3<Float>(19,35,0),SIMD3<Float>(19,31,0),SIMD3<Float>(20,31,0),SIMD3<Float>(19,32,0),SIMD3<Float>(20,32,0),SIMD3<Float>(19,32,0),SIMD3<Float>(20,32,0),SIMD3<Float>(19,33,0),SIMD3<Float>(20,33,0),SIMD3<Float>(19,33,0),SIMD3<Float>(20,33,0),SIMD3<Float>(19,34,0),SIMD3<Float>(20,34,0),SIMD3<Float>(19,34,0),SIMD3<Float>(20,34,0),SIMD3<Float>(19,35,0),SIMD3<Float>(20,35,0),SIMD3<Float>(20,31,0),SIMD3<Float>(21,31,0),SIMD3<Float>(20,32,0),SIMD3<Float>(21,32,0),SIMD3<Float>(20,32,0),SIMD3<Float>(21,32,0),SIMD3<Float>(20,33,0),SIMD3<Float>(21,33,0),SIMD3<Float>(20,33,0),SIMD3<Float>(21,33,0),SIMD3<Float>(20,34,0),SIMD3<Float>(21,34,0),SIMD3<Float>(20,34,0),SIMD3<Float>(21,34,0),SIMD3<Float>(20,35,0),SIMD3<Float>(21,35,0),SIMD3<Float>(21,31,0),SIMD3<Float>(22,31,0),SIMD3<Float>(21,32,0),SIMD3<Float>(22,32,0),SIMD3<Float>(21,32,0),SIMD3<Float>(22,32,0),SIMD3<Float>(21,33,0),SIMD3<Float>(22,33,0),SIMD3<Float>(21,33,0),SIMD3<Float>(22,33,0),SIMD3<Float>(21,34,0),SIMD3<Float>(22,34,0),SIMD3<Float>(21,34,0),SIMD3<Float>(22,34,0),SIMD3<Float>(21,35,0),SIMD3<Float>(22,35,0),SIMD3<Float>(22,31,0),SIMD3<Float>(23,31,0),SIMD3<Float>(22,32,0),SIMD3<Float>(23,32,0),SIMD3<Float>(22,32,0),SIMD3<Float>(23,32,0),SIMD3<Float>(22,33,0),SIMD3<Float>(23,33,0),SIMD3<Float>(22,33,0),SIMD3<Float>(23,33,0),SIMD3<Float>(22,34,0),SIMD3<Float>(23,34,0),SIMD3<Float>(22,34,0),SIMD3<Float>(23,34,0),SIMD3<Float>(22,35,0),SIMD3<Float>(23,35,0),SIMD3<Float>(23,31,0),SIMD3<Float>(24,31,0),SIMD3<Float>(23,32,0),SIMD3<Float>(24,32,0),SIMD3<Float>(23,32,0),SIMD3<Float>(24,32,0),SIMD3<Float>(23,33,0),SIMD3<Float>(24,33,0),SIMD3<Float>(23,33,0),SIMD3<Float>(24,33,0),SIMD3<Float>(23,34,0),SIMD3<Float>(24,34,0),SIMD3<Float>(23,34,0),SIMD3<Float>(24,34,0),SIMD3<Float>(23,35,0),SIMD3<Float>(24,35,0),SIMD3<Float>(24,31,0),SIMD3<Float>(25,31,0),SIMD3<Float>(24,32,0),SIMD3<Float>(25,32,0),SIMD3<Float>(24,32,0),SIMD3<Float>(25,32,0),SIMD3<Float>(24,33,0),SIMD3<Float>(25,33,0),SIMD3<Float>(24,33,0),SIMD3<Float>(25,33,0),SIMD3<Float>(24,34,0),SIMD3<Float>(25,34,0),SIMD3<Float>(24,34,0),SIMD3<Float>(25,34,0),SIMD3<Float>(24,35,0),SIMD3<Float>(25,35,0),SIMD3<Float>(25,31,0),SIMD3<Float>(26,31,0),SIMD3<Float>(25,32,0),SIMD3<Float>(26,32,0),SIMD3<Float>(25,32,0),SIMD3<Float>(26,32,0),SIMD3<Float>(25,33,0),SIMD3<Float>(26,33,0),SIMD3<Float>(25,33,0),SIMD3<Float>(26,33,0),SIMD3<Float>(25,34,0),SIMD3<Float>(26,34,0),SIMD3<Float>(25,34,0),SIMD3<Float>(26,34,0),SIMD3<Float>(25,35,0),SIMD3<Float>(26,35,0),SIMD3<Float>(26,32,0),SIMD3<Float>(27,32,0),SIMD3<Float>(26,33,0),SIMD3<Float>(27,33,0),SIMD3<Float>(26,33,0),SIMD3<Float>(27,33,0),SIMD3<Float>(26,34,0),SIMD3<Float>(27,34,0),SIMD3<Float>(26,34,0),SIMD3<Float>(27,34,0),SIMD3<Float>(26,35,0),SIMD3<Float>(27,35,0),SIMD3<Float>(27,32,0),SIMD3<Float>(28,32,0),SIMD3<Float>(27,33,0),SIMD3<Float>(28,33,0),SIMD3<Float>(27,33,0),SIMD3<Float>(28,33,0),SIMD3<Float>(27,34,0),SIMD3<Float>(28,34,0),SIMD3<Float>(27,34,0),SIMD3<Float>(28,34,0),SIMD3<Float>(27,35,0),SIMD3<Float>(28,35,0)
		]
		for position in positions {
			self.vertices.append(Vertex(position: position, color: SIMD4<Float>(0,0,0,1)))
		}
		indices = [
			0,1,2,3,1,2,4,5,6,7,5,6,8,9,10,11,9,10,12,13,14,15,13,14,16,17,18,19,17,18,20,21,22,23,21,22,24,25,26,27,25,26,28,29,30,31,29,30,32,33,34,35,33,34,36,37,38,39,37,38,40,41,42,43,41,42,44,45,46,47,45,46,48,49,50,51,49,50,52,53,54,55,53,54,56,57,58,59,57,58,60,61,62,63,61,62,64,65,66,67,65,66,68,69,70,71,69,70,72,73,74,75,73,74,76,77,78,79,77,78,80,81,82,83,81,82,84,85,86,87,85,86,88,89,90,91,89,90,92,93,94,95,93,94,96,97,98,99,97,98,100,101,102,103,101,102,104,105,106,107,105,106,108,109,110,111,109,110,112,113,114,115,113,114,116,117,118,119,117,118,120,121,122,123,121,122,124,125,126,127,125,126,128,129,130,131,129,130,132,133,134,135,133,134,136,137,138,139,137,138,140,141,142,143,141,142,144,145,146,147,145,146,148,149,150,151,149,150,152,153,154,155,153,154,156,157,158,159,157,158,160,161,162,163,161,162,164,165,166,167,165,166,168,169,170,171,169,170,172,173,174,175,173,174,176,177,178,179,177,178,180,181,182,183,181,182,184,185,186,187,185,186,188,189,190,191,189,190,192,193,194,195,193,194,196,197,198,199,197,198,200,201,202,203,201,202,204,205,206,207,205,206,208,209,210,211,209,210,212,213,214,215,213,214,216,217,218,219,217,218,220,221,222,223,221,222,224,225,226,227,225,226,228,229,230,231,229,230,232,233,234,235,233,234,236,237,238,239,237,238,240,241,242,243,241,242,244,245,246,247,245,246,248,249,250,251,249,250,252,253,254,255,253,254,256,257,258,259,257,258,260,261,262,263,261,262,264,265,266,267,265,266,268,269,270,271,269,270,272,273,274,275,273,274,276,277,278,279,277,278,280,281,282,283,281,282,284,285,286,287,285,286,288,289,290,291,289,290,292,293,294,295,293,294,296,297,298,299,297,298,300,301,302,303,301,302,304,305,306,307,305,306,308,309,310,311,309,310,312,313,314,315,313,314,316,317,318,319,317,318,320,321,322,323,321,322,324,325,326,327,325,326,328,329,330,331,329,330,332,333,334,335,333,334,336,337,338,339,337,338,340,341,342,343,341,342,344,345,346,347,345,346,348,349,350,351,349,350,352,353,354,355,353,354,356,357,358,359,357,358,360,361,362,363,361,362,364,365,366,367,365,366,368,369,370,371,369,370,372,373,374,375,373,374,376,377,378,379,377,378,380,381,382,383,381,382,384,385,386,387,385,386,388,389,390,391,389,390,392,393,394,395,393,394,396,397,398,399,397,398,400,401,402,403,401,402,404,405,406,407,405,406,408,409,410,411,409,410,412,413,414,415,413,414,416,417,418,419,417,418,420,421,422,423,421,422,424,425,426,427,425,426,428,429,430,431,429,430,432,433,434,435,433,434,436,437,438,439,437,438,440,441,442,443,441,442,444,445,446,447,445,446,448,449,450,451,449,450,452,453,454,455,453,454,456,457,458,459,457,458,460,461,462,463,461,462,464,465,466,467,465,466,468,469,470,471,469,470,472,473,474,475,473,474,476,477,478,479,477,478,480,481,482,483,481,482,484,485,486,487,485,486,488,489,490,491,489,490,492,493,494,495,493,494,496,497,498,499,497,498,500,501,502,503,501,502,504,505,506,507,505,506,508,509,510,511,509,510,512,513,514,515,513,514,516,517,518,519,517,518,520,521,522,523,521,522,524,525,526,527,525,526,528,529,530,531,529,530,532,533,534,535,533,534,536,537,538,539,537,538,540,541,542,543,541,542,544,545,546,547,545,546,548,549,550,551,549,550,552,553,554,555,553,554,556,557,558,559,557,558,560,561,562,563,561,562,564,565,566,567,565,566,568,569,570,571,569,570,572,573,574,575,573,574,576,577,578,579,577,578,580,581,582,583,581,582,584,585,586,587,585,586,588,589,590,591,589,590,592,593,594,595,593,594,596,597,598,599,597,598,600,601,602,603,601,602,604,605,606,607,605,606,608,609,610,611,609,610,612,613,614,615,613,614,616,617,618,619,617,618,620,621,622,623,621,622,624,625,626,627,625,626,628,629,630,631,629,630,632,633,634,635,633,634,636,637,638,639,637,638,640,641,642,643,641,642,644,645,646,647,645,646,648,649,650,651,649,650,652,653,654,655,653,654,656,657,658,659,657,658,660,661,662,663,661,662,664,665,666,667,665,666,668,669,670,671,669,670,672,673,674,675,673,674,676,677,678,679,677,678,680,681,682,683,681,682,684,685,686,687,685,686,688,689,690,691,689,690,692,693,694,695,693,694,696,697,698,699,697,698,700,701,702,703,701,702,704,705,706,707,705,706,708,709,710,711,709,710,712,713,714,715,713,714,716,717,718,719,717,718,720,721,722,723,721,722,724,725,726,727,725,726,728,729,730,731,729,730,732,733,734,735,733,734,736,737,738,739,737,738,740,741,742,743,741,742,744,745,746,747,745,746,748,749,750,751,749,750,752,753,754,755,753,754,756,757,758,759,757,758,760,761,762,763,761,762,764,765,766,767,765,766,768,769,770,771,769,770,772,773,774,775,773,774,776,777,778,779,777,778,780,781,782,783,781,782,784,785,786,787,785,786,788,789,790,791,789,790,792,793,794,795,793,794,796,797,798,799,797,798,800,801,802,803,801,802,804,805,806,807,805,806,808,809,810,811,809,810,812,813,814,815,813,814,816,817,818,819,817,818,820,821,822,823,821,822,824,825,826,827,825,826,828,829,830,831,829,830,832,833,834,835,833,834,836,837,838,839,837,838,840,841,842,843,841,842,844,845,846,847,845,846,848,849,850,851,849,850,852,853,854,855,853,854,856,857,858,859,857,858,860,861,862,863,861,862,864,865,866,867,865,866,868,869,870,871,869,870,872,873,874,875,873,874,876,877,878,879,877,878,880,881,882,883,881,882,884,885,886,887,885,886,888,889,890,891,889,890,892,893,894,895,893,894,896,897,898,899,897,898,900,901,902,903,901,902,904,905,906,907,905,906,908,909,910,911,909,910,912,913,914,915,913,914,916,917,918,919,917,918,920,921,922,923,921,922,924,925,926,927,925,926,928,929,930,931,929,930,932,933,934,935,933,934,936,937,938,939,937,938,940,941,942,943,941,942,944,945,946,947,945,946,948,949,950,951,949,950,952,953,954,955,953,954,956,957,958,959,957,958,960,961,962,963,961,962,964,965,966,967,965,966,968,969,970,971,969,970,972,973,974,975,973,974,976,977,978,979,977,978,980,981,982,983,981,982,984,985,986,987,985,986,988,989,990,991,989,990,992,993,994,995,993,994,996,997,998,999,997,998,1000,1001,1002,1003,1001,1002,1004,1005,1006,1007,1005,1006,1008,1009,1010,1011,1009,1010,1012,1013,1014,1015,1013,1014,1016,1017,1018,1019,1017,1018,1020,1021,1022,1023,1021,1022,1024,1025,1026,1027,1025,1026,1028,1029,1030,1031,1029,1030,1032,1033,1034,1035,1033,1034,1036,1037,1038,1039,1037,1038,1040,1041,1042,1043,1041,1042,1044,1045,1046,1047,1045,1046,1048,1049,1050,1051,1049,1050,1052,1053,1054,1055,1053,1054,1056,1057,1058,1059,1057,1058,1060,1061,1062,1063,1061,1062,1064,1065,1066,1067,1065,1066,1068,1069,1070,1071,1069,1070,1072,1073,1074,1075,1073,1074,1076,1077,1078,1079,1077,1078,1080,1081,1082,1083,1081,1082,1084,1085,1086,1087,1085,1086,1088,1089,1090,1091,1089,1090,1092,1093,1094,1095,1093,1094,1096,1097,1098,1099,1097,1098,1100,1101,1102,1103,1101,1102,1104,1105,1106,1107,1105,1106,1108,1109,1110,1111,1109,1110,1112,1113,1114,1115,1113,1114,1116,1117,1118,1119,1117,1118,1120,1121,1122,1123,1121,1122,1124,1125,1126,1127,1125,1126,1128,1129,1130,1131,1129,1130,1132,1133,1134,1135,1133,1134,1136,1137,1138,1139,1137,1138,1140,1141,1142,1143,1141,1142,1144,1145,1146,1147,1145,1146
		]
	}
}
