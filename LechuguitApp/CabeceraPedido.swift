//
//  CabeceraPedido.swift
//  LechuguitApp
//
//  Created by Alejandro Ruiz on 27/11/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

protocol CaberceraPedidoDelegate {
    func toggleSection(header: CabeceraPedido, section: Int)
}

class CabeceraPedido: UITableViewHeaderFooterView {

    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblImporte: UILabel!
    
    var delegate: CaberceraPedidoDelegate?
    var section: Int = 0
    
    
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector (self.tapHeader)))
    }
    
    func tapHeader(gestureRecognizer: UITapGestureRecognizer){
        guard let cell = gestureRecognizer.view as? CabeceraPedido else{
            return
        }
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func setCollapsed(collapsed:Bool){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector (self.tapHeader)))

    }

}
