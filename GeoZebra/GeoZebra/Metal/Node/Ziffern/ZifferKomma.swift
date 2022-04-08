//
//  Ziffer1.swift
//  GeoZebra
//
//  Created by Benedict on 07.01.22.
//

import Foundation
class Ziffer_Komma: Primitive {
	override func buildDefaultVertices() {
		vertices = []
		let positions: [SIMD3<Float>] = [
			SIMD3<Float>(7,40,0),SIMD3<Float>(8,40,0),SIMD3<Float>(7,41,0),SIMD3<Float>(8,41,0),SIMD3<Float>(7,41,0),SIMD3<Float>(8,41,0),SIMD3<Float>(7,42,0),SIMD3<Float>(8,42,0),SIMD3<Float>(7,42,0),SIMD3<Float>(8,42,0),SIMD3<Float>(7,43,0),SIMD3<Float>(8,43,0),SIMD3<Float>(8,35,0),SIMD3<Float>(9,35,0),SIMD3<Float>(8,36,0),SIMD3<Float>(9,36,0),SIMD3<Float>(8,36,0),SIMD3<Float>(9,36,0),SIMD3<Float>(8,37,0),SIMD3<Float>(9,37,0),SIMD3<Float>(8,37,0),SIMD3<Float>(9,37,0),SIMD3<Float>(8,38,0),SIMD3<Float>(9,38,0),SIMD3<Float>(8,38,0),SIMD3<Float>(9,38,0),SIMD3<Float>(8,39,0),SIMD3<Float>(9,39,0),SIMD3<Float>(8,39,0),SIMD3<Float>(9,39,0),SIMD3<Float>(8,40,0),SIMD3<Float>(9,40,0),SIMD3<Float>(8,40,0),SIMD3<Float>(9,40,0),SIMD3<Float>(8,41,0),SIMD3<Float>(9,41,0),SIMD3<Float>(8,41,0),SIMD3<Float>(9,41,0),SIMD3<Float>(8,42,0),SIMD3<Float>(9,42,0),SIMD3<Float>(8,42,0),SIMD3<Float>(9,42,0),SIMD3<Float>(8,43,0),SIMD3<Float>(9,43,0),SIMD3<Float>(8,43,0),SIMD3<Float>(9,43,0),SIMD3<Float>(8,44,0),SIMD3<Float>(9,44,0),SIMD3<Float>(9,30,0),SIMD3<Float>(10,30,0),SIMD3<Float>(9,31,0),SIMD3<Float>(10,31,0),SIMD3<Float>(9,31,0),SIMD3<Float>(10,31,0),SIMD3<Float>(9,32,0),SIMD3<Float>(10,32,0),SIMD3<Float>(9,32,0),SIMD3<Float>(10,32,0),SIMD3<Float>(9,33,0),SIMD3<Float>(10,33,0),SIMD3<Float>(9,33,0),SIMD3<Float>(10,33,0),SIMD3<Float>(9,34,0),SIMD3<Float>(10,34,0),SIMD3<Float>(9,34,0),SIMD3<Float>(10,34,0),SIMD3<Float>(9,35,0),SIMD3<Float>(10,35,0),SIMD3<Float>(9,35,0),SIMD3<Float>(10,35,0),SIMD3<Float>(9,36,0),SIMD3<Float>(10,36,0),SIMD3<Float>(9,36,0),SIMD3<Float>(10,36,0),SIMD3<Float>(9,37,0),SIMD3<Float>(10,37,0),SIMD3<Float>(9,37,0),SIMD3<Float>(10,37,0),SIMD3<Float>(9,38,0),SIMD3<Float>(10,38,0),SIMD3<Float>(9,38,0),SIMD3<Float>(10,38,0),SIMD3<Float>(9,39,0),SIMD3<Float>(10,39,0),SIMD3<Float>(9,39,0),SIMD3<Float>(10,39,0),SIMD3<Float>(9,40,0),SIMD3<Float>(10,40,0),SIMD3<Float>(9,40,0),SIMD3<Float>(10,40,0),SIMD3<Float>(9,41,0),SIMD3<Float>(10,41,0),SIMD3<Float>(9,41,0),SIMD3<Float>(10,41,0),SIMD3<Float>(9,42,0),SIMD3<Float>(10,42,0),SIMD3<Float>(9,42,0),SIMD3<Float>(10,42,0),SIMD3<Float>(9,43,0),SIMD3<Float>(10,43,0),SIMD3<Float>(9,43,0),SIMD3<Float>(10,43,0),SIMD3<Float>(9,44,0),SIMD3<Float>(10,44,0),SIMD3<Float>(10,27,0),SIMD3<Float>(11,27,0),SIMD3<Float>(10,28,0),SIMD3<Float>(11,28,0),SIMD3<Float>(10,28,0),SIMD3<Float>(11,28,0),SIMD3<Float>(10,29,0),SIMD3<Float>(11,29,0),SIMD3<Float>(10,29,0),SIMD3<Float>(11,29,0),SIMD3<Float>(10,30,0),SIMD3<Float>(11,30,0),SIMD3<Float>(10,30,0),SIMD3<Float>(11,30,0),SIMD3<Float>(10,31,0),SIMD3<Float>(11,31,0),SIMD3<Float>(10,31,0),SIMD3<Float>(11,31,0),SIMD3<Float>(10,32,0),SIMD3<Float>(11,32,0),SIMD3<Float>(10,32,0),SIMD3<Float>(11,32,0),SIMD3<Float>(10,33,0),SIMD3<Float>(11,33,0),SIMD3<Float>(10,33,0),SIMD3<Float>(11,33,0),SIMD3<Float>(10,34,0),SIMD3<Float>(11,34,0),SIMD3<Float>(10,34,0),SIMD3<Float>(11,34,0),SIMD3<Float>(10,35,0),SIMD3<Float>(11,35,0),SIMD3<Float>(10,35,0),SIMD3<Float>(11,35,0),SIMD3<Float>(10,36,0),SIMD3<Float>(11,36,0),SIMD3<Float>(10,36,0),SIMD3<Float>(11,36,0),SIMD3<Float>(10,37,0),SIMD3<Float>(11,37,0),SIMD3<Float>(10,37,0),SIMD3<Float>(11,37,0),SIMD3<Float>(10,38,0),SIMD3<Float>(11,38,0),SIMD3<Float>(10,38,0),SIMD3<Float>(11,38,0),SIMD3<Float>(10,39,0),SIMD3<Float>(11,39,0),SIMD3<Float>(10,39,0),SIMD3<Float>(11,39,0),SIMD3<Float>(10,40,0),SIMD3<Float>(11,40,0),SIMD3<Float>(10,40,0),SIMD3<Float>(11,40,0),SIMD3<Float>(10,41,0),SIMD3<Float>(11,41,0),SIMD3<Float>(10,41,0),SIMD3<Float>(11,41,0),SIMD3<Float>(10,42,0),SIMD3<Float>(11,42,0),SIMD3<Float>(10,42,0),SIMD3<Float>(11,42,0),SIMD3<Float>(10,43,0),SIMD3<Float>(11,43,0),SIMD3<Float>(10,43,0),SIMD3<Float>(11,43,0),SIMD3<Float>(10,44,0),SIMD3<Float>(11,44,0),SIMD3<Float>(11,27,0),SIMD3<Float>(12,27,0),SIMD3<Float>(11,28,0),SIMD3<Float>(12,28,0),SIMD3<Float>(11,28,0),SIMD3<Float>(12,28,0),SIMD3<Float>(11,29,0),SIMD3<Float>(12,29,0),SIMD3<Float>(11,29,0),SIMD3<Float>(12,29,0),SIMD3<Float>(11,30,0),SIMD3<Float>(12,30,0),SIMD3<Float>(11,30,0),SIMD3<Float>(12,30,0),SIMD3<Float>(11,31,0),SIMD3<Float>(12,31,0),SIMD3<Float>(11,31,0),SIMD3<Float>(12,31,0),SIMD3<Float>(11,32,0),SIMD3<Float>(12,32,0),SIMD3<Float>(11,32,0),SIMD3<Float>(12,32,0),SIMD3<Float>(11,33,0),SIMD3<Float>(12,33,0),SIMD3<Float>(11,33,0),SIMD3<Float>(12,33,0),SIMD3<Float>(11,34,0),SIMD3<Float>(12,34,0),SIMD3<Float>(11,34,0),SIMD3<Float>(12,34,0),SIMD3<Float>(11,35,0),SIMD3<Float>(12,35,0),SIMD3<Float>(11,35,0),SIMD3<Float>(12,35,0),SIMD3<Float>(11,36,0),SIMD3<Float>(12,36,0),SIMD3<Float>(11,36,0),SIMD3<Float>(12,36,0),SIMD3<Float>(11,37,0),SIMD3<Float>(12,37,0),SIMD3<Float>(11,37,0),SIMD3<Float>(12,37,0),SIMD3<Float>(11,38,0),SIMD3<Float>(12,38,0),SIMD3<Float>(11,38,0),SIMD3<Float>(12,38,0),SIMD3<Float>(11,39,0),SIMD3<Float>(12,39,0),SIMD3<Float>(11,39,0),SIMD3<Float>(12,39,0),SIMD3<Float>(11,40,0),SIMD3<Float>(12,40,0),SIMD3<Float>(11,40,0),SIMD3<Float>(12,40,0),SIMD3<Float>(11,41,0),SIMD3<Float>(12,41,0),SIMD3<Float>(11,41,0),SIMD3<Float>(12,41,0),SIMD3<Float>(11,42,0),SIMD3<Float>(12,42,0),SIMD3<Float>(11,42,0),SIMD3<Float>(12,42,0),SIMD3<Float>(11,43,0),SIMD3<Float>(12,43,0),SIMD3<Float>(12,27,0),SIMD3<Float>(13,27,0),SIMD3<Float>(12,28,0),SIMD3<Float>(13,28,0),SIMD3<Float>(12,28,0),SIMD3<Float>(13,28,0),SIMD3<Float>(12,29,0),SIMD3<Float>(13,29,0),SIMD3<Float>(12,29,0),SIMD3<Float>(13,29,0),SIMD3<Float>(12,30,0),SIMD3<Float>(13,30,0),SIMD3<Float>(12,30,0),SIMD3<Float>(13,30,0),SIMD3<Float>(12,31,0),SIMD3<Float>(13,31,0),SIMD3<Float>(12,31,0),SIMD3<Float>(13,31,0),SIMD3<Float>(12,32,0),SIMD3<Float>(13,32,0),SIMD3<Float>(12,32,0),SIMD3<Float>(13,32,0),SIMD3<Float>(12,33,0),SIMD3<Float>(13,33,0),SIMD3<Float>(12,33,0),SIMD3<Float>(13,33,0),SIMD3<Float>(12,34,0),SIMD3<Float>(13,34,0),SIMD3<Float>(12,34,0),SIMD3<Float>(13,34,0),SIMD3<Float>(12,35,0),SIMD3<Float>(13,35,0),SIMD3<Float>(12,35,0),SIMD3<Float>(13,35,0),SIMD3<Float>(12,36,0),SIMD3<Float>(13,36,0),SIMD3<Float>(12,36,0),SIMD3<Float>(13,36,0),SIMD3<Float>(12,37,0),SIMD3<Float>(13,37,0),SIMD3<Float>(12,37,0),SIMD3<Float>(13,37,0),SIMD3<Float>(12,38,0),SIMD3<Float>(13,38,0),SIMD3<Float>(12,38,0),SIMD3<Float>(13,38,0),SIMD3<Float>(12,39,0),SIMD3<Float>(13,39,0),SIMD3<Float>(12,39,0),SIMD3<Float>(13,39,0),SIMD3<Float>(12,40,0),SIMD3<Float>(13,40,0),SIMD3<Float>(12,40,0),SIMD3<Float>(13,40,0),SIMD3<Float>(12,41,0),SIMD3<Float>(13,41,0),SIMD3<Float>(13,27,0),SIMD3<Float>(14,27,0),SIMD3<Float>(13,28,0),SIMD3<Float>(14,28,0),SIMD3<Float>(13,28,0),SIMD3<Float>(14,28,0),SIMD3<Float>(13,29,0),SIMD3<Float>(14,29,0),SIMD3<Float>(13,29,0),SIMD3<Float>(14,29,0),SIMD3<Float>(13,30,0),SIMD3<Float>(14,30,0),SIMD3<Float>(13,30,0),SIMD3<Float>(14,30,0),SIMD3<Float>(13,31,0),SIMD3<Float>(14,31,0),SIMD3<Float>(13,31,0),SIMD3<Float>(14,31,0),SIMD3<Float>(13,32,0),SIMD3<Float>(14,32,0),SIMD3<Float>(13,32,0),SIMD3<Float>(14,32,0),SIMD3<Float>(13,33,0),SIMD3<Float>(14,33,0),SIMD3<Float>(13,33,0),SIMD3<Float>(14,33,0),SIMD3<Float>(13,34,0),SIMD3<Float>(14,34,0),SIMD3<Float>(13,34,0),SIMD3<Float>(14,34,0),SIMD3<Float>(13,35,0),SIMD3<Float>(14,35,0),SIMD3<Float>(13,35,0),SIMD3<Float>(14,35,0),SIMD3<Float>(13,36,0),SIMD3<Float>(14,36,0),SIMD3<Float>(13,36,0),SIMD3<Float>(14,36,0),SIMD3<Float>(13,37,0),SIMD3<Float>(14,37,0),SIMD3<Float>(13,37,0),SIMD3<Float>(14,37,0),SIMD3<Float>(13,38,0),SIMD3<Float>(14,38,0),SIMD3<Float>(13,38,0),SIMD3<Float>(14,38,0),SIMD3<Float>(13,39,0),SIMD3<Float>(14,39,0),SIMD3<Float>(14,27,0),SIMD3<Float>(15,27,0),SIMD3<Float>(14,28,0),SIMD3<Float>(15,28,0),SIMD3<Float>(14,28,0),SIMD3<Float>(15,28,0),SIMD3<Float>(14,29,0),SIMD3<Float>(15,29,0),SIMD3<Float>(14,29,0),SIMD3<Float>(15,29,0),SIMD3<Float>(14,30,0),SIMD3<Float>(15,30,0),SIMD3<Float>(14,30,0),SIMD3<Float>(15,30,0),SIMD3<Float>(14,31,0),SIMD3<Float>(15,31,0),SIMD3<Float>(14,31,0),SIMD3<Float>(15,31,0),SIMD3<Float>(14,32,0),SIMD3<Float>(15,32,0),SIMD3<Float>(14,32,0),SIMD3<Float>(15,32,0),SIMD3<Float>(14,33,0),SIMD3<Float>(15,33,0),SIMD3<Float>(14,33,0),SIMD3<Float>(15,33,0),SIMD3<Float>(14,34,0),SIMD3<Float>(15,34,0),SIMD3<Float>(14,34,0),SIMD3<Float>(15,34,0),SIMD3<Float>(14,35,0),SIMD3<Float>(15,35,0),SIMD3<Float>(14,35,0),SIMD3<Float>(15,35,0),SIMD3<Float>(14,36,0),SIMD3<Float>(15,36,0),SIMD3<Float>(14,36,0),SIMD3<Float>(15,36,0),SIMD3<Float>(14,37,0),SIMD3<Float>(15,37,0),SIMD3<Float>(15,27,0),SIMD3<Float>(16,27,0),SIMD3<Float>(15,28,0),SIMD3<Float>(16,28,0),SIMD3<Float>(15,28,0),SIMD3<Float>(16,28,0),SIMD3<Float>(15,29,0),SIMD3<Float>(16,29,0),SIMD3<Float>(15,29,0),SIMD3<Float>(16,29,0),SIMD3<Float>(15,30,0),SIMD3<Float>(16,30,0),SIMD3<Float>(15,30,0),SIMD3<Float>(16,30,0),SIMD3<Float>(15,31,0),SIMD3<Float>(16,31,0),SIMD3<Float>(15,31,0),SIMD3<Float>(16,31,0),SIMD3<Float>(15,32,0),SIMD3<Float>(16,32,0),SIMD3<Float>(15,32,0),SIMD3<Float>(16,32,0),SIMD3<Float>(15,33,0),SIMD3<Float>(16,33,0),SIMD3<Float>(15,33,0),SIMD3<Float>(16,33,0),SIMD3<Float>(15,34,0),SIMD3<Float>(16,34,0),SIMD3<Float>(16,27,0),SIMD3<Float>(17,27,0),SIMD3<Float>(16,28,0),SIMD3<Float>(17,28,0),SIMD3<Float>(16,28,0),SIMD3<Float>(17,28,0),SIMD3<Float>(16,29,0),SIMD3<Float>(17,29,0),SIMD3<Float>(16,29,0),SIMD3<Float>(17,29,0),SIMD3<Float>(16,30,0),SIMD3<Float>(17,30,0),SIMD3<Float>(16,30,0),SIMD3<Float>(17,30,0),SIMD3<Float>(16,31,0),SIMD3<Float>(17,31,0),SIMD3<Float>(16,31,0),SIMD3<Float>(17,31,0),SIMD3<Float>(16,32,0),SIMD3<Float>(17,32,0),SIMD3<Float>(17,27,0),SIMD3<Float>(18,27,0),SIMD3<Float>(17,28,0),SIMD3<Float>(18,28,0),SIMD3<Float>(17,28,0),SIMD3<Float>(18,28,0),SIMD3<Float>(17,29,0),SIMD3<Float>(18,29,0),SIMD3<Float>(17,29,0),SIMD3<Float>(18,29,0),SIMD3<Float>(17,30,0),SIMD3<Float>(18,30,0),
		]
		for position in positions {
			self.vertices.append(Vertex(position: position, color: SIMD4<Float>(0,0,0,1)))
		}
		indices = [
			0,1,2,3,1,2,4,5,6,7,5,6,8,9,10,11,9,10,12,13,14,15,13,14,16,17,18,19,17,18,20,21,22,23,21,22,24,25,26,27,25,26,28,29,30,31,29,30,32,33,34,35,33,34,36,37,38,39,37,38,40,41,42,43,41,42,44,45,46,47,45,46,48,49,50,51,49,50,52,53,54,55,53,54,56,57,58,59,57,58,60,61,62,63,61,62,64,65,66,67,65,66,68,69,70,71,69,70,72,73,74,75,73,74,76,77,78,79,77,78,80,81,82,83,81,82,84,85,86,87,85,86,88,89,90,91,89,90,92,93,94,95,93,94,96,97,98,99,97,98,100,101,102,103,101,102,104,105,106,107,105,106,108,109,110,111,109,110,112,113,114,115,113,114,116,117,118,119,117,118,120,121,122,123,121,122,124,125,126,127,125,126,128,129,130,131,129,130,132,133,134,135,133,134,136,137,138,139,137,138,140,141,142,143,141,142,144,145,146,147,145,146,148,149,150,151,149,150,152,153,154,155,153,154,156,157,158,159,157,158,160,161,162,163,161,162,164,165,166,167,165,166,168,169,170,171,169,170,172,173,174,175,173,174,176,177,178,179,177,178,180,181,182,183,181,182,184,185,186,187,185,186,188,189,190,191,189,190,192,193,194,195,193,194,196,197,198,199,197,198,200,201,202,203,201,202,204,205,206,207,205,206,208,209,210,211,209,210,212,213,214,215,213,214,216,217,218,219,217,218,220,221,222,223,221,222,224,225,226,227,225,226,228,229,230,231,229,230,232,233,234,235,233,234,236,237,238,239,237,238,240,241,242,243,241,242,244,245,246,247,245,246,248,249,250,251,249,250,252,253,254,255,253,254,256,257,258,259,257,258,260,261,262,263,261,262,264,265,266,267,265,266,268,269,270,271,269,270,272,273,274,275,273,274,276,277,278,279,277,278,280,281,282,283,281,282,284,285,286,287,285,286,288,289,290,291,289,290,292,293,294,295,293,294,296,297,298,299,297,298,300,301,302,303,301,302,304,305,306,307,305,306,308,309,310,311,309,310,312,313,314,315,313,314,316,317,318,319,317,318,320,321,322,323,321,322,324,325,326,327,325,326,328,329,330,331,329,330,332,333,334,335,333,334,336,337,338,339,337,338,340,341,342,343,341,342,344,345,346,347,345,346,348,349,350,351,349,350,352,353,354,355,353,354,356,357,358,359,357,358,360,361,362,363,361,362,364,365,366,367,365,366,368,369,370,371,369,370,372,373,374,375,373,374,376,377,378,379,377,378,380,381,382,383,381,382,384,385,386,387,385,386,388,389,390,391,389,390,392,393,394,395,393,394,396,397,398,399,397,398,400,401,402,403,401,402,404,405,406,407,405,406,408,409,410,411,409,410,412,413,414,415,413,414,416,417,418,419,417,418,420,421,422,423,421,422,424,425,426,427,425,426,428,429,430,431,429,430,432,433,434,435,433,434,436,437,438,439,437,438,
		]
	}
}