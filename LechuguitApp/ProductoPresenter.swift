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
    
    override init() {
        self.arrayComida = Session.arrayComida
    }
    
    func getCount() -> Int{
        
        return self.arrayComida.count
        
    }
}
