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
    
    func getAllProducts(completionHandler: @escaping ([Producto], [Producto], [Producto]) -> Void, errorHandler: @escaping (Void) -> Void) {
        
        Alamofire.request(Constants.endPoints.url + Constants.endPoints.urlFindAllFood).responseJSON { response in
            
            if(response.result.isSuccess){
                
                let resultadoJSON = response.result.value as! NSArray
                var arrayComida = [Producto]()
                var arrayComida25 = [Producto]()
                var arrayComida5 = [Producto]()
                for index in resultadoJSON{
                    let element = index as! NSDictionary
                    let producto = Producto.getProductFromJson(element: element)
                    if(producto.precio == 0.8){
                         arrayComida.append(producto)
                    }else if(producto.precio == 2.5){
                        arrayComida25.append(producto)
                    }else if(producto.precio == 5){
                        arrayComida5.append(producto)
                    }
                }
                
                completionHandler(arrayComida, arrayComida25, arrayComida5)
                
            }else if(response.result.isFailure){
                errorHandler()
            }
        }
        
    }
    
    
    func getDrinks(completionHandler: @escaping ([Producto]) -> Void, errorHandler: @escaping (Void) -> Void){
        
        Alamofire.request(Constants.endPoints.url + Constants.endPoints.urlFindDrinks).responseJSON { (response) in
            
            if(response.result.isSuccess){
                
                var arrayBebidas = [Producto]()
                let resultadoJSON = response.result.value as! NSArray
                for index in resultadoJSON {
                    
                    let element = index as! NSDictionary
                    let producto = Producto.getProductFromJson(element: element)
                    arrayBebidas.append(producto)
                }
                completionHandler(arrayBebidas)
            }else{
                errorHandler()
            }
        }
    }
    
}
