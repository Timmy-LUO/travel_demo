//
//  HomeAttractionsViewController.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/22.
//

import UIKit
import SnapKit
import Combine

public final class HomeAttractionsViewController: BaseViewController {
    
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
        setupUI()
        setupLayout()
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.$attractionsList
            .sink { [weak self] list in
                self?.tableView.setData(list)
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        tableView.homeAttractionsTableViewDelegate = self
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private let tableView = HomeAttractionsTableView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeAttractionsViewController: HomeAttractionsTableViewDelegate {
    public func onSelected(item: HomeAttractionsUiModel) {
        parentCoordinator.toAttractiionsDetail(model: item)
    }
}
