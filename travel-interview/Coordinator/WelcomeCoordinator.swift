//
//  WelcomeCoordinator.swift
//  DailyBellePOS
//
//  Created by Harry on 2023/2/10.
//

import UIKit

public final class WelcomeCoordinator: Coordinator {
    
    public var childCoordinators = [Coordinator]()
    public var rootViewController: UIViewController?
    public var navigationController: UINavigationController?
    
    public init() {
        let navigationController = UINavigationController()
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.isNavigationBarHidden = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 設定為不透明
        appearance.backgroundColor = .systemBlue // 設定背景顏色為藍色
        appearance.shadowColor = nil // 隱藏底部陰影線（可選）
        appearance.titleTextAttributes = [.foregroundColor: "white_FFFFFF".color]
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationController = navigationController
    }
    
    public func start() {
        let vc = HomeViewController(self, viewModel: HomeViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    public func toNewsDetail(model: HomeNewsUiModel) {
        let vc = HomeNewsDetailViewController(newsModel: model)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    public func toAttractiionsDetail(model: HomeAttractionsUiModel) {
        let vc = HomeAttractionsDetailViewController(self, attractionsModel: model)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    public func toAttractiionsWebView(model: HomeAttractionsUiModel) {
        let vc = HomeAttractionsWebViewController(attractionsModel: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}
