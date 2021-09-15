//
//  MatchDetails.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 15/09/2021.
//

import Foundation

struct MatchDetails: Codable {
    var id: Int?
    var utcDate: String?
    var status: String?
    var stage: String?
    var lastUpdated: String?
}
