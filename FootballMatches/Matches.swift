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

// MARK: - Area
struct Area: Codable {
    var id: Int?
    var name: String?
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
    var matchday: Int?
    var stage: Stage
    var group: String?
    var lastUpdated: String?
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
    var name: String
    var role: Role
    var nationality: Nationality?
}

enum Nationality: String, Codable {
    case belarus = "Belarus"
    case belgium = "Belgium"
    case bulgaria = "Bulgaria"
    case czechRepublic = "Czech Republic"
    case england = "England"
    case france = "France"
    case germany = "Germany"
    case greece = "Greece"
    case israel = "Israel"
    case italy = "Italy"
    case latvia = "Latvia"
    case lithuania = "Lithuania"
    case netherlands = "Netherlands"
    case poland = "Poland"
    case portugal = "Portugal"
    case romania = "Romania"
    case russia = "Russia"
    case scotland = "Scotland"
    case serbia = "Serbia"
    case slovakia = "Slovakia"
    case slovenia = "Slovenia"
    case spain = "Spain"
    case sweden = "Sweden"
    case switzerland = "Switzerland"
    case turkey = "Turkey"
    case australia = "Australia"
}

enum Role: String, Codable {
    case additionalAssistantN1 = "ADDITIONAL_ASSISTANT_N1"
    case additionalAssistantN2 = "ADDITIONAL_ASSISTANT_N2"
    case assistantN1 = "ASSISTANT_N1"
    case assistantN2 = "ASSISTANT_N2"
    case assistantRefereeN1 = "ASSISTANT_REFEREE_N1"
    case assistantRefereeN2 = "ASSISTANT_REFEREE_N2"
    case fourthOfficial = "FOURTH_OFFICIAL"
    case mainReferee = "MAIN_REFEREE"
    case ref = "REF"
    case referee = "REFEREE"
    case videoAssisantRefereeN1 = "VIDEO_ASSISANT_REFEREE_N1"
    case videoAssisantRefereeN2 = "VIDEO_ASSISANT_REFEREE_N2"
    case videoAssistantReferee = "VIDEO_ASSISTANT_REFEREE"
    case videoAssistantReferee2 = "VIDEO_ASSISTANT_REFEREE_2"
    case videoAssistantReferee3 = "VIDEO_ASSISTANT_REFEREE_3"
}

// MARK: - Score
struct Score: Codable {
    var winner: Winner?
    var duration: Duration
    var fullTime, halfTime, extraTime, penalties: ExtraTime
}

enum Duration: String, Codable {
    case extraTime = "EXTRA_TIME"
    case penaltyShootout = "PENALTY_SHOOTOUT"
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
    case groupStage = "GROUP_STAGE"
    case playOffRound = "PLAY_OFF_ROUND"
    case preliminaryFinal = "PRELIMINARY_FINAL"
    case preliminaryRound = "PRELIMINARY_ROUND"
    case qualificationRound1 = "QUALIFICATION_ROUND_1"
    case qualificationRound2 = "QUALIFICATION_ROUND_2"
    case qualificationRound3 = "QUALIFICATION_ROUND_3"
    case quarterFinals = "QUARTER_FINALS"
    case roundOf16 = "ROUND_OF_16"
    case semiFinals = "SEMI_FINALS"
    case stageFINAL = "FINAL"
    case the1StQualifyingRound = "1ST_QUALIFYING_ROUND"
    case the2NdQualifyingRound = "2ND_QUALIFYING_ROUND"
    case the3RDQualifyingRound = "3RD_QUALIFYING_ROUND"
}

enum Status: String, Codable {
    case awarded = "AWARDED"
    case finished = "FINISHED"
    case scheduled = "SCHEDULED"
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
     "count": 28,
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
         },
         {
             "id": 337490,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-14T16:45:00Z",
             "status": "FINISHED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_F",
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
                 "id": 1871,
                 "name": "BSC Young Boys"
             },
             "awayTeam": {
                 "id": 66,
                 "name": "Manchester United FC"
             },
             "referees": [
                 {
                     "id": 43918,
                     "name": "François Letexier",
                     "role": "REFEREE",
                     "nationality": "France"
                 },
                 {
                     "id": 57080,
                     "name": "Cyril Mugnier",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "France"
                 },
                 {
                     "id": 57049,
                     "name": "Mehdi Rahmouni",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "France"
                 },
                 {
                     "id": 57039,
                     "name": "Thomas Léonard",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "France"
                 },
                 {
                     "id": 57042,
                     "name": "Willy Delajod",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "France"
                 },
                 {
                     "id": 11054,
                     "name": "Massimiliano Irrati",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Italy"
                 }
             ]
         },
         {
             "id": 337502,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-14T16:45:00Z",
             "status": "FINISHED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_G",
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "DRAW",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 1,
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
                 "id": 559,
                 "name": "Sevilla FC"
             },
             "awayTeam": {
                 "id": 1877,
                 "name": "FC Red Bull Salzburg"
             },
             "referees": [
                 {
                     "id": 169590,
                     "name": "Alexey Kulbakov",
                     "role": "REFEREE",
                     "nationality": null
                 },
                 {
                     "id": 43930,
                     "name": "Dmitry Zhuk",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Belarus"
                 },
                 {
                     "id": 43931,
                     "name": "Oleg Maslyanko",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Belarus"
                 },
                 {
                     "id": 43933,
                     "name": "Denis Scherbakov",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": null
                 },
                 {
                     "id": 15746,
                     "name": "Bastian Dankert",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Germany"
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
             "id": 337477,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-14T19:00:00Z",
             "status": "FINISHED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_E",
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
                 "id": 842,
                 "name": "FK Dynamo Kyiv"
             },
             "awayTeam": {
                 "id": 1903,
                 "name": "Sport Lisboa e Benfica"
             },
             "referees": [
                 {
                     "id": 11580,
                     "name": "Anthony Taylor",
                     "role": "REFEREE",
                     "nationality": "England"
                 },
                 {
                     "id": 11581,
                     "name": "Gary Beswick",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "England"
                 },
                 {
                     "id": 11615,
                     "name": "Adam Nunn",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "England"
                 },
                 {
                     "id": 11585,
                     "name": "Craig Pawson",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "England"
                 },
                 {
                     "id": 11443,
                     "name": "Chris Kavanagh",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "England"
                 },
                 {
                     "id": 23568,
                     "name": "Jarred Gillett",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Australia"
                 }
             ]
         },
         {
             "id": 337478,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-14T19:00:00Z",
             "status": "FINISHED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_E",
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "AWAY_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 0,
                     "awayTeam": 3
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
                 "id": 81,
                 "name": "FC Barcelona"
             },
             "awayTeam": {
                 "id": 5,
                 "name": "FC Bayern München"
             },
             "referees": [
                 {
                     "id": 11605,
                     "name": "Michael Oliver",
                     "role": "REFEREE",
                     "nationality": "England"
                 },
                 {
                     "id": 11564,
                     "name": "Stuart Burt",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "England"
                 },
                 {
                     "id": 11488,
                     "name": "Simon Bennett",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "England"
                 },
                 {
                     "id": 11469,
                     "name": "Darren England",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "England"
                 },
                 {
                     "id": 11494,
                     "name": "Stuart Attwell",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "England"
                 },
                 {
                     "id": 11520,
                     "name": "Paul Tierney",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "England"
                 }
             ]
         },
         {
             "id": 337489,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-14T19:00:00Z",
             "status": "FINISHED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_F",
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "DRAW",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 2,
                     "awayTeam": 2
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
                 "id": 94,
                 "name": "Villarreal CF"
             },
             "awayTeam": {
                 "id": 102,
                 "name": "Atalanta BC"
             },
             "referees": [
                 {
                     "id": 9374,
                     "name": "Clément Turpin",
                     "role": "REFEREE",
                     "nationality": "France"
                 },
                 {
                     "id": 43883,
                     "name": "Nicolas Danos",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "France"
                 },
                 {
                     "id": 43884,
                     "name": "Cyril Gringore",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "France"
                 },
                 {
                     "id": 57073,
                     "name": "Jérémie Pignard",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "France"
                 },
                 {
                     "id": 15548,
                     "name": "Jérôme Brisard",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "France"
                 },
                 {
                     "id": 25786,
                     "name": "Stéphanie Frappart",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "France"
                 }
             ]
         },
         {
             "id": 337501,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-14T19:00:00Z",
             "status": "FINISHED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_G",
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
                 "id": 521,
                 "name": "Lille OSC"
             },
             "awayTeam": {
                 "id": 11,
                 "name": "VfL Wolfsburg"
             },
             "referees": [
                 {
                     "id": 43899,
                     "name": "Danny Makkelie",
                     "role": "REFEREE",
                     "nationality": "Netherlands"
                 },
                 {
                     "id": 43900,
                     "name": "Hessel Steegstra",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Netherlands"
                 },
                 {
                     "id": 15154,
                     "name": "Jan de Vries",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Netherlands"
                 },
                 {
                     "id": 9561,
                     "name": "Allard Lindhout",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "Netherlands"
                 },
                 {
                     "id": 43902,
                     "name": "Kevin Blom",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Netherlands"
                 },
                 {
                     "id": 15152,
                     "name": "Pol van Boekel",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Netherlands"
                 }
             ]
         },
         {
             "id": 337513,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-14T19:00:00Z",
             "status": "FINISHED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_H",
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "AWAY_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 0,
                     "awayTeam": 3
                 },
                 "halfTime": {
                     "homeTeam": 0,
                     "awayTeam": 3
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
                 "id": 109,
                 "name": "Juventus FC"
             },
             "referees": [
                 {
                     "id": 82279,
                     "name": "Artur Dias",
                     "role": "REFEREE",
                     "nationality": null
                 },
                 {
                     "id": 37626,
                     "name": "Rui Tavares",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Portugal"
                 },
                 {
                     "id": 37714,
                     "name": "Paulo Soares",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Portugal"
                 },
                 {
                     "id": 37862,
                     "name": "Hugo Miguel",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "Portugal"
                 },
                 {
                     "id": 38806,
                     "name": "João Pinheiro",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Portugal"
                 },
                 {
                     "id": 37629,
                     "name": "Luís Godinho",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Portugal"
                 }
             ]
         },
         {
             "id": 337514,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-14T19:00:00Z",
             "status": "FINISHED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_H",
             "lastUpdated": "2021-09-15T08:20:08Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": "HOME_TEAM",
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": 1,
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
                 "id": 61,
                 "name": "Chelsea FC"
             },
             "awayTeam": {
                 "id": 731,
                 "name": "FK Zenit Sankt-Petersburg"
             },
             "referees": [
                 {
                     "id": 43857,
                     "name": "Bartosz Frankowski",
                     "role": "REFEREE",
                     "nationality": "Poland"
                 },
                 {
                     "id": 43832,
                     "name": "Marcin Boniek",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Poland"
                 },
                 {
                     "id": 76332,
                     "name": "Jakub Winkler",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Poland"
                 },
                 {
                     "id": 64258,
                     "name": "Krzysztof Jakubik",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "Poland"
                 },
                 {
                     "id": 15821,
                     "name": "Marco Fritz",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Germany"
                 },
                 {
                     "id": 11060,
                     "name": "Marco Di Bello",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Italy"
                 }
             ]
         },
         {
             "id": 337454,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-15T16:45:00Z",
             "status": "SCHEDULED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_C",
             "lastUpdated": "2021-09-15T14:45:11Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": null,
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "halfTime": {
                     "homeTeam": null,
                     "awayTeam": null
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
                 "id": 600,
                 "name": "Beşiktaş JK"
             },
             "awayTeam": {
                 "id": 4,
                 "name": "Borussia Dortmund"
             },
             "referees": [
                 {
                     "id": 134,
                     "name": "Pau Cebrián Devis",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Spain"
                 },
                 {
                     "id": 82,
                     "name": "Roberto Díaz Pérez",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Spain"
                 },
                 {
                     "id": 80747,
                     "name": "Javier Alberola Rojas",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": null
                 },
                 {
                     "id": 43869,
                     "name": "Antonio Matéu Lahoz",
                     "role": "REFEREE",
                     "nationality": "Spain"
                 },
                 {
                     "id": 81,
                     "name": "Juan Martínez",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Spain"
                 },
                 {
                     "id": 15628,
                     "name": "Ricardo de Burgos",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Spain"
                 }
             ]
         },
         {
             "id": 337466,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-15T16:45:00Z",
             "status": "SCHEDULED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_D",
             "lastUpdated": "2021-09-15T14:45:11Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": null,
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "halfTime": {
                     "homeTeam": null,
                     "awayTeam": null
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
                 "id": 1887,
                 "name": "FK Shakhtar Donetsk"
             },
             "referees": [
                 {
                     "id": 43930,
                     "name": "Dmitry Zhuk",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Belarus"
                 },
                 {
                     "id": 43931,
                     "name": "Oleg Maslyanko",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Belarus"
                 },
                 {
                     "id": 43933,
                     "name": "Denis Scherbakov",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": null
                 },
                 {
                     "id": 169590,
                     "name": "Alexey Kulbakov",
                     "role": "REFEREE",
                     "nationality": null
                 },
                 {
                     "id": 15746,
                     "name": "Bastian Dankert",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Germany"
                 },
                 {
                     "id": 72624,
                     "name": "Tomasz Kwiatkowski",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Poland"
                 },
                 {
                     "id": 8826,
                     "name": "Christian Dietz",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Germany"
                 },
                 {
                     "id": 43877,
                     "name": "Stefan Lupp",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Germany"
                 },
                 {
                     "id": 15825,
                     "name": "Martin Petersen",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "Germany"
                 },
                 {
                     "id": 8825,
                     "name": "Deniz Aytekin",
                     "role": "REFEREE",
                     "nationality": "Germany"
                 },
                 {
                     "id": 57526,
                     "name": "Christian Dingert",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Germany"
                 },
                 {
                     "id": 57511,
                     "name": "Markus Sinn",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Germany"
                 }
             ]
         },
         {
             "id": 337429,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-15T19:00:00Z",
             "status": "SCHEDULED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_A",
             "lastUpdated": "2021-08-30T12:06:18Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": null,
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "halfTime": {
                     "homeTeam": null,
                     "awayTeam": null
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
                 "id": 851,
                 "name": "Club Brugge KV"
             },
             "awayTeam": {
                 "id": 524,
                 "name": "Paris Saint-Germain FC"
             },
             "referees": [
                 {
                     "id": 14932,
                     "name": "Stéphane De Almeida",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Switzerland"
                 },
                 {
                     "id": 30769,
                     "name": "Bekim Zogaj",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Switzerland"
                 },
                 {
                     "id": 14931,
                     "name": "Fedayi San",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "Switzerland"
                 },
                 {
                     "id": 31823,
                     "name": "Sandro Schärer",
                     "role": "REFEREE",
                     "nationality": "Switzerland"
                 },
                 {
                     "id": 11054,
                     "name": "Massimiliano Irrati",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Italy"
                 },
                 {
                     "id": 11494,
                     "name": "Stuart Attwell",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "England"
                 }
             ]
         },
         {
             "id": 337430,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-15T19:00:00Z",
             "status": "SCHEDULED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_A",
             "lastUpdated": "2021-08-30T12:06:18Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": null,
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "halfTime": {
                     "homeTeam": null,
                     "awayTeam": null
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
                 "id": 65,
                 "name": "Manchester City FC"
             },
             "awayTeam": {
                 "id": 721,
                 "name": "RB Leipzig"
             },
             "referees": [
                 {
                     "id": 43860,
                     "name": "Joost van Zuilen",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Netherlands"
                 },
                 {
                     "id": 14764,
                     "name": "Johan Balder",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Netherlands"
                 },
                 {
                     "id": 56912,
                     "name": "Jeroen Manschot",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "Netherlands"
                 },
                 {
                     "id": 43858,
                     "name": "Serdar Gözübüyük",
                     "role": "REFEREE",
                     "nationality": "Netherlands"
                 },
                 {
                     "id": 15152,
                     "name": "Pol van Boekel",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Netherlands"
                 },
                 {
                     "id": 25786,
                     "name": "Stéphanie Frappart",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "France"
                 }
             ]
         },
         {
             "id": 337441,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-15T19:00:00Z",
             "status": "SCHEDULED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_B",
             "lastUpdated": "2021-08-30T12:06:19Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": null,
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "halfTime": {
                     "homeTeam": null,
                     "awayTeam": null
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
                 "id": 64,
                 "name": "Liverpool FC"
             },
             "awayTeam": {
                 "id": 98,
                 "name": "AC Milan"
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
                     "id": 72624,
                     "name": "Tomasz Kwiatkowski",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Poland"
                 },
                 {
                     "id": 15746,
                     "name": "Bastian Dankert",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Germany"
                 }
             ]
         },
         {
             "id": 337442,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-15T19:00:00Z",
             "status": "SCHEDULED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_B",
             "lastUpdated": "2021-08-30T12:06:19Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": null,
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "halfTime": {
                     "homeTeam": null,
                     "awayTeam": null
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
                 "id": 78,
                 "name": "Club Atlético de Madrid"
             },
             "awayTeam": {
                 "id": 503,
                 "name": "FC Porto"
             },
             "referees": [
                 {
                     "id": 111975,
                     "name": "Radu Ghinguleac",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Romania"
                 },
                 {
                     "id": 36837,
                     "name": "Sebastian Gheorghe",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Romania"
                 },
                 {
                     "id": 15581,
                     "name": "Radu Petrescu",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "Romania"
                 },
                 {
                     "id": 36314,
                     "name": "Ovidiu Hațegan",
                     "role": "REFEREE",
                     "nationality": "Romania"
                 },
                 {
                     "id": 11060,
                     "name": "Marco Di Bello",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Italy"
                 },
                 {
                     "id": 15548,
                     "name": "Jérôme Brisard",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "France"
                 }
             ]
         },
         {
             "id": 337453,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-15T19:00:00Z",
             "status": "SCHEDULED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_C",
             "lastUpdated": "2021-08-30T12:06:21Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": null,
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "halfTime": {
                     "homeTeam": null,
                     "awayTeam": null
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
                 "id": 498,
                 "name": "Sporting Clube de Portugal"
             },
             "awayTeam": {
                 "id": 678,
                 "name": "AFC Ajax"
             },
             "referees": [
                 {
                     "id": 32243,
                     "name": "Raúl Cabañero",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Spain"
                 },
                 {
                     "id": 3158,
                     "name": "Iñigo Prieto",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Spain"
                 },
                 {
                     "id": 32457,
                     "name": "César Soto",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "Spain"
                 },
                 {
                     "id": 106,
                     "name": "José Sánchez",
                     "role": "REFEREE",
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
             "id": 337465,
             "season": {
                 "id": 734,
                 "startDate": "2021-06-26",
                 "endDate": "2022-05-22",
                 "currentMatchday": 1
             },
             "utcDate": "2021-09-15T19:00:00Z",
             "status": "SCHEDULED",
             "matchday": 1,
             "stage": "GROUP_STAGE",
             "group": "GROUP_D",
             "lastUpdated": "2021-08-30T12:06:22Z",
             "odds": {
                 "msg": "Activate Odds-Package in User-Panel to retrieve odds."
             },
             "score": {
                 "winner": null,
                 "duration": "REGULAR",
                 "fullTime": {
                     "homeTeam": null,
                     "awayTeam": null
                 },
                 "halfTime": {
                     "homeTeam": null,
                     "awayTeam": null
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
                 "id": 108,
                 "name": "FC Internazionale Milano"
             },
             "awayTeam": {
                 "id": 86,
                 "name": "Real Madrid CF"
             },
             "referees": [
                 {
                     "id": 43880,
                     "name": "Rafael Foltyn",
                     "role": "ASSISTANT_REFEREE_N1",
                     "nationality": "Germany"
                 },
                 {
                     "id": 15747,
                     "name": "Christian Gittelmann",
                     "role": "ASSISTANT_REFEREE_N2",
                     "nationality": "Germany"
                 },
                 {
                     "id": 57517,
                     "name": "Daniel Schlager",
                     "role": "FOURTH_OFFICIAL",
                     "nationality": "Germany"
                 },
                 {
                     "id": 15408,
                     "name": "Daniel Siebert",
                     "role": "REFEREE",
                     "nationality": "Germany"
                 },
                 {
                     "id": 15821,
                     "name": "Marco Fritz",
                     "role": "VIDEO_ASSISANT_REFEREE_N1",
                     "nationality": "Germany"
                 },
                 {
                     "id": 253,
                     "name": "Harm Osmers",
                     "role": "VIDEO_ASSISANT_REFEREE_N2",
                     "nationality": "Germany"
                 }
             ]
         }
     ]
 }
 */
