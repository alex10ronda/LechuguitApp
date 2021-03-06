//
//  Session.swift
//  LechuguitApp
//
//  Created by bbva on 28/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation
import UIKit


class Session {
    
    static var user :User?
    
    static var profileImg: UIImage?
    
    static var arrayComida = [Producto]()
    
    static var arrayComida25 = [Producto]()
    
    static var arrayComida5 = [Producto]()
    
    static var productCount = 0
    
    static var countBadge = MIBadgeButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
    
    static var pedido = [ProductoPedido]()
    
    //static var pedidoComida = [ProductoPedido]()
    
    //static var pedidoBebida = [ProductoPedido]()
    
    static var arrayBebidas = [Producto]()
    
    static var FLAG_COMIDA = 0
    
    static var FLAG_BEBIDA = 0
    
    static var pedidoPrice = 0.0
    
    
}
