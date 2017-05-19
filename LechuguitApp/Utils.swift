//
//  Utils.swift
//  LechuguitApp
//
//  Created by bbva on 28/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation
import UIKit



struct Utils {
    static func saveDataPreferences(){
        let preferences = UserDefaults.standard
        preferences.set(Session.user?.name, forKey: "name")
        preferences.set(Session.user?.lastName, forKey: "lastName")
        preferences.set(Session.user?.idUser, forKey: "id")
        preferences.set(Session.user?.picture, forKey: "picture")
    }
    
    static func getDataPreferences(){
        var preferences = UserDefaults.standard
        let name = preferences.object(forKey: "name") as! String
        let lastName = preferences.object(forKey: "lastName") as! String
        let id = preferences.object(forKey: "id") as! String
        let picture = preferences.object(forKey: "picture") as! String
        Session.user = User(name: name, lastName: lastName, picture: picture, idUser: id)
        try? Session.profileImg = UIImage(data: NSData(contentsOf: NSURL(string: (Session.user?.picture)!) as! URL) as Data)
        
    }
    
    static func getStringCount() -> String{
        if(Session.productCount == 0){
            return ""
        }else{
            return (Session.productCount).description
        }
    }
    
    
}
