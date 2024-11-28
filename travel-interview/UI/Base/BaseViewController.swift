//
//  BaseViewController.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/26.
//

import UIKit
import Combine

open class BaseViewController: UIViewController {
    
    internal var cancellables = Set<AnyCancellable>()
    internal var navigationItemTitle: String { "" }
    internal var hidesBackButton: Bool { false }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = navigationItemTitle
    }
    
    private func setupUI() {
        view.backgroundColor = "white_FFFFFF".color
        if !hidesBackButton {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "arrow.backward"),
                style: .plain,
                target: self,
                action: #selector(back)
            )
            navigationItem.leftBarButtonItem?.tintColor = .white
        }
    }
    
    @objc
    private func back() {
        navigationController?.popViewController(animated: true)
    }
}
