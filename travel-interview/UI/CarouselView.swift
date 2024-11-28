//
//  CarouselView.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/27.
//

import UIKit
import SnapKit
import Kingfisher

public final class CarouselView: UIView {
    
    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    public convenience init() {
        self.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    public func setData(_ list: [HomeAttractionsImageModel]) {
        pageControl.numberOfPages = list.count
        collectionView.setData(list)
    }
    
    private func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }
    
    private func setupUI() {
        collectionView.delegate = self
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = "blue_ACD6FF".color
        pageControl.currentPageIndicatorTintColor = "blue_0080FF".color
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    private let collectionView = CarouselCollectionView()
    private let pageControl = UIPageControl()
}

extension CarouselView: UICollectionViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

// MARK: Carousel Collection View
public final class CarouselCollectionView: UICollectionView {
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Int, HomeAttractionsImageModel>!
    
    public convenience init() {
        let layout = UICollectionViewFlowLayout()
        let screenSize = UIScreen.main.bounds
        layout.minimumLineSpacing = CGFloat(integerLiteral: 0)
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 0)
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        layout.itemSize = CGSize(width: screenSize.width - 40, height: 200)
        self.init(frame: .zero, collectionViewLayout: layout)
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        let cellRegistration = UICollectionView.CellRegistration<CarouselCollectionViewCell, HomeAttractionsImageModel> { cell, _, item in
            cell.bind(item)
        }
        diffableDataSource =  UICollectionViewDiffableDataSource<Int, HomeAttractionsImageModel>(
            collectionView: self,
            cellProvider: { collectionView, indexPath, item in
                collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: item
                )
            }
        )
        dataSource = diffableDataSource
    }
    
    public func setData(_ list: [HomeAttractionsImageModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeAttractionsImageModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: Cell
public final class CarouselCollectionViewCell: UICollectionViewCell {
        
    public func bind(_ model: HomeAttractionsImageModel) {
        if !model.src.isEmpty {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: URL(string: model.src),
                placeholder: UIImage(systemName: "Default")
            )
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
    }
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private let imageView = UIImageView()
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
