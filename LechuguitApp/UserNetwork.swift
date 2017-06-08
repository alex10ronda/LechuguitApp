//
//  UserNetwork.swift
//  LechuguitApp
//
//  Created by bbva on 29/5/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation
import Alamofire


class UserNetwork:NSObject {
    
    static let sharedInstance: UserNetwork = UserNetwork()
    
    func saveOrUpdate(user: User, completionHandler: @escaping (Void)-> Void, errorHandler: @escaping (Void) -> Void){
        
        let url = Constants.endPoints.url + Constants.endPoints.urlSaveUser
        let params = user.toJSON() 
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if(response.result.isSuccess){
                let respuesta = response.result.value as! NSDictionary
                let total = respuesta.value(forKey: "total") as! Double
                Session.user?.total = total
                
                completionHandler()
            }else{
                errorHandler()
            }
            
        
        }
        
    }
}
