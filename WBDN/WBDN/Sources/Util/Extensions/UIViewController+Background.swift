//
//  UIViewController+Background.swift
//  WBDN
//
//  Created by Mason Kim on 11/25/23.
//

import UIKit

extension UIViewController {
    func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds

        // TODO: 색상 변경
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0.0, 1.0]

        // 그레디언트 방향 설정 (위에서 아래로)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        // 뷰의 배경으로 그레디언트 레이어 추가
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
