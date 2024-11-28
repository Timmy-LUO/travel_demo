//
//  NewsService.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/21.
//

import Alamofire

public struct NewsService {
    
    public struct getNews: HttpTargetType {
        public var path: String { "\(language)/Events/News" }
        public var method: Alamofire.HTTPMethod { .get }
        public var parameters: Parameters { ["page": page] }
        
        public typealias SuccessType = NewsResponseModel
        public typealias FailureType = ResponseFailure
        
        public let language: String
        public let page: String
    }
}
