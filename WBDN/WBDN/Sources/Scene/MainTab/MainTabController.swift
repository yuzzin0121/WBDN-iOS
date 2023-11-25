//
//  MainTabController.swift
//  WBDN
//
//  Created by Mason Kim on 11/25/23.
//

import UIKit

// TODO: 탭바 디자인을 위해 커스텀 뷰로 변경

final class MainTabController: UITabBarController {

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 110
        tabBar.frame.origin.y = view.frame.height - 90  
    }

    // MARK: - Setup

    private func setupTabBar() {
        setupTabBarRadius()
        setupTabBarShadow()
        configureViewControllers()
    }

    private func setupTabBarRadius() {
        tabBar.tintColor = .blue
        tabBar.backgroundColor = .brown
        tabBar.layer.cornerRadius = tabBar.frame.height * 0.8
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func setupTabBarShadow() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .white, alpha: 0.3, x: 0, y: 0, blur: 12)
    }

    private func configureViewControllers() {
        let homeNavigation = navigationController(
            image: UIImage(named: "home"),
            viewController: HomeViewController()
        )

        let mapNavigation = navigationController(
            image: UIImage(named: "map"),
            viewController: MapViewController()
        )

        let userNavigation = navigationController(
            image: UIImage(named: "user"),
            viewController: UserViewController()
        )

        viewControllers = [homeNavigation, mapNavigation, userNavigation]
    }

    private func navigationController(
        image: UIImage?,
        viewController: UIViewController
    ) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.tintColor = .brown // TODO: 색상 변경
        return navigationController
    }
}

#Preview {
    MainTabController()
}

extension CALayer {
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}

extension UITabBar {
    // 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있다.
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
