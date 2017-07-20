//
//  Producto.swift
//  LechuguitApp
//
//  Created by bbva on 18/5/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation


class Producto:NSObject {
    
    var idProducto: Int
    var nombreProducto: String
    var imgProducto: String?
    var precio: Double
    var tipo: String
    
    init(idProducto: Int, nombreProducto: String, imgProducto:String?, precio:Double, tipo: String) {
        
        self.idProducto = idProducto
        self.nombreProducto = nombreProducto
        self.imgProducto = imgProducto
        self.precio = precio
        self.tipo = tipo
    }
    
    static func getProductFromJson(element: NSDictionary) -> Producto{
        let nombre = element.value(forKey: "nombre") as! String
        let precio = element.value(forKey: "precio") as! Double
        let id = element.value(forKey: "id") as! Int
        let img = element.value(forKey: "img") as? String
        let tipo = element.value(forKey: "tpProducto") as! String
        
        let producto = Producto(idProducto: id, nombreProducto: nombre, imgProducto: img, precio: precio, tipo: tipo)
        
        return producto
    }
    
}
