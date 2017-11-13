//
//  File.swift
//  LechuguitApp
//
//  Created by Alejandro Ruiz on 13/11/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation

class PedidoPresenter {
    
    var arrayPedidos:[Pedido]
    
    init() {
        arrayPedidos = [Pedido]()
    }
    
    
    //Método que llama al PedidoNetwork para obtener los ultimos pedidos
    func getUltimosPedidos(completionHandler: @escaping () -> (), errorHandler: @escaping () -> ()){
        
        PedidoNetwork.sharedInstance.getUltimosPedidos(completionHandler: { (pedidos) in
            
            self.arrayPedidos = pedidos
            completionHandler()
        }) { 
            errorHandler()
        }
    }
    
    
    func getPedidoBy(index: Int) -> Pedido{
        return arrayPedidos[index]
    }
}
