//
//  TablaDetallePedidoViewController.swift
//  LechuguitApp
//
//  Created by Alejandro Ruiz on 13/11/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

class TablaDetallePedidoTableView: UITableView{


     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetallePedidoCell", for: indexPath) as! DetallePedidoCell
        cell.nombreProducto.text = "Producto"
        
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class DetallePedidoCell: UITableViewCell{
    @IBOutlet weak var nombreProducto: UILabel!
    
}
