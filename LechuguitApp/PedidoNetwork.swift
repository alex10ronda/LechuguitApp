//
//  NetworkClient.swift
//  LechuguitApp
//
//  Created by bbva on 17/5/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation
import Alamofire

class PedidoNetwork: NSObject {
    
    
    static let sharedInstance: PedidoNetwork = PedidoNetwork()
    
    func savePedido(pedidoJSON: [Dictionary<String, Int>], completionHandler: @escaping () -> (), errorHandler: @escaping () -> ()){
        
        var params = Dictionary<String,Any>()
        params.updateValue(Session.user?.idUser, forKey: "userId")
        params.updateValue(pedidoJSON, forKey: "pedido")
        
        Alamofire.request(Constants.endPoints.url + Constants.endPoints.urlSavePedido, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if(response.result.isSuccess){
                let respuesta = response.result.value as! Dictionary<String,Any>
                if(respuesta["isOK"] as! Bool == true){
                    Session.user?.total = respuesta["importe"] as! Double
                    completionHandler()
                }else{
                    errorHandler()
                }
            }else{
                errorHandler()
            }
        }
    }
    
    func getUltimosPedidos(completionHandler: @escaping ([Pedido]) -> (), errorHandler: @escaping () -> ()){
        
        
        Alamofire.request(Constants.endPoints.url + Constants.endPoints.urlLastPedidos + (Session.user?.idUser)!).responseJSON{ (response)
            in
            
            if(response.result.isSuccess){
                //print(response.result.value)
                
                let respuestaJSON = response.result.value as! NSArray
                var pedidos = [Pedido]()
                
                for elemento in respuestaJSON {
                    
                    let elementoJSON = elemento as! NSDictionary
                    pedidos.append(Pedido.init(elemento: elementoJSON))
                }
                
            
                completionHandler(pedidos)
            }else{
                errorHandler()
            }
        }
    }
}
