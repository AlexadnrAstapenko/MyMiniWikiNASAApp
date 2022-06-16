//
//  AboutApp.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 14.06.22.
//

import Foundation
import UIKit

class AboutApp: UIViewController {
    
    @IBOutlet weak var aboutTextTView: UITextView!
    
    @IBAction func backBtn(_: Any) {
        selectVC(vc: MainPageVC(), storyboard: .main)
    }
}
