//
//  UIStoryboardExtensions.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 9.06.22.
//

import UIKit

extension UIStoryboard {
    
    convenience init(storyboard: StoryboardNames, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
}
