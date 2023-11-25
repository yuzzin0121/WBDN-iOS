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

        window.rootViewController = LoginViewController()
        window.makeKeyAndVisible()

        Self.navigationController.navigationBar.topItem?.title = ""
    }
}
