//
//  Users.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 24.05.22.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email ?? ""
    }
    
}
