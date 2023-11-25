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

    private let profileEmojiLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 40)
        $0.text = "🐰"
    }

    private lazy var profileEmojiContainerView = UIView().then {
        $0.backgroundColor = .white
        let width: CGFloat = 68
        $0.snp.makeConstraints { make in
            make.width.height.equalTo(width)
        }
        $0.clipsToBounds = false
        $0.layer.cornerRadius = width / 2

        $0.addSubview(profileEmojiLabel)
        profileEmojiLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private let headerStarImageView = UIImageView(image: .mainHeaderStars)

    private let profileGreetingLabel = UILabel().then {
        $0.text = "뉴진스 님을 위한\n밤하늘이에요!"
        $0.font = .pretendard(size: 15, weight: .bold)
        $0.textColor = .white
        $0.numberOfLines = 2
    }

    private lazy var headerStackView = UIStackView(arrangedSubviews: [
        profileEmojiContainerView,
        profileGreetingLabel
    ]).then {
        $0.alignment = .center
        $0.spacing = 20
    }

    private let recommendationButton = UIButton().then {
        $0.backgroundColor = .customYellow
        $0.setTitle("추천", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 17, weight: .bold)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 20
    }

    private lazy var floatingButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .customYellow
        config.baseForegroundColor = .black
        config.cornerStyle = .capsule
        let image = UIImage(systemName: "plus")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        config.image = image
        $0.configuration = config
        $0.layer.shadowRadius = 10
        $0.layer.shadowOpacity = 0.3

        $0.addTarget(self, action: #selector(tappedFloatingButton), for: .touchUpInside)
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        applySnapshot(with: [
            UIImage(named: "test1")!,
            UIImage(named: "test2")!,
            UIImage(named: "test3")!,
            UIImage(named: "test4")!,
            UIImage(named: "test5")!,
            UIImage(named: "test6")!,

        ])

        Task {
            do {
                let response = try await NetworkService.shared.request(.getPosts, type: BaseResponse<PostListResDto>.self)
                print(response)
                let posts = response.result?.postListDtos
                print("post?", posts)
            } catch {
                print("error", error)
            }
        }

        applyGradientBackground()
    }

    // MARK: - Public

    // MARK: - Private

    private func setup() {
        setupLayout()
        setupCollectionView()
    }

    // MARK: - Actions

    @objc private func tappedFloatingButton() {
        let addImageViewController = AddImageViewController()
        
        // 탭바를 가리기 위해, Scene 단위의 navigation에서 이동
        SceneDelegate.navigationController
            .pushViewController(addImageViewController, animated: true)
    }
}

// MARK: - Layout

extension HomeViewController {

    private func setupLayout() {
        setupHeaderLayout()
        setupRecommendationButtonLayout()
        setupCollectionViewLayout()
        setupFloatingButtonLayout()
    }

    private func setupHeaderLayout() {
        view.addSubview(headerStackView)
        headerStackView.snp.makeConstraints { make in
            // make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.top.equalToSuperview().offset(80)
            make.horizontalEdges.equalToSuperview().inset(16)
        }

        view.addSubview(headerStarImageView)
        headerStarImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(headerStackView.snp.centerY).offset(-8)
        }
    }

    private func setupRecommendationButtonLayout() {
        view.addSubview(recommendationButton)
        recommendationButton.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
    }

    private func setupFloatingButtonLayout() {
        view.addSubview(floatingButton)
        floatingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.width.height.equalTo(60)
        }
    }

    private func setupCollectionViewLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendationButton.snp.bottom).offset(16)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        collectionView.backgroundColor = .clear
    }

    private func setupCollectionView() {
        collectionView.register(
            FeedCell.self,
            forCellWithReuseIdentifier: FeedCell.reuseIdentifier
        )

        collectionView.collectionViewLayout = pinterestLayout
        pinterestLayout.delegate = self
        collectionView.delegate = self
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

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, 
                        didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let detailViewController = DetailViewController()
        // navigationController?.pushViewController(detailViewController, animated: true)
        SceneDelegate.navigationController.pushViewController(detailViewController, animated: true)
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

    private func heightForPhoto(at indexPath: IndexPath) -> CGFloat {
        guard let image = dataSource.itemIdentifier(for: indexPath) else { return 0 }
        let imageRatio = image.size.height / image.size.width
        let height = (view.frame.width / 2) * imageRatio
        return height
    }
}

@available(iOS 17, *)
#Preview(traits: .defaultLayout, body: {
    HomeViewController()
})
