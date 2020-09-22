//
//  BaseAPI.swift
//  Covid19
//
//  Created by Rezo Joglidze on 9/9/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation
import Network
import Alamofire

class BaseAPI {
    
    static let shared = BaseAPI()
    
    private func request<Parameters: Encodable>(_ convertible: URLConvertible,
                                                method: HTTPMethod = .get,
                                                parameters: Parameters? = nil,
                                                encoder: ParameterEncoder = JSONParameterEncoder(),
                                                headers: HTTPHeaders? = nil,
                                                needsAuthorization: Bool = false
    ) -> DataRequest {
        let headers: HTTPHeaders = [.init(name: "lang", value: "ka") ]
        return AF.request(convertible, method: method, parameters: parameters, encoder: encoder, headers: headers)
    }
    
    private func request(_ convertible: URLConvertible,
                         method: HTTPMethod = .get,
                         headers: HTTPHeaders? = nil,
                         needsAuthorization: Bool = false
    ) -> DataRequest {
        let headers: HTTPHeaders = [.init(name: "lang", value: "ka") ]
        return AF.request(convertible, method: method, headers: headers)
    }
    
    
    func getMatchDetails(matchId: Int, completionHandler: @escaping (Result<MatchDetails,BasicResponseError>) -> Void) {
        let urlStr = Constants.Api.baseUrl + Constants.Api.Routes.api + Constants.Api.Routes.matches + "/\(matchId)"
        request(urlStr).responseJSON { response in
            let responseHandler = BasicResponseHandler<MatchDetails>()
            completionHandler(responseHandler.getResult(from: response))
        }
    }
    
    func getTeamDetails(teamId: Int, completionHandler: @escaping (Result<TeamDetails,BasicResponseError>) -> Void) {
        let urlStr = Constants.Api.baseUrl + Constants.Api.Routes.api + Constants.Api.Routes.teams + "/\(teamId)"
        request(urlStr).responseJSON { response in
            let responseHandler = BasicResponseHandler<TeamDetails>()
            completionHandler(responseHandler.getResult(from: response))
        }
    }
}
