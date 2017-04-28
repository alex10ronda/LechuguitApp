//
//  User.swift
//  LechuguitApp
//
//  Created by bbva on 28/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation


class User: NSObject {
    
    let name: String
    let lastName: String
    let picture: String
    let idUser: String
    
    init(name: String, lastName: String, picture: String, idUser:String) {
        
        self.name = name
        self.lastName = lastName
        self.idUser = idUser
        self.picture = picture
        
    }
  
    
    
}
