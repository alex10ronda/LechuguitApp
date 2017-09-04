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
        
        static let url = "http://192.168.1.35:8080/LechuSpring"
        static let urlFindEstados = "/estado/get"
        static let urlFindAllFood = "/producto/findAllFood"
        static let urlSaveUser = "/cliente/add"
        static let urlFindDrinks = "/producto/findAllDrink"
        static let urlSavePedido = "/pedido/new"
        static let urlFindFoodByCarta = "/producto/findAllFoodByCarta"
    }
    
    struct cadenas {
        
        static let MSG_ERROR = "Ha ocurrido un error"
        static let MSG_REINTENTAR = "Inténtelo de nuevo"
        static let MSG_ERROR_CONEXION = "No se ha podido conectar con el servidor"
        static let MSG_PEDIR_BEBIDA = "No has pedido nada para beber"
        static let MSG_PEDIR_COMIDA = "No has pedido nada para comer"
        static let PEDIDO_OK_TITLE = "Se ha relizado su pedido correctamente"
        static let PEDIDO_OK_SUB = "Cuando esté listo le llamarán por su nombre"
        static let PEDIDO_ERROR = "No se pudo realizar el pedido"
        static let AVISO = "Aviso"
        static let IR_COMIDA = "Ir a Tapas"
        static let IR_BEBIDA = "Ir a Bebidas"
        static let PEDIR = "Pedir"
        
    }
    
    static let TP_COMIDA = "Comida"
    static let TP_BEBIDA = "Bebida"
    
}
