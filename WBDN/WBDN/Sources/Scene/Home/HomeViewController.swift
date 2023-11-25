//
//  HomeViewController.swift
//  WBDN
//
//  Created by Mason Kim on 11/25/23.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    enum Section {
        case list
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, UIImage>

    // MARK: - Properties

    private lazy var dataSource = makeDataSource()

    // MARK: - UI

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: pinterestLayout
    )
    private let pinterestLayout = PinterestLayout()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        let sample1 = UIImage(named: "test1")
        let sample2 = UIImage(named: "test2")
        let sample3 = UIImage(named: "test3")
        let sample4 = UIImage(named: "test4")

        applySnapshot(with: [
            sample1!,
            sample2!,
            sample3!,
            sample4!
        ])
    }

    // MARK: - Public

    // MARK: - Private

    private func setup() {
        setupLayout()
        setupCollectionView()
    }
}

// MARK: - Layout

extension HomeViewController {

    private func setupLayout() {
        setupCollectionViewLayout()
    }

    private func setupCollectionViewLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupCollectionView() {
        collectionView.register(
            FeedCell.self,
            forCellWithReuseIdentifier: FeedCell.reuseIdentifier
        )

        collectionView.collectionViewLayout = pinterestLayout
        pinterestLayout.delegate = self
    }

    private func heightForPhoto(at indexPath: IndexPath) -> CGFloat {
        guard let image = dataSource.itemIdentifier(for: indexPath) else { return 0 }
        let imageRatio = image.size.height / image.size.width
        let height = (view.frame.width / 2) * imageRatio
        return height
    }

}


// MARK: - DataSource & Snapshot

extension HomeViewController {
    private func makeDataSource() -> DataSource {
        DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FeedCell.reuseIdentifier,
                    for: indexPath
                ) as? FeedCell else {
                    return UICollectionViewCell()
                }

                cell.configure(with: item, title: "ㅁㅁㅁㅁ~~")

                return cell
            }
        )
    }

    private func applySnapshot(with images: [UIImage]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UIImage>()
        snapshot.appendSections([.list])
        snapshot.appendItems(images, toSection: .list)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - PinterestLayoutDelegate

extension HomeViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return .zero }
        let photoRatio = item.size.width / item.size.height
        let cellWidth: CGFloat = (view.bounds.width - 4) / 2 // 셀 가로 크기
        return cellWidth * photoRatio
    }
}
