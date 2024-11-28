//
//  LanguageViewController.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/21.
//

import UIKit
import SnapKit
import Combine

public final class LanguageViewController: BaseViewController {
    
    private weak var viewModel: HomeViewModel!
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupBind()
    }
    
    private func setupBind() {
        viewModel.$languageList
            .sink { [weak self] list in
                self?.tableView.setData(list)
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        titleLabel.text = "選擇語言"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        tableView.languageTableViewDelegate = self
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(30)
            make.trailing.equalToSuperview()
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    private let titleLabel = UILabel()
    private let tableView = LanguageTableView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LanguageViewController: LanguageTableViewDelegate {
    public func onSelectedLanguage(language: String) {
        viewModel.onLanguage.send(language)
        dismiss(animated: true)
    }
}
