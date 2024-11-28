//
//  NewsTableView.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/22.
//

import UIKit
import SnapKit

public protocol HomeNewsTableViewDelegate: AnyObject {
    func onSelected(item: HomeNewsUiModel)
}

public final class HomeNewsTableView: UITableView {
    
    public weak var homeNewsTableViewDelegate: HomeNewsTableViewDelegate?
    private var diffableDataSource: UITableViewDiffableDataSource<Int, HomeNewsUiModel>!
    
    public convenience init() {
        self.init(frame: .zero, style: .plain)
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        separatorStyle = .none
        alwaysBounceHorizontal = false
        showsVerticalScrollIndicator = false
        backgroundColor = nil
        register(HomeNewsTableViewCell.self, forCellReuseIdentifier: HomeNewsTableViewCell.identifier)
        diffableDataSource = UITableViewDiffableDataSource<Int, HomeNewsUiModel>(tableView: self) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeNewsTableViewCell.identifier) as! HomeNewsTableViewCell
            cell.bind(item)
            return cell
        }
        dataSource = diffableDataSource
        delegate = self
    }
    
    public func setData(_ list: [HomeNewsUiModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeNewsUiModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeNewsTableView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = diffableDataSource.itemIdentifier(for: indexPath) {
            homeNewsTableViewDelegate?.onSelected(item: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Table View Cell
public final class HomeNewsTableViewCell: UITableViewCell {
    
    public static let identifier = "HomeNewsTableViewCell"
    
    public func bind(_ item: HomeNewsUiModel) {
        titleLabel.text = item.title
        contentLabel.text = item.description
    }
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }

    private func setupUI() {
        selectionStyle = .none
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 3
        containerView.layer.borderColor = "blue_ACD6FF".color.cgColor
        
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.numberOfLines = 1
        contentLabel.font = .systemFont(ofSize: 15)
        contentLabel.numberOfLines = 3
    }
    
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
