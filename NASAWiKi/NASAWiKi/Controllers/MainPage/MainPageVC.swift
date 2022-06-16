//
//  MainPageVC.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 27.05.22.
//

import Alamofire
import UIKit

class MainPageVC: UIViewController {
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func forvardSpaceObserverBtn(_: UIButton) {
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "ShowCategoryTVC") as? ShowCategoryTVC else {
            return
        }
        navigationController?.pushViewController(secondVC, animated: true)
    }

    @IBAction func aboutBtn(_: Any) {
        selectVC(vc: AboutApp(), storyboard: .aboutApp)
    }

    func setUpUI() {
        SetUpAnimation.addAnimations("earth2", imageView)
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        selectVC(vc: LoginViewController(), storyboard: .login)
    }
}
