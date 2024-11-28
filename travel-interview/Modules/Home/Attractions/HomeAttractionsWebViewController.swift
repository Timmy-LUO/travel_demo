//
//  HomeAttractionsWebViewController.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/26.
//

import UIKit
import SnapKit
import WebKit

public final class HomeAttractionsWebViewController: BaseViewController {
    
    private let attractionsModel: HomeAttractionsUiModel!
    
    public init(attractionsModel: HomeAttractionsUiModel) {
        self.attractionsModel = attractionsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        if let url = URL(string: attractionsModel.url) {
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
