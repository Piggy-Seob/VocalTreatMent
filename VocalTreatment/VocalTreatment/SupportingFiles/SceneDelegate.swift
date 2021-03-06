//
//  SceneDelegate.swift
//  VocalTreatment
//
//  Created by 박진섭 on 2022/07/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)
        self.window = window

		let viewController = HomeViewController()
		let navigationController = UINavigationController(rootViewController: viewController)

		navigationController.viewControllers = [viewController, PhonationTimeViewController()]

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

