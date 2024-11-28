//
//  NewsUiModel.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/25.
//

public struct HomeNewsUiModel: Hashable {
    public let id: Int
    public let title: String
    public let description: String
    public let posted: String
    public let modified: String
    public let url: String
    public let fileList: [HomeNewsFileModel]
    public let linkList: [HomeNewsLinkModel]
}

public struct HomeNewsFileModel: Hashable {
    public let src: String
    public let subject: String
    public let ext: String
}

public struct HomeNewsLinkModel: Hashable {
    public let src: String
    public let subject: String
}
