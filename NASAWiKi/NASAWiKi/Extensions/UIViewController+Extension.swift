//
//  UIViewControllerExtension.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 9.06.22.
//

import UIKit

extension UIViewController {
    
    func selectVC(vc: UIViewController, storyboard: StoryboardNames) {
        if let destinationViewController = navigationController?.viewControllers.filter({$0 .isKind(of: vc.classForCoder)})
            .first{
            navigationController?.popToViewController(destinationViewController, animated: true)
        } else {
            let pushVC = UIStoryboard(storyboard: storyboard).instantiateInitialViewController() ?? UIViewController()
            navigationController?.pushViewController(pushVC, animated: true)
        }
    }
}
