//
//  OptionsPresenter.swift
//  LechuguitApp
//
//  Created by bbva on 26/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import Foundation


class OptionsPresenter {
    
    var optionsArray:[Option]
    
    init() {
        optionsArray = [Option]()
        optionsArray.append(Option.init(name: "Tapas", img: ""))
        optionsArray.append(Option.init(name: "Bebidas", img: ""))
        optionsArray.append(Option.init(name: "Pedidos", img: ""))
        optionsArray.append(Option.init(name: "Salir", img: ""))
    }
    
    func getCount() -> Int {
        return self.optionsArray.count
    }
    
    func getOptionAt(index: Int) -> Option {
        return self.optionsArray[index]
    }
    
}






struct Option {
    
    let nameOption: String
    let imgOption: String
    
    init(name:String, img:String) {
        self.nameOption = name
        self.imgOption = img
    }
}
