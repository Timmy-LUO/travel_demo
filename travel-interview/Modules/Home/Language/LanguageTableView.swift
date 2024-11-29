//
//  LanguageTableView.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/22.
//

import UIKit
import SnapKit

public protocol LanguageTableViewDelegate: AnyObject {
    func onSelectedLanguage(language: String)
}

public final class LanguageTableView: UITableView {
    
    public weak var languageTableViewDelegate: LanguageTableViewDelegate?
    private var diffableDataSource: UITableViewDiffableDataSource<Int, String>!
        
    public convenience init() {
        self.init(frame: .zero, style: .plain)
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        separatorStyle = .none
        alwaysBounceHorizontal = false
        alwaysBounceVertical = false
        showsVerticalScrollIndicator = false
        register(LanguageTableViewCell.self, forCellReuseIdentifier: LanguageTableViewCell.identifier)
        diffableDataSource = UITableViewDiffableDataSource<Int, String>(tableView: self) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.identifier) as! LanguageTableViewCell
            cell.bind(item)
            return cell
        }
        dataSource = diffableDataSource
        delegate = self
    }
    
    public func setData(_ list: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension LanguageTableView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = diffableDataSource.itemIdentifier(for: indexPath) {
            languageTableViewDelegate?.onSelectedLanguage(language: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Table View Cell
public final class LanguageTableViewCell: UITableViewCell {
    
    public static let identifier = "LanguageTableViewCell"
    
    public func bind(_ item: String) {
        titleLabel.text = item
    }
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }

    private func setupUI() {
        selectionStyle = .none
        titleLabel.font = .systemFont(ofSize: 15)
    }
    
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
