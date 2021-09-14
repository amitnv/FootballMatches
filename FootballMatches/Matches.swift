//
//  Matches.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 14/09/2021.
//

import Foundation

struct Matches: Codable {
    var areas : [Area]?
}




//struct Matches: Decodable {
//    var countOfAreas: Int?
//    var areas: [String]?
//
//    enum CodingKeys: String, CodingKey{
//        case countOfAreas = "count"
//        case areas = "areas"
//
//    }
//}
