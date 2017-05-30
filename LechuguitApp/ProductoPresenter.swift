//
//  ProductoPresenter.swift
//  LechuguitApp
//
//  Created by bbva on 19/5/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation

class ProductoPresenter:NSObject {
    
    var arrayComida = [Producto]()
    var arrayComida25 = [Producto]()
    var arrayComida5 = [Producto]()
    var arrayBebida = [Producto]()
    
    override init() {
        self.arrayComida = Session.arrayComida
        self.arrayComida25 = Session.arrayComida25
        self.arrayComida5 = Session.arrayComida5
        self.arrayBebida = Session.arrayBebidas
    }
    
    func getCount() -> Int{
        return self.arrayComida.count
    }
    
    func getCount25() -> Int{
        return self.arrayComida25.count
    }
    
    func getCount5() -> Int{
        return self.arrayComida5.count
    }
    
    func getCountBebida() -> Int{
        return self.arrayBebida.count
    }
    
    func getComida(pos: Int) -> Producto{
        return arrayComida[pos]
    }
    
    func getComida25(pos: Int) -> Producto{
        return arrayComida25[pos]
    }

    
    func getComida5(pos: Int) -> Producto{
        return arrayComida5[pos]
    }
    
    func getBebida(pos: Int) -> Producto{
        return arrayBebida[pos]
    }


}
