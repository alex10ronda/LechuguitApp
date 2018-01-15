//
//  Pedido.swift
//  LechuguitApp
//
//  Created by Alejandro Ruiz on 8/11/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation

class Pedido {
    
    var fecha: String
    var importe: Double
    var detalle: [ProductoPedido]
    
    //Para implementar las celdas colapsables
    var collapsed: Bool
    
    init(elemento: NSDictionary){
        
        self.fecha = elemento.value(forKey: "fecha") as! String
        self.importe = elemento.value(forKey: "importe") as! Double
        self.detalle = [ProductoPedido]()
        
        //Al crear el objeto pedido, se setea esta propiedad como true, porque por defecto la celda está
        // colapsada
        self.collapsed = true
        
        let detalleArray = elemento.value(forKey: "detalle") as! NSArray
        
        for detalle in detalleArray {
            
            let detalleJSON = detalle as! NSDictionary
            let producto = Producto.init(nombreProducto: detalleJSON.value(forKey: "producto") as! String)
            let cantidad = detalleJSON.value(forKey: "cantidad") as! Int
            let precio = detalleJSON.value(forKey: "precio") as! Double
            let productoPedido = ProductoPedido.init(producto: producto, cant: cantidad, precio: precio)
            self.detalle.append(productoPedido)
        }
    }
}
