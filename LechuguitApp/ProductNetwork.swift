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
    
    func getAllProducts(/*completionHandler: @escaping ([Producto]) -> Void, errorHandler: @escaping (Void) -> Void*/) {
        
        Alamofire.request(Constants.endPoints.url + Constants.endPoints.urlFindAllProductos).responseJSON { response in
            
            if(response.result.isSuccess){
                
                let resultadoJSON = response.result.value as! NSArray
                var arrayProductos = [Producto]()
                for index in resultadoJSON{
                    let element = index as! NSDictionary
                    let nombre = element.value(forKey: "nombre") as! String
                    let precio = element.value(forKey: "precio") as! Double
                    let id = element.value(forKey: "id") as! Int
                    let img = element.value(forKey: "img") as? String
                    
                    let producto = Producto(idProducto: id, nombreProducto: nombre, imgProducto: img, precio: precio)
                    arrayProductos.append(producto)
                }
            }
        }
        
    }
    
}
