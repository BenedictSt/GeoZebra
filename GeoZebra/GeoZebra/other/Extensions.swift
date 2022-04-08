//
//  Extensions.swift
//  GeoZebra
//
//  Created by Benedict on 19.01.22.
//

import Foundation
import AppKit

extension String {
	var length: Int {
		return count
	}
	
	subscript (i: Int) -> String {
		return self[i ..< i + 1]
	}
	
	func substring(fromIndex: Int) -> String {
		return self[min(fromIndex, length) ..< length]
	}
	
	func substring(toIndex: Int) -> String {
		return self[0 ..< max(0, toIndex)]
	}
	
	subscript (r: Range<Int>) -> String {
		let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
											upper: min(length, max(0, r.upperBound))))
		let start = index(startIndex, offsetBy: range.lowerBound)
		let end = index(start, offsetBy: range.upperBound - range.lowerBound)
		return String(self[start ..< end])
	}
	
	
	///- Returns: Ein Array, in dem die einzelnen Zeichen des Strings als Strings drin sind
	func toStringArray() -> [String]{
		return Array(self).map({String($0)})
	}
}

extension Float{
	///rounds to n- decimal places
	func round(places: Int) -> Float{
		let factor = pow(10, Float(places))
		return (self * factor).rounded() / factor
	}
}

func copyToClipBoard(str: String) {
	let pasteBoard = NSPasteboard.general
	pasteBoard.clearContents()
	pasteBoard.setString(str, forType: .string)
	messagePublisher.sendeNachricht("kopiert")
}
