//
//  AboutApp.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 14.06.22.
//

import Foundation
import UIKit

class AboutApp: UIViewController, UITextViewDelegate {
    // MARK: Internal

    @IBOutlet var aboutTextTView: UITextView!
    
    var URL = "https://api.nasa.gov"

    var aboutApp = "This application was created to study photographs from NASA. It uses a trial version of the NASA API to view information and photos from space and beyond. The interface of the application itself and additional information will be presented below. This information was taken from here"
    
    override func viewDidLoad() {
        setUpUI()
        aboutTextTView.delegate = self
    }

    func textView(_: UITextView, shouldInteractWith URL: URL, in _: NSRange, interaction _: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }

    @IBAction func backBtn(_: Any) {
        selectVC(vc: MainPageVC(), storyboard: .main)
    }

    // MARK: Private

    private func setUpUI() {
        let attributedString = NSMutableAttributedString(string: aboutApp)
        attributedString.addAttribute(.link,
                                      value: "https://api.nasa.gov",
                                      range: NSRange(location: 278, length: 5))
        aboutTextTView.attributedText = attributedString
        aboutTextTView.font = UIFont(name: "Helvetica Oblique", size: 27)
    }
}
