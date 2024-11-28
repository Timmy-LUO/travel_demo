//
//  LoginModel.swift
//  DailyBellePOS
//
//  Created by Harry on 2023/1/22.
//

import Foundation

public struct HttpApiConfig {
    public static var domain: String { "https://www.travel.taipei/open-api/" }
    public static let baseURL = URL(string: "\(domain)")!
}
