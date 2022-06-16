//
//  StoryboardNames.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 9.06.22.
//

import UIKit

enum StoryboardNames: String {
    
    case login = "Login"
    case photo = "PhotoOfDay"
    case main = "MainPage"
    case aboutApp = "AboutApp"
    
    var filename: String {
        return rawValue
    }
}
