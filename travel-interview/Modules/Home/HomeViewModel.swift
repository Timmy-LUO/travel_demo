//
//  HomeViewModel.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/21.
//

import Foundation
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
    
    public var errorMessage: AnyPublisher<String?, Never> { _errorMessage.eraseToAnyPublisher() }
    
    // internal
    private var _errorMessage = CurrentValueSubject<String?, Never>(nil)
    
    public init() {
        onLanguage
            .sink { [weak self] language in
                self?.changeLanguage(language)
            }
            .store(in: &cancellables)
        
        getDefaultLocale()
        getNews()
        getAttractions()
    }
    
    private func getDefaultLocale() {
        if let _ = LanguageManager.instance.languageCode {
            return
        }
        
        if let languageCode = Locale.current.language.languageCode {
            LanguageManager.instance.languageCode = "\(languageCode)"
        }
    }
    
    private func changeLanguage(_ language: String) {
        let code = toLanguageCode(language: language)
        LanguageManager.instance.languageCode = code
        NotificationCenter.default.post(name: .languageDidChange, object: nil)
        getNews()
        getAttractions()
    }
    
    private func toLanguageCode(language: String) -> String {
        var code: String = ""
        
        switch language {
        case "繁體中文":
            code = "zh-Hant"
        case "简体中文":
            code = "zh-Hans"
        case "English":
            code = "en"
        case "日本語":
            code = "ja"
        case "한국어":
            code = "ko"
        case "Español":
            code = "es"
        case "Bahasa Indonesia":
            code = "id"
        case "ภาษาไทย":
            code = "th"
        case "Tiếng Việt":
            code = "vi"
        default:
            print("Unhandle Language Code")
        }
        
        return code
    }
    
    private func toRequestLanguageCode(language: String) -> String {
        var code: String = ""
        
        switch language {
        case "zh-Hant":
            code = "zh-tw"
        case "zh-Hans":
            code = "zh-cn"
        default:
            code = language
        }
        
        return code
    }
    
    private func getNews() {
        guard let languageCode = LanguageManager.instance.languageCode else { return }
        NewsService.getNews(language: toRequestLanguageCode(language: languageCode))
            .request { [weak self] result in
                switch result {
                case .success(let response):
                    switch response {
                    case .success(let successBody):
                        self?.newsList = successBody.data.map { $0.toUiModel() }
                    case .failure(let failureBody):
                        self?._errorMessage.send(failureBody.Message)
                    }
                case .failure(let error):
                    switch error {
                    case .toeknExpired:
                        self?._errorMessage.send("Token expired, please reauthenticate.")
                    case .timeout:
                        self?._errorMessage.send("Request timed out.")
                    case .unknown(let error):
                        self?._errorMessage.send("ERROR: \(error.localizedDescription)")
                    }
                }
            }
    }
    
    private func getAttractions() {
        guard let languageCode = LanguageManager.instance.languageCode else { return }
        AttractionsService.getAllAttractions(language: toRequestLanguageCode(language: languageCode))
            .request { [weak self] result in
                switch result {
                case .success(let response):
                    switch response {
                    case .success(let successBody):
                        self?.attractionsList = successBody.data.map { $0.toUiModel() }
                    case .failure(let failureBody):
                        self?._errorMessage.send(failureBody.Message)
                    }
                case .failure(let error):
                    switch error {
                    case .toeknExpired:
                        self?._errorMessage.send("Token expired, please reauthenticate.")
                    case .timeout:
                        self?._errorMessage.send("Request timed out.")
                    case .unknown(let error):
                        self?._errorMessage.send("ERROR: \(error.localizedDescription)")
                    }
                }
            }
    }
    
}
