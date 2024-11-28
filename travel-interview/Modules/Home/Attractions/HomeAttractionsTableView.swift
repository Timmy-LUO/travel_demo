//
//  HomeAttractionsTableView.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/22.
//

import UIKit
import SnapKit
import Kingfisher
import Combine

public protocol HomeAttractionsTableViewDelegate: AnyObject {
    func onSelected(item: HomeAttractionsUiModel)
}

public final class HomeAttractionsTableView: UITableView {

    public weak var homeAttractionsTableViewDelegate: HomeAttractionsTableViewDelegate?
    private var diffableDataSource: UITableViewDiffableDataSource<Int, HomeAttractionsUiModel>!
    
    public convenience init() {
        self.init(frame: .zero, style: .plain)
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        separatorStyle = .none
        alwaysBounceHorizontal = false
        showsVerticalScrollIndicator = false
        backgroundColor = nil
        register(HomeAttractionsTableViewCell.self, forCellReuseIdentifier: HomeAttractionsTableViewCell.identifier)
        diffableDataSource = UITableViewDiffableDataSource<Int, HomeAttractionsUiModel>(tableView: self) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeAttractionsTableViewCell.identifier) as! HomeAttractionsTableViewCell
            cell.bind(item)
            return cell
        }
        dataSource = diffableDataSource
        delegate = self
    }
    
    public func setData(_ list: [HomeAttractionsUiModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeAttractionsUiModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeAttractionsTableView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = diffableDataSource.itemIdentifier(for: indexPath) {
            homeAttractionsTableViewDelegate?.onSelected(item: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Table View Cell
public final class HomeAttractionsTableViewCell: UITableViewCell {
    
    public static let identifier = "HomeAttractionsTableViewCell"
    private var cancellables = Set<AnyCancellable>()
    
    public func bind(_ item: HomeAttractionsUiModel) {
        if !item.imageList.isEmpty && 
            item.imageList[0].src != ""
        {
            attractionImageView.kf.indicatorType = .activity
            attractionImageView.kf.setImage(
                with: URL(string: item.imageList[0].src),
                placeholder: UIImage(systemName: "Default")
            )
        }
        titleLabel.text = item.name
        contentLabel.text = item.introduction
    }
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        cancellables = Set<AnyCancellable>()
    }

    private func setupUI() {
        selectionStyle = .none
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 3
        containerView.layer.borderColor = "blue_ACD6FF".color.cgColor
        
        attractionImageView.layer.borderWidth = 1
        attractionImageView.layer.cornerRadius = 8
        attractionImageView.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 1
        contentLabel.font = .systemFont(ofSize: 15)
        contentLabel.numberOfLines = 3
    }
    
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(-10)
        }
        
        containerView.addSubview(attractionImageView)
        attractionImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerY.equalToSuperview()
            make.leading.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(attractionImageView.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
        }
        
        containerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.trailing.bottom.equalToSuperview()
        }
    }
    
    private let containerView = UIView()
    private let attractionImageView = UIImageView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
