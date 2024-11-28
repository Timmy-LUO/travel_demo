//
//  AttractionsUiModel.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/25.
//

public struct HomeAttractionsUiModel: Hashable {
    public let id: Int
    public let name: String
    public let introduction: String
    public let openTime: String
    public let address: String
    public let tel: String
    public let url: String
    public let imageList: [HomeAttractionsImageModel]
}

public struct HomeAttractionsImageModel: Hashable {
    public let src: String
    public let subject: String
    public let ext: String
}
