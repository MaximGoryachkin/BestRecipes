//
//  SceneDelegate.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 27.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let rootVC = OnboardingHomeViewController()
        self.window = window
        
        if UserDefaults.standard.bool(forKey: "OnboardingWasViewed") {
            window.rootViewController = HomeViewController()
        } else {
            window.rootViewController = rootVC
        }
        window.makeKeyAndVisible()
    }
}

