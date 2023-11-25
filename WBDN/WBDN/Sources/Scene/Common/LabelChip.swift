//
//  LabelChip.swift
//  WBDN
//
//  Created by Mason Kim on 11/26/23.
//

import UIKit
import SnapKit

class CapsuleView: UIView {

    var oldFrame: CGRect = .zero

    override func layoutSubviews() {
        super.layoutSubviews()

        if oldFrame != frame {
            configureCornerRadius()
            oldFrame = frame
        }
    }

    private func configureCornerRadius() {
        layer.cornerRadius = frame.height / 2
    }
}


class LabelChip: CapsuleView {

    // MARK: - Constants

    enum Metric {
        static let defaultVerticalPadding: CGFloat = 8
        static let defaultHorizontalPadding: CGFloat = 12

        static let defaultTitleFontSize: CGFloat = 12
    }


    // MARK: - Properties

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    public var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor

            if isBackgroundSynced {
                backgroundColor = titleColor?.withAlphaComponent(0.2)
            }
        }
    }
    public var titleFontSize = Metric.defaultTitleFontSize {
        didSet {
            titleLabel.font = .pretendard(size: titleFontSize, weight: .bold)
        }
    }
    public var verticalPadding = Metric.defaultVerticalPadding {
        didSet {
            updateTitleLabelLayout()
        }
    }
    public var horizontalPadding = Metric.defaultHorizontalPadding {
        didSet {
            updateTitleLabelLayout()
        }
    }
    /// titleColor 가 정해지면 0.2 opaque 된 컬러로 배경 색상 지정해주는 옵션
    public var isBackgroundSynced = true

    override var intrinsicContentSize: CGSize {
        return .init(
            width: titleLabel.intrinsicContentSize.width + horizontalPadding * 2,
            height: titleLabel.intrinsicContentSize.height + verticalPadding * 2)
    }


    // MARK: - UI

    public var titleLabel = UILabel().then {
        $0.font = .pretendard(size: Metric.defaultTitleFontSize, weight: .bold)
        $0.textAlignment = .center
    }


    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Privates

    private func setup() {
        setupLayout()
    }

    private func setupLayout() {
        setupTitleLabelLayout()
    }

    private func setupTitleLabelLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(horizontalPadding)
            $0.top.bottom.equalToSuperview().inset(verticalPadding)
        }
    }

    private func updateTitleLabelLayout() {
        titleLabel.snp.updateConstraints {
            $0.leading.trailing.equalToSuperview().inset(horizontalPadding)
            $0.top.bottom.equalToSuperview().inset(verticalPadding)
        }
    }
}
