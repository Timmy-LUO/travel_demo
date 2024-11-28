//
//  HomeViewModel.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/21.
//

import Combine

public final class HomeViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    // inputs
    public var onLanguage = PassthroughSubject<String, Never>()
    
    // outputs
    @Published public var languageList: [String] = [
        "繁體中文", "简体中文", "English", "日本語", "한국어", "Español", "Bahasa Indonesia", "ภาษาไทย", "Tiếng Việt"
    ]
    @Published public var newsList: [HomeNewsUiModel] = []
    @Published public var attractionsList: [HomeAttractionsUiModel] = []
    
//    var newsResponse: AnyPublisher<NewsResponseModel?, Never> { _newsResponse.eraseToAnyPublisher() }
//    var attractionsResponse: AnyPublisher<AttractionsResponseModel?, Never> { _attractionsResponse.eraseToAnyPublisher() }
    
    // internal
//    private var _newsResponse = CurrentValueSubject<NewsResponseModel?, Never>(nil)
//    private var _attractionsResponse = CurrentValueSubject<AttractionsResponseModel?, Never>(nil)
    
    public init() {
        
        onLanguage
            .sink { language in
                print("language: \(language)")
            }
            .store(in: &cancellables)
        
//        Publishers.CombineLatest(
//            _newsResponse,
//            _attractionsResponse
//        )
//        .sink { [weak self] news, attractions in
//            if let news = news, let attractions = attractions {
//                self?.combineHomeData(news: news, attractions: attractions)
//            }
//        }
//        .store(in: &cancellables)
            
        
//        newsResponse
//            .compactMap { $0 }
//            .sink { model in
//                print("newsModel: \(model)")
//            }
//            .store(in: &cancellables)
        
        getNews()
        getAttractions()
    }
    
//    private func combineHomeData(news: NewsResponseModel, attractions: AttractionsResponseModel) {
//        homeData = HomeUiModel(
//            newsTitle: "最新消息",
//            newsList: news.data.map { $0.toUiModel() },
//            attractionsTitle: "遊憩景點",
//            attractionsList: attractions.data.map { $0.toUiModel() }
//        )
//    }
    
    private func getNews() {
        NewsService.getNews(language: "zh-tw", page: "1")
            .request { [weak self] result in
                switch result {
                case .success(let response):
                    switch response {
                    case .success(let successBody):
//                        self?._newsResponse.send(successBody)
                        self?.newsList = successBody.data.map { $0.toUiModel() }
                    case .failure(let failureBody):
                        print("Failure Response:", failureBody)
                    }
                case .failure(let error):
                    switch error {
                    case .toeknExpired:
                        print("Token expired, please reauthenticate.")
                    case .timeout:
                        print("Request timed out.")
                    case .unknown(let error):
                        print("ERROR: \(error.localizedDescription)")
                    }
                }
            }
    }
    
    private func getAttractions() {
        AttractionsService.getAllAttractions(language: "zh-tw", page: "1")
            .request { [weak self] result in
                switch result {
                case .success(let response):
                    switch response {
                    case .success(let successBody):
//                        print("Success:", rsuccessBody)
//                        self?._attractionsResponse.send(successBody)
                        self?.attractionsList = successBody.data.map { $0.toUiModel() }
                    case .failure(let failureBody):
                        print("Failure Response:", failureBody)
                    }
                case .failure(let error):
                    switch error {
                    case .toeknExpired:
                        print("Token expired, please reauthenticate.")
                    case .timeout:
                        print("Request timed out.")
                    case .unknown(let error):
                        print("ERROR: \(error)")
                    }
                }
            }
    }
    
}
