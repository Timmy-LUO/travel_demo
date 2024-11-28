//
//  AttractionsService.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/21.
//

import Alamofire

public struct AttractionsService {
    
    public struct getAllAttractions: HttpTargetType {
        public var path: String { "\(language)/Attractions/All" }
        public var method: Alamofire.HTTPMethod { .get }
        public var parameters: Parameters { ["page": page] }
        
        public typealias SuccessType = AttractionsResponseModel
        public typealias FailureType = ResponseFailure
        
        public let language: String
        public let page: String
    }
}
