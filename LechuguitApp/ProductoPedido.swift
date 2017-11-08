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
    var precio: Double?
    
    init(producto: Producto, cant: Int) {
        self.producto = producto
        self.cantidad = cant
    }
    
    init(producto: Producto, cant: Int, precio: Double) {
        self.producto = producto
        self.cantidad = cant
        self.precio = precio
    }
    
    static func pedidoToJSON(comidas: [ProductoPedido], bebidas: [ProductoPedido]) -> [Dictionary<String, Int>] {
        
        var pedido = [Dictionary<String, Int>]()
        var componente = Dictionary<String, Int>()
        
        for comida in comidas{
            componente.updateValue(comida.producto.idProducto!, forKey: "id")
            componente.updateValue(comida.cantidad , forKey: "cant")
            pedido.append(componente)
        }
        
        for bebida in bebidas {
            componente.updateValue(bebida.producto.idProducto!, forKey: "id")
            componente.updateValue(bebida.cantidad, forKey: "cant")
            pedido.append(componente)
        }
        return pedido
    }
    
    static func pedidoToJSON(productos: [ProductoPedido]) -> [Dictionary<String, Int>] {
        
        var pedido = [Dictionary<String, Int>]()
        var componente = Dictionary<String, Int>()
        
        for producto in productos{
            componente.updateValue(producto.producto.idProducto!, forKey: "id")
            componente.updateValue(producto.cantidad , forKey: "cant")
            pedido.append(componente)
        }
        
        return pedido
    }
    
    static func getPedidoComida() -> [ProductoPedido] {
        var comida = [ProductoPedido]()
        
        for p in Session.pedido {
            if(p.producto.tipo == Constants.TP_COMIDA){
                comida.append(p)
            }
        }
        return comida
    }
    
    
    static func getPedidoBebida() -> [ProductoPedido] {
        var bebida = [ProductoPedido]()
        
        for p in Session.pedido {
            if(p.producto.tipo == Constants.TP_BEBIDA){
                bebida.append(p)
            }
        }
        return bebida
    }

    
   
}
