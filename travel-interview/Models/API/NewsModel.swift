//
//  NewsModel.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/21.
//

public struct NewsResponseModel: Decodable {
    public let total: Int
    public let data: [NewsResponseDataModel]
}

public struct NewsResponseDataModel: Decodable {
    public let id: Int
    public let title: String
    public let description: String
    public let begin: String?
    public let end: String?
    public let posted: String
    public let modified: String
    public let url: String
    public let files: [NewsResponseDataFileModel]
    public let links: [NewsResponseDataLinkModel]
    
    public func toUiModel() -> HomeNewsUiModel {
        HomeNewsUiModel(
            id: id,
            title: title,
            description: description,
            posted: posted,
            modified: modified,
            url: url,
            fileList: files.map { $0.toUiModel() },
            linkList: links.map { $0.toUiModel() }
        )
    }
}

public struct NewsResponseDataFileModel: Decodable {
    public let src: String
    public let subject: String
    public let ext: String
    
    public func toUiModel() -> HomeNewsFileModel {
        HomeNewsFileModel(src: src, subject: subject, ext: ext)
    }
}

public struct NewsResponseDataLinkModel: Decodable {
    public let src: String
    public let subject: String
    
    public func toUiModel() -> HomeNewsLinkModel {
        HomeNewsLinkModel(src: src, subject: subject)
    }
}
