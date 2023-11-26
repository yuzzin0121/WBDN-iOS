//
//  SceneDelegate.swift
//  WBDN
//
//  Created by Mason Kim on 11/25/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties

    var window: UIWindow?
    static let navigationController = UINavigationController(rootViewController: MainTabController())

    // MARK: - LifeCycle

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        window.rootViewController = Self.navigationController
        window.makeKeyAndVisible()
        Self.navigationController.navigationBar.topItem?.title = ""
        Self.navigationController.navigationBar.tintColor = .white

        guard let firstVC = Self.navigationController.viewControllers.first else  { return }
        let presentVC = LoginViewController()
        presentVC.modalPresentationStyle = .fullScreen
        firstVC.present(presentVC, animated: false)
//        Self.navigationController.pushViewController(LoginViewController(), animated: false)
        


    }
}
