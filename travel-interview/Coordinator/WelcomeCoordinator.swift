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
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        appearance.shadowColor = nil
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
