//
//  Matches.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 14/09/2021.
//

import Foundation

// MARK: - Matches
struct Matches: Codable {
    var count: Int?
    var filters: Filters?
    var competition: Competition?
    var matches: [Match]?
}

// MARK: - Competition
struct Competition: Codable {
    var id: Int?
    var area: Area
    var name, code, plan: String
    var lastUpdated: String
}

// MARK: - Filters
struct Filters: Codable {
}

// MARK: - Match
struct Match: Codable {
    var id: Int
    var season: Season
    var utcDate: String
    var status: Status
    var matchday: JSONNull?
    var stage: Stage
    var group: JSONNull?
    var lastUpdated: String
    var odds: Odds
    var score: Score
    var homeTeam, awayTeam: Area
    var referees: [Referee]
}

// MARK: - Odds
struct Odds: Codable {
    var msg: Msg
}

enum Msg: String, Codable {
    case activateOddsPackageInUserPanelToRetrieveOdds = "Activate Odds-Package in User-Panel to retrieve odds."
}

// MARK: - Referee
struct Referee: Codable {
    var id: Int
    var name, role: String
    var nationality: Nationality?
}

enum Nationality: String, Codable {
    case poland = "Poland"
    case spain = "Spain"
}

// MARK: - Score
struct Score: Codable {
    var winner: Winner
    var duration: Duration
    var fullTime, halfTime, extraTime, penalties: ExtraTime
}

enum Duration: String, Codable {
    case extraTime = "EXTRA_TIME"
    case regular = "REGULAR"
}

// MARK: - ExtraTime
struct ExtraTime: Codable {
    var homeTeam, awayTeam: Int?
}

enum Winner: String, Codable {
    case awayTeam = "AWAY_TEAM"
    case draw = "DRAW"
    case homeTeam = "HOME_TEAM"
}

// MARK: - Season
struct Season: Codable {
    var id: Int
    var startDate, endDate: String
    var currentMatchday: Int
}

enum Stage: String, Codable {
    case playOffRound = "PLAY_OFF_ROUND"
}

enum Status: String, Codable {
    case finished = "FINISHED"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

/*
 {
     "count": 12,
     "filters": {},
     "competition": {
         "id": 2001,
         "area": {
             "id": 2077,
             "name": "Europe"
         },
         "name": "UEFA Champions League",
         "code": "CL",
         "plan": "TIER_ONE",
         "lastUpdated": "2021-06-26T13:37:26Z"
     },
     "matches": [
         {
             "id": 336878,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-17T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "AWAY_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 0,
                     "awayTeam": 1
                 },
                 "halfTime": {
                     "homeTeam": 0,
                     "awayTeam": 1
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 548,
                 "name": "AS Monaco FC"
             },
             "awayTeam": {
                 "id": 1887,
                 "name": "FK Shakhtar Donetsk"
             },
             "referees": []
         },
         {
             "id": 336879,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-17T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "HOME_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 3,
                     "awayTeam": 0
                 },
                 "halfTime": {
                     "homeTeam": 1,
                     "awayTeam": 0
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 1880,
                 "name": "FC Sheriff Tiraspol"
             },
             "awayTeam": {
                 "id": 755,
                 "name": "GNK Dinamo Zagreb"
             },
             "referees": []
         },
         {
             "id": 336882,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-17T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "HOME_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 2,
                     "awayTeam": 1
                 },
                 "halfTime": {
                     "homeTeam": 0,
                     "awayTeam": 1
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 1877,
                 "name": "FC Red Bull Salzburg"
             },
             "awayTeam": {
                 "id": 4483,
                 "name": "Brøndby IF"
             },
             "referees": [
                 {
                     "id": 172059,
                     "name": "Pawel Sokolnicki",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": null
                 },
                 {
                     "id": 43890,
                     "name": "Tomasz Listkiewicz",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Poland"
                 },
                 {
                     "id": 172049,
                     "name": "Tomasz Musial",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": null
                 },
                 {
                     "id": 43888,
                     "name": "Szymon Marciniak",
                     "role": "REFEREE",
                     "nationality": "Poland"
                 },
                 {
                     "id": 131857,
                     "name": "Pawel Gil",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Poland"
                 },
                 {
                     "id": 72624,
                     "name": "Tomasz Kwiatkowski",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Poland"
                 }
             ]
         },
         {
             "id": 336877,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-18T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "HOME_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 2,
                     "awayTeam": 1
                 },
                 "halfTime": {
                     "homeTeam": 2,
                     "awayTeam": 0
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 1903,
                 "name": "Sport Lisboa e Benfica"
             },
             "awayTeam": {
                 "id": 674,
                 "name": "PSV"
             },
             "referees": []
         },
         {
             "id": 336880,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-18T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "HOME_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 2,
                     "awayTeam": 0
                 },
                 "halfTime": {
                     "homeTeam": 1,
                     "awayTeam": 0
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 749,
                 "name": "Malmö FF"
             },
             "awayTeam": {
                 "id": 1901,
                 "name": "PFK Ludogorets 1945 Razgrad"
             },
             "referees": []
         },
         {
             "id": 336881,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-18T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "HOME_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 3,
                     "awayTeam": 2
                 },
                 "halfTime": {
                     "homeTeam": 2,
                     "awayTeam": 1
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 1871,
                 "name": "BSC Young Boys"
             },
             "awayTeam": {
                 "id": 5954,
                 "name": "Ferencvárosi TC"
             },
             "referees": []
         },
         {
             "id": 336872,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-24T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "DRAW",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 0,
                     "awayTeam": 0
                 },
                 "halfTime": {
                     "homeTeam": 0,
                     "awayTeam": 0
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 674,
                 "name": "PSV"
             },
             "awayTeam": {
                 "id": 1903,
                 "name": "Sport Lisboa e Benfica"
             },
             "referees": []
         },
         {
             "id": 336875,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-24T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "HOME_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 2,
                     "awayTeam": 1
                 },
                 "halfTime": {
                     "homeTeam": 1,
                     "awayTeam": 1
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 1901,
                 "name": "PFK Ludogorets 1945 Razgrad"
             },
             "awayTeam": {
                 "id": 749,
                 "name": "Malmö FF"
             },
             "referees": []
         },
         {
             "id": 336876,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-24T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "AWAY_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 2,
                     "awayTeam": 3
                 },
                 "halfTime": {
                     "homeTeam": 2,
                     "awayTeam": 1
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 5954,
                 "name": "Ferencvárosi TC"
             },
             "awayTeam": {
                 "id": 1871,
                 "name": "BSC Young Boys"
             },
             "referees": []
         },
         {
             "id": 336871,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-25T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "AWAY_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 1,
                     "awayTeam": 2
                 },
                 "halfTime": {
                     "homeTeam": 0,
                     "awayTeam": 2
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 4483,
                 "name": "Brøndby IF"
             },
             "awayTeam": {
                 "id": 1877,
                 "name": "FC Red Bull Salzburg"
             },
             "referees": [
                 {
                     "id": 43843,
                     "name": "Carlos del Cerro",
                     "role": "REFEREE",
                     "nationality": "Spain"
                 },
                 {
                     "id": 43844,
                     "name": "Juan Carlos Yuste",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Spain"
                 },
                 {
                     "id": 43872,
                     "name": "Roberto Alonso",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Spain"
                 },
                 {
                     "id": 81,
                     "name": "Juan Martínez",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "Spain"
                 },
                 {
                     "id": 15625,
                     "name": "Alejandro Hernández",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Spain"
                 },
                 {
                     "id": 55934,
                     "name": "Guillermo Cuadra",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Spain"
                 }
             ]
         },
         {
             "id": 336873,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-25T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "HOME_TEAM",
                 "duration": "EXTRA_TIME",
                 "fullTime": {
                     "homeTeam": 2,
                     "awayTeam": 2
                 },
                 "halfTime": {
                     "homeTeam": 0,
                     "awayTeam": 2
                 },
                 "extraTime": {
                     "homeTeam": 1,
                     "awayTeam": 0
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 1887,
                 "name": "FK Shakhtar Donetsk"
             },
             "awayTeam": {
                 "id": 548,
                 "name": "AS Monaco FC"
             },
             "referees": []
         },
         {
             "id": 336874,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-08-25T19:00:00Z",
             "status": "FINISHED",
             "matchday": null,
             "stage": "PLAY_OFF_ROUND",
             "group": null,
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "DRAW",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 0,
                     "awayTeam": 0
                 },
                 "halfTime": {
                     "homeTeam": 0,
                     "awayTeam": 0
                 },
                 "extraTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "penalties": {
                     "homeTeam": null,
                     "awayTeam": null
                 }
             },
             "homeTeam": {
                 "id": 755,
                 "name": "GNK Dinamo Zagreb"
             },
             "awayTeam": {
                 "id": 1880,
                 "name": "FC Sheriff Tiraspol"
             },
             "referees": []
         }
     ]
 }
 */
