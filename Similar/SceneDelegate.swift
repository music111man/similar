//
//  SceneDelegate.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = SimilarVC()
        window?.makeKeyAndVisible()
    }

}

