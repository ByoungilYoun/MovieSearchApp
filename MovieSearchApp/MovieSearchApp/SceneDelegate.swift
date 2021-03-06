//
//  SceneDelegate.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let rootViewController = MovieSearchListViewController()
    let rootNaviController = UINavigationController(rootViewController: rootViewController)
    
    self.window = UIWindow(windowScene: windowScene)
    self.window?.rootViewController = rootNaviController
    self.window?.overrideUserInterfaceStyle = .light
    self.window?.makeKeyAndVisible()
    
  }
}

