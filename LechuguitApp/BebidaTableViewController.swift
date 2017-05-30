//
//  BebidaTableViewController.swift
//  LechuguitApp
//
//  Created by bbva on 19/5/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

class BebidaTableViewController: UITableViewController {
    
    var delegate: MainControllerDelegate?
    var bebidaPresenter: ProductoPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bebidaPresenter = ProductoPresenter()
        
        var barbutton: UIBarButtonItem = UIBarButtonItem(customView: Session.countBadge)
        
        self.navigationItem.rightBarButtonItem = barbutton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (bebidaPresenter?.getCountBebida())!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BebidaCell", for: indexPath) as! BebidaViewCell

        cell.configureCell(producto: (bebidaPresenter?.getBebida(pos: indexPath.row))!)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnMenuClicked(_ sender: Any) {
         delegate?.togglePanel!()
    }

}

class BebidaViewCell: UITableViewCell{
    
    @IBOutlet weak var precio: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    func configureCell(producto: Producto) {
        if(producto.imgProducto != nil){
            productImg.image = UIImage(named: producto.imgProducto!)
        }
        
        productName.text = producto.nombreProducto + "€"
        precio.text = (producto.precio).description
    }
}
