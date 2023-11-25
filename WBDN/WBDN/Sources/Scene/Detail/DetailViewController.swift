//
//  DetailViewController.swift
//  WBDN
//
//  Created by Mason Kim on 11/25/23.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class DetailViewController: UIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    public let mainScrollView = UIScrollView().then {
        // $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .automatic
    }
    private let scrollViewContainerView = UIView()
    private let containerView = UIView()

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

    private let starImageView = UIImageView(image: UIImage(named: "star"))

    private let photoImageView = UIImageView().then {
        $0.image = .test4
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }

    private let deviceInfoChip = LabelChip().then {
        $0.title = "iPhone 14 Pro"
        $0.isBackgroundSynced = false
        $0.titleColor = .customYellow
        $0.layer.borderColor = UIColor.customYellow.cgColor
        $0.layer.borderWidth = 1
    }

    private let isoValueLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "640"
        $0.font = .pretendard(size: 15, weight: .semiBold)
    }

    private let shutterSpeedValueLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "1/8 s"
        $0.font = .pretendard(size: 15, weight: .semiBold)
    }

    /// 조리개 값 레이블
    private let apertureValueLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "f 1.8"
        $0.font = .pretendard(size: 15, weight: .semiBold)
    }

    /// 세로 디바이더
    private var verticalDividerView: UIView {
        let view = dividerView
        view.snp.makeConstraints { make in
            make.width.equalTo(1)
        }
        view.backgroundColor = UIColor(hex: 0xA0A0A0)
        return view
    }

    /// 디바이더
    private var dividerView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xA0A0A0)
        return view
    }

    private let retouchInfoLabel = UILabel().then {
        $0.text = "후보정이나 필터는 따로 안씀요~"
        $0.textColor = .white
        $0.font = .pretendard(size: 11, weight: .medium)
    }

    private let commentInfoLabel = UILabel().then {
        $0.text = "카메라 기본 보정기능으로 노출 값을 내려주었습니다~ \n한강공원 갔다가 달이 너무 예뻐서 찍었어요 .. ㅎㅎㅎㅋㅋㅋ~"
        $0.textColor = .white
        $0.font = .pretendard(size: 11, weight: .medium)
    }

    private let locationInfoLabel = UILabel().then {
        $0.text = "서울특별시 마포구"
        $0.textColor = .white
        $0.font = .pretendard(size: 11, weight: .medium)
    }

    private let dayInfoLabel = UILabel().then {
        $0.text = "2023년 11월 25일 토요일"
        $0.textColor = .white
        $0.font = .pretendard(size: 11, weight: .medium)
    }

    /// 댓글 스택뷰
    let commentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        view.backgroundColor = .customNavy
    }

    // MARK: - Public

    func configure(post: Post) {
        guard let url = URL(string: post.photoUrl) else { return }
        photoImageView.kf.setImage(with: url)

        Task {
            let response = try await NetworkService.shared.request(.getComments(postId: post.postId), type: BaseResponse<GetCommentsDto>.self)
            let comments = response.result?.comments

            await MainActor.run {
                if let comments {
                    configure(comments: comments)
                }
            }
        }

        post.likes
        nicknameLabel.text = post.nickname
    }

    func configure(comments: [GetCommentDto]) {
        comments.map {
            let cell = CommentCell()
            cell.configure(nickname: "닉네임", comment: $0.content)
            return cell
        }.forEach { cell in
            commentStackView.addArrangedSubview(cell)
        }
    }

    // MARK: - Private

    private func setup() {
        setupLayout()
    }

    private func setupLayout() {
        // 스크롤뷰 설정
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }

        mainScrollView.addSubview(scrollViewContainerView)
        scrollViewContainerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        scrollViewContainerView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

        // 프로필 설정

        let profileView = UIView()
        [profileEmojiContainerView, nicknameLabel, starImageView].forEach { view in
            profileView.addSubview(view)
        }

        profileEmojiContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileEmojiContainerView.snp.trailing).offset(12)
            make.top.bottom.equalToSuperview()
        }

        starImageView.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
        }

        containerView.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }

        // 사진

        containerView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
        }

        // 촬영 기기

        let deviceInfoHeaderLabel = UILabel().then {
            $0.text = "촬영 기기"
            $0.textColor = .white
            $0.font = .pretendard(size: 17, weight: .semiBold)
        }

        containerView.addSubview(deviceInfoHeaderLabel)
        deviceInfoHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
        }

        containerView.addSubview(deviceInfoChip)
        deviceInfoChip.snp.makeConstraints { make in
            make.top.equalTo(deviceInfoHeaderLabel.snp.bottom).offset(6)
        }

        // 추가 촬영 정보

        let additionalInfoHeaderLabel = UILabel().then {
            $0.text = "추가 촬영 정보"
            $0.textColor = .white
            $0.font = .pretendard(size: 17, weight: .semiBold)
        }

        containerView.addSubview(additionalInfoHeaderLabel)
        additionalInfoHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(deviceInfoChip.snp.bottom).offset(20)
            make.leading.equalToSuperview()
        }

        let additionalInfoStackView = additionalInfoView()
        containerView.addSubview(additionalInfoStackView)
        additionalInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(additionalInfoHeaderLabel.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview()
        }

        let retouchInfoView = infoView(imageName: "info", headerText: "후보정 방법", infoLabel: retouchInfoLabel)
        let commentInfoView = infoView(imageName: "comment", headerText: "코멘트", infoLabel: commentInfoLabel)
        let locationInfoView = infoView(imageName: "location", headerText: "위치", infoLabel: locationInfoLabel)
        let dayInfoView = infoView(imageName: "calendar", headerText: "찍은 날짜", infoLabel: dayInfoLabel)

        let infoStackView = UIStackView(arrangedSubviews: [
            retouchInfoView, commentInfoView, locationInfoView, dayInfoView
        ]).then {
            $0.axis = .vertical
            $0.spacing = 16
        }

        containerView.addSubview(infoStackView)
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(additionalInfoStackView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
        }

        let divider = dividerView
        containerView.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(infoStackView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview()
        }

        // 댓글

        let commentHeaderView = commentHeaderView()
        containerView.addSubview(commentHeaderView)
        commentHeaderView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            // make.bottom.equalToSuperview() // TODO: 추가 시, 아래의 컴포넌트로...
        }

        containerView.addSubview(commentStackView)
        commentStackView.snp.makeConstraints { make in
            make.top.equalTo(commentHeaderView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    // 추가 촬영 정보
    private func additionalInfoView() -> UIView {
        let view = UIView()
        view.backgroundColor = .init(hex: 0x2C3039)
        view.layer.cornerRadius = 16

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        let ISOStackView = additionalInfoInnerStackView(headerText: "ISO", infoLabel: isoValueLabel)
        let shutterSpeedStackView = additionalInfoInnerStackView(headerText: "셔터 스피드", infoLabel: shutterSpeedValueLabel)
        let apertureStackView = additionalInfoInnerStackView(headerText: "조리개 값", infoLabel: apertureValueLabel)

        [
            ISOStackView,
            verticalDividerView,
            shutterSpeedStackView,
            verticalDividerView,
            apertureStackView
        ].forEach { view in
            stackView.addArrangedSubview(view)
        }

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
        }

        return view
    }

    // 추가 촬영 정보 내부의 정보 스택뷰
    private func additionalInfoInnerStackView(headerText: String, infoLabel: UILabel) -> UIStackView {
        let innerStackView = UIStackView()
        innerStackView.axis = .vertical
        innerStackView.alignment = .center
        innerStackView.spacing = 10
        let headerLabel = UILabel().then {
            $0.font = .pretendard(size: 13, weight: .semiBold)
            $0.textColor = .white
            $0.text = headerText
        }
        innerStackView.addArrangedSubview(headerLabel)
        innerStackView.addArrangedSubview(infoLabel)
        return innerStackView
    }

    // 촬영 정보 (후보정 방법, 코멘트, 위치, 찍은 날짜)
    private func infoView(imageName: String, headerText: String, infoLabel: UILabel) -> UIView {
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 10
        }

        let imageView = UIImageView().then {
            $0.image = UIImage(named: imageName)
            $0.contentMode = .scaleAspectFit
        }

        let headerTextLabel = UILabel().then {
            $0.textColor = .white
            $0.font = .pretendard(size: 17, weight: .semiBold)
            $0.text = headerText
        }

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(headerTextLabel)

        let containerStackView = UIStackView(arrangedSubviews: [
            stackView, infoLabel
        ]).then {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 6
        }

        return containerStackView
    }

    private func commentHeaderView() -> UIView {
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 8
        }

        let label = UILabel()
        label.text = "댓글"
        label.font = .pretendard(size: 17, weight: .semiBold)
        label.textColor = .white

        let imageView = UIImageView().then {
            $0.image = .commentDots
            $0.contentMode = .scaleAspectFit
        }

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(imageView)

        return stackView
    }
}


@available(iOS 17, *)
#Preview(traits: .defaultLayout, body: {
    DetailViewController()
})
