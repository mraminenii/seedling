//
//  login.swift
//  Seedling
//
//  Created by Wai Shuen Wu on 12/6/22.
//

import Foundation
import FirebaseAuth
import Firebase
import SwiftUI

class loginManager {
        
    init() {
        
    }
    
    func signUp(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                       print(user)
                        completionBlock(true)
                    } else {
                        print("Error")
                        completionBlock(false)
                        }
                }
    }
    
    func signIn(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                completionBlock(false)
            } else {
               completionBlock(true)
            }
        }
    }
}
