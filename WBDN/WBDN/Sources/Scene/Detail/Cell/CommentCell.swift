//
//  CommentCell.swift
//  WBDN
//
//  Created by Mason Kim on 11/26/23.
//

import UIKit
import SnapKit

import UIKit

final class CommentCell: UIView {

    // MARK: - UI

    private let profileEmojiLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30)
        $0.text = "🐰"
    }

    private lazy var profileEmojiContainerView = UIView().then {
        $0.backgroundColor = .white
        let width: CGFloat = 48
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

    private let nicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = .pretendard(size: 15, weight: .semiBold)
        $0.textColor = .white
    }

    private let commentLabel = UILabel().then {
        $0.text = "사진 잘 찍으셨네요~!!"
        $0.font = .pretendard(size: 11, weight: .medium)
        $0.textColor = .white
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func configure(nickname: String, comment: String) {
        nicknameLabel.text = nickname
        commentLabel.text = comment
    }

    // MARK: - Private

    private func setup() {
        setupLayout()
    }

    private func setupLayout() { 
        let profileView = UIView()
        [profileEmojiContainerView, nicknameLabel].forEach { view in
            profileView.addSubview(view)
        }

        profileEmojiContainerView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
        }

        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileEmojiContainerView.snp.trailing).offset(12)
            make.centerY.equalTo(profileEmojiContainerView)
        }

        addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }

        let commentContainerView = UIView()
        commentContainerView.clipsToBounds = true
        commentContainerView.layer.cornerRadius = 10
        commentContainerView.layer.maskedCorners = [
            .layerMaxXMaxYCorner,
            .layerMaxXMinYCorner,
            // .layerMinXMinYCorner,
            .layerMinXMaxYCorner
        ]
        commentContainerView.backgroundColor = .init(hex: 0x2C3039)

        addSubview(commentContainerView)
        commentContainerView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(profileView.snp.bottom).offset(8)
        }
        
        commentContainerView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(16)
        }
    }
}

@available(iOS 17, *)
#Preview(traits: .fixedLayout(width: 500, height: 150), body: {
    let cell = CommentCell()
    cell.backgroundColor = .blue
    return cell
})
