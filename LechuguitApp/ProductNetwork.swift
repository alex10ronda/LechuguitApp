//
//  ProductNetwork.swift
//  LechuguitApp
//
//  Created by bbva on 18/5/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation
import Alamofire

class ProductNetwork: NSObject {
    
    
    static let sharedInstance: ProductNetwork = ProductNetwork()
    
    func getAllProducts(completionHandler: @escaping ([Producto]) -> Void/*, errorHandler: @escaping (Void) -> Void*/) {
        
        Alamofire.request(Constants.endPoints.url + Constants.endPoints.urlFindAllFood).responseJSON { response in
            
            if(response.result.isSuccess){
                
                let resultadoJSON = response.result.value as! NSArray
                var arrayProductos = [Producto]()
                for index in resultadoJSON{
                    let element = index as! NSDictionary
                    let producto = Producto.getProductFromJson(element: element)
                    arrayProductos.append(producto)
                }
                
                completionHandler(arrayProductos)
                
            }
        }
        
    }
    
}
