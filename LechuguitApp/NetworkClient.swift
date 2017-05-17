//
//  NetworkClient.swift
//  LechuguitApp
//
//  Created by bbva on 17/5/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation
import Alamofire

class NetworkClient: NSObject {
    
    
    static let sharedInstance: NetworkClient = NetworkClient()
    
    func getAllEstados(){
        
        let url = Constants.endPoints.url + Constants.endPoints.urlFindEstados
        
        Alamofire.request(url).responseJSON { response in
            
            if(response.result.isSuccess){}
        }
        
    }
   
}
