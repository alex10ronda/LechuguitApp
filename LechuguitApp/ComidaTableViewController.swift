//
//  ComidaTableViewController.swift
//  LechuguitApp
//
//  Created by bbva on 18/5/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

class ComidaTableViewController: UITableViewController {
    
    var delegate: MainControllerDelegate?
    var productoPresenter: ProductoPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        productoPresenter = ProductoPresenter()
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if(section == 0){
            return (productoPresenter?.getCount())!
        }else if(section == 1){
            return (productoPresenter?.getCount25())!
        }else{
            return (productoPresenter?.getCount5())!
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoCell
        
        if(indexPath.section == 0){
            cell.configureCell(producto: (self.productoPresenter?.getComida(pos: indexPath.row))!)
        }else if(indexPath.section == 1){
            cell.configureCell(producto: (self.productoPresenter?.getComida25(pos: indexPath.row))!)
        }else{
            cell.configureCell(producto: (self.productoPresenter?.getComida5(pos: indexPath.row))!)
        }

        //cell.configureCell(producto: (self.productoPresenter?.getComida(pos: indexPath.row))!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Tapas a 0.80 €"
        }else if(section == 1){
            return "Tapas a 2.50 €"
        }else{
            return "Platos a 5 €"
        }
    }
    
    
   

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var more = UITableViewRowAction(style: .default, title: "Detalle") { (action, indexPath) in
            
        }
        
        more.backgroundColor = UIColor.blue
        
        return [more]
        
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    @IBAction func btnMenuClicked(_ sender: Any) {
        delegate?.togglePanel!()
    }
}

class ProductoCell: UITableViewCell{
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    func configureCell(producto:Producto){
        if(producto.imgProducto != nil){
            productImg.image = UIImage(named: producto.imgProducto!)
        }
        
        productName.text = producto.nombreProducto
    }
}
