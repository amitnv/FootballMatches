//
//  Service.swift
//  FootballMatches
//
//  Created by Amit Vaidya on 14/09/2021.
//

import Foundation
import Alamofire

class Service {
    
    //MARK:- Variables
    fileprivate var baseUrl = ""
    typealias matchesCallBack = (_ matches:Matches?, _ status: Bool, _ message: String) -> Void
    var callBack: matchesCallBack?
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    //MARK: - getAllMatches
    func getAllMatches(todaysDate: String) {
        let headers: HTTPHeaders = [
            "X-Auth-Token": AppConstants.apiKey,
            "Content-Type": AppConstants.contentTypeJson
        ]
        AF.request(self.baseUrl + todaysDate, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).response { (responseData) in
            //            print("We got response")
            switch(responseData.result) {
            case .success(_): guard let data = responseData.data else {
                self.callBack?(nil, false, "")
                return}
                do {
                    let matches = try JSONDecoder().decode(Matches.self, from: data)
                    print("Matches == \(matches)")
                    self.callBack?(matches, true, "")
                } catch {
                    print("Error decoding == \(error)")
                    self.callBack?(nil, false, error.localizedDescription)
                }
                break
            case .failure(let error):
                var errorDict = [String : Any]()
                let errorcode : Int = error._code
                if let httpStatusCode = responseData.response?.statusCode {
                    switch(httpStatusCode) {
                    case 404:
                        errorDict = ["errormsg" : "Invalid URL: \(self.baseUrl + todaysDate)", "errorCode" : httpStatusCode]
                    default: break
                        
                    }
                } else {
                    if (String(errorcode) == "-1009"){
                        errorDict = ["errormsg" : "Please check your internet connection"]
                    }
                    else if(error.localizedDescription != ""){
                        errorDict = ["errormsg" : error.localizedDescription]
                    }
                    else{
                        errorDict = ["errormsg" : "Server unreachable please try again later."]
                    }
                }
                print(errorDict)
                break
            }
        }
    }
    
    
    func completitonHandler(callBack: @escaping matchesCallBack) {
        self.callBack = callBack
    }

}
