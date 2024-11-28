//
//  AttractionsModel.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/21.
//

public struct AttractionsResponseModel: Decodable {
    public let total: Int
    public let data: [AttractionsResponseDataModel]
}

public struct AttractionsResponseDataModel: Decodable {
    public let id: Int
    public let name: String
    public let nameZh: String?
    public let openStatus: Int?
    public let introduction: String
    public let openTime: String?
    public let zipcode: String
    public let distric: String
    public let address: String
    public let tel: String
    public let fax: String
    public let email: String
    public let months: String
    public let nlat: Double
    public let elong: Double
    public let officialSite: String?
    public let facebook: String
    public let ticket: String
    public let remind: String
    public let staytime: String
    public let modified: String
    public let url: String
    public let category: [AttractionsResponseDataCategoryModel]
    public let target: [AttractionsResponseDataTargetModel]
    public let service: [AttractionsResponseDataServiceModel]
    public let friendly: [AttractionsResponseDataFriendlyModel]
    public let images: [AttractionsResponseDataImageModel]
    public let files: [AttractionsResponseDataFileModel]
    public let links: [AttractionsResponseDataLinkModel]
    
    public func toUiModel() -> HomeAttractionsUiModel {
        HomeAttractionsUiModel(
            id: id,
            name: name,
            introduction: introduction,
            openTime: openTime ?? "",
            address: address,
            tel: tel,
            url: url,
            imageList: images.map { $0.toUiModel() }
        )
    }
}

public struct AttractionsResponseDataCategoryModel: Decodable {
    public let id: Int
    public let name: String
}

public struct AttractionsResponseDataTargetModel: Decodable {
    public let id: Int
    public let name: String
}

public struct AttractionsResponseDataServiceModel: Decodable {
    public let id: Int
    public let name: String
}

public struct AttractionsResponseDataFriendlyModel: Decodable {
    public let id: Int
    public let name: String
}

public struct AttractionsResponseDataImageModel: Decodable {
    public let src: String
    public let subject: String
    public let ext: String
    
    public func toUiModel() -> HomeAttractionsImageModel {
        HomeAttractionsImageModel(src: src, subject: subject, ext: ext)
    }
}

public struct AttractionsResponseDataFileModel: Decodable {
    public let src: String
    public let subject: String
    public let ext: String
}

public struct AttractionsResponseDataLinkModel: Decodable {
    public let src: String
    public let subject: String
}
