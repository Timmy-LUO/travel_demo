//
//  HomeNewsDetailViewController.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/25.
//

import UIKit
import SnapKit
import WebKit

public final class HomeNewsDetailViewController: BaseViewController {
    
    private let newsModel: HomeNewsUiModel!
    
    public init(newsModel: HomeNewsUiModel) {
        self.newsModel = newsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    override var navigationItemTitle: String { "latest_news".localised }
    
    private func setupUI() {
        if let url = URL(string: newsModel.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func setupLayout() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private let webView = WKWebView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
