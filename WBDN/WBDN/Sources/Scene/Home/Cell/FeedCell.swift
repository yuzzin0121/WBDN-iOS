//
//  FeedCell.swift
//  WBDN
//
//  Created by Mason Kim on 11/25/23.
//

import UIKit
import SnapKit
import Then

final class FeedCell: UICollectionViewCell {
    static let reuseIdentifier = "FeedCell"

    // MARK: - UI Components

    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }

    private let starCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.text = "0"
        $0.textColor = .customGray
    }

    private let nicknameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.text = "닉네임"
        $0.textColor = .white
    }

    private let starImage = UIImageView().then {
        $0.image = UIImage(named: "star")
        $0.contentMode = .scaleAspectFill
    }

    private lazy var starInfoStackView = UIStackView(arrangedSubviews: [
        starImage,
        starCountLabel
    ]).then {
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private lazy var infoStackView = UIStackView(arrangedSubviews: [
        nicknameLabel,
        starInfoStackView
    ]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(infoStackView)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(8)
        }

        infoStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    func configure(with image: UIImage?, title: String) {
        imageView.image = image

    }
}


@available(iOS 17, *)
#Preview(traits: .defaultLayout, body: {
    let cell = FeedCell()
    return cell
})