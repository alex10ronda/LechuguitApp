//
//  ProductoPedido.swift
//  LechuguitApp
//
//  Created by bbva on 29/5/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation

class ProductoPedido{
    
    var producto: Producto
    var cantidad: Int
    
    init(producto: Producto, cant: Int) {
        self.producto = producto
        self.cantidad = cant
    }
    
   
}
