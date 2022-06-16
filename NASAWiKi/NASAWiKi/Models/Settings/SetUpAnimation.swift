//
//  SetUpAnimation.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 29.05.22.
//

import Foundation
import UIKit

class SetUpAnimation {
    
    static func addAnimations(_ nameAnimation: String, _ image: UIImageView) {
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: nameAnimation , withExtension: "gif")!)
        let advTimeGif = UIImage.gifImageWithData(imageData!)
        image.image = advTimeGif
    }
}
