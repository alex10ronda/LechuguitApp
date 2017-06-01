//
//  Constants.swift
//  LechuguitApp
//
//  Created by bbva on 27/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    static let colorAlbero = UIColor(red: 255/255, green: 225/255, blue: 0/255, alpha: 1.0)
    
    struct endPoints {
        
        static let url = "http://192.168.1.34:8080/LechuSpring"
        static let urlFindEstados = "/estado/get"
        static let urlFindAllFood = "/producto/findAllFood"
        static let urlSaveUser = "/cliente/add"
        static let urlFindDrinks = "/producto/findAllDrink"
    }
    
    struct cadenas {
        
        static let MSG_ERROR = "Ha ocurrido un error"
        static let MSG_REINTENTAR = "Inténtelo de nuevo"
        static let MSG_ERROR_CONEXION = "No se ha podido conectar con el servidor"
        static let MSG_PEDIR_BEBIDA = "No has pedido nada para beber"
        static let MSG_PEDIR_COMIDA = "No has pedido nada para comer"
        
    }
    
}
