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
    
    init(idProducto: Int, nombreProducto: String, imgProducto:String?, precio:Double) {
        
        self.idProducto = idProducto
        self.nombreProducto = nombreProducto
        self.imgProducto = imgProducto
        self.precio = precio
    }
    
}
