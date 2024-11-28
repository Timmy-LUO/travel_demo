//
//  HomeAttractionsDetailViewController.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/26.
//

import UIKit
import SnapKit

public final class HomeAttractionsDetailViewController: BaseViewController {
    
    private weak var parentCoordinator: WelcomeCoordinator!
    private let attractionsModel: HomeAttractionsUiModel!
    
    public init(
        _ parentCoordinator: WelcomeCoordinator,
        attractionsModel: HomeAttractionsUiModel
    ) {
        self.parentCoordinator = parentCoordinator
        self.attractionsModel = attractionsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    override public var navigationItemTitle: String { attractionsModel.name }
    
    @objc
    private func toWebView() {
        parentCoordinator.toAttractiionsWebView(model: attractionsModel)
    }
    
    private func setupUI() {
        carouselView.setData(attractionsModel.imageList)
        openTimeLabel.numberOfLines = 0
        openTimeLabel.text = "營業時間: \(attractionsModel.openTime)"
        addressLabel.numberOfLines = 0
        addressLabel.text = "地址: \(attractionsModel.address)"
        telephoneLabel.text = "聯絡電話: \(attractionsModel.tel)"
        webViewButton.setTitle("網址: \(attractionsModel.url)", for: .normal)
        webViewButton.setTitleColor(.blue, for: .normal)
        webViewButton.addTarget(self, action: #selector(toWebView), for: .touchUpInside)
        separateView.backgroundColor = "gray_F0F0F0".color
        contentTextView.font = .systemFont(ofSize: 15)
        contentTextView.text = attractionsModel.introduction
        contentTextView.sizeToFit()
        contentTextView.isScrollEnabled = false
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.leading.top.trailing.bottom.equalToSuperview()
        }
        
        containerView.addSubview(carouselView)
        carouselView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(containerView.snp.top).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(230)
        }
        
        containerView.addSubview(openTimeLabel)
        openTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(carouselView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        containerView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.leading.equalTo(openTimeLabel.snp.leading)
            make.top.equalTo(openTimeLabel.snp.bottom).offset(10)
            make.trailing.equalTo(openTimeLabel.snp.trailing)
        }
        
        containerView.addSubview(telephoneLabel)
        telephoneLabel.snp.makeConstraints { make in
            make.leading.equalTo(openTimeLabel.snp.leading)
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.trailing.equalTo(openTimeLabel.snp.trailing)
        }
        
        containerView.addSubview(webViewButton)
        webViewButton.snp.makeConstraints { make in
            make.leading.equalTo(openTimeLabel.snp.leading)
            make.top.equalTo(telephoneLabel.snp.bottom).offset(10)
            make.trailing.equalTo(openTimeLabel.snp.trailing)
        }
        
        containerView.addSubview(separateView)
        separateView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo(webViewButton.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        containerView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { make in
            make.leading.equalTo(openTimeLabel.snp.leading)
            make.top.equalTo(separateView.snp.bottom).offset(20)
            make.trailing.equalTo(openTimeLabel.snp.trailing)
        }
        
        let lastView = containerView.subviews.last!
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(lastView.snp.bottom).offset(20)
        }
    }
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let carouselView = CarouselView()
    private let openTimeLabel = UILabel()
    private let addressLabel = UILabel()
    private let telephoneLabel = UILabel()
    private let webViewButton = UIButton()
    private let separateView = UIView()
    private let contentTextView = UITextView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
