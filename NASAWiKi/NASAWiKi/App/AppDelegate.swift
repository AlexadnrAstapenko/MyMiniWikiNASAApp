//
//  AppDelegate.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 24.05.22.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        setupNavigationController()
        return true
    }

    func setupNavigationController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = getMainVC()
        navigationController.viewControllers = [vc]
        navigationController.setNavigationBarHidden(true, animated: false)
        self.window!.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func getMainVC() -> UIViewController {
        return UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() ?? UIViewController()
    }

}

