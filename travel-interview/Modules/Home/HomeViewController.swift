//
//  HomeViewController.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/20.
//

import UIKit
import SnapKit
import Combine
import Kingfisher
import Pageboy

public final class HomeViewController: BaseViewController {
    
    private weak var parentCoordinator: WelcomeCoordinator!
    private var viewModel: HomeViewModel!
    
    public init(
        _ parentCoordinator: WelcomeCoordinator,
        viewModel: HomeViewModel
    ) {
        self.parentCoordinator = parentCoordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setupUI), name: .languageDidChange, object: nil)
        setupUI()
        setupLayout()
        setupBinding()
    }
    
    override public var hidesBackButton: Bool { true }
    
    @objc private func changeLanguage() {
        let contentViewController = LanguageViewController(viewModel: viewModel)
        contentViewController.preferredContentSize = CGSize(width: 200, height: 300)
        contentViewController.modalPresentationStyle = .popover
        contentViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        if let popoverController = contentViewController.popoverPresentationController {
            popoverController.delegate = self
        }
        present(contentViewController, animated: true)
    }
    
    private func setupBinding() {
        viewModel.errorMessage
            .compactMap { $0 }
            .sink { [weak self] message in
                self?.promptAlert(message: message)
            }
            .store(in: &cancellables)
    }
    
    @objc
    private func setupUI() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "globe"),
            style: .plain,
            target: self,
            action: #selector(changeLanguage)
        )
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        newsTabButton.isSelected = true
        newsTabButton.setTitle("latest_news".localised, for: .normal)
        newsTabButton.delegate = self
        attractionsButton.setTitle("tourist_attractions".localised, for: .normal)
        attractionsButton.delegate = self
        
        viewControllerList.append(HomeNewsViewController(parentCoordinator, viewModel: viewModel))
        viewControllerList.append(HomeAttractionsViewController(parentCoordinator, viewModel: viewModel))
        addChild(pageViewController)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.didMove(toParent: self)
    }
    
    private func setupLayout() {
        view.addSubview(newsTabButton)
        newsTabButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        view.addSubview(attractionsButton)
        attractionsButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalTo(newsTabButton.snp.trailing).offset(10)
            make.centerY.equalTo(newsTabButton.snp.centerY)
        }
        
        view.addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(newsTabButton.snp.bottom).offset(20)
        }
    }
    
    private let newsTabButton = RadioButton(borderWidth: 2)
    private let attractionsButton = RadioButton(borderWidth: 2)
    private var buttonList: [RadioButton] { [newsTabButton, attractionsButton] }
    private let pageViewController = PageboyViewController()
    private var viewControllerList: [UIViewController] = []
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .languageDidChange, object: nil)
    }
}

extension HomeViewController: PageboyViewControllerDataSource {
    public func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        viewControllerList.count
    }
    
    public func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        viewControllerList[index]
    }
    
    public func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        .at(index: 0)
    }
}

extension HomeViewController: UIPopoverPresentationControllerDelegate, PageboyViewControllerDelegate, RadioButtonDelegate {
    // PopoverPresentationControllerDelegate
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    // PageboyViewControllerDelegate
    public func pageboyViewController(_ pageboyViewController: Pageboy.PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: Pageboy.PageboyViewController.PageIndex) {}
    
    public func pageboyViewController(_ pageboyViewController: Pageboy.PageboyViewController, didScrollTo position: CGPoint, direction: Pageboy.PageboyViewController.NavigationDirection, animated: Bool) {}
    
    public func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: Int, direction: PageboyViewController.NavigationDirection, animated: Bool) {}
    
    public func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: Int, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        buttonList.forEach { $0.isSelected = false }
        buttonList[index].isSelected = true
    }
    
    // RadioButtonDelegate
    public func onClicked(radioButton: RadioButton) {
        buttonList.filter { $0 != radioButton }.forEach { $0.isSelected = false }
        if let index = buttonList.firstIndex(of: radioButton) {
            pageViewController.scrollToPage(.at(index: index), animated: true)
        }
    }
}
