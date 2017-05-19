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
    var countBadge: MIBadgeButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        productoPresenter = ProductoPresenter()
        
        countBadge = MIBadgeButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        countBadge.setImage(UIImage(named: "ic_plane"), for: UIControlState.normal)
        
        countBadge.badgeString = Utils.getStringCount()
        countBadge.badgeEdgeInsets=UIEdgeInsets.init(top:12, left: 0, bottom: 0, right: 10)
        
        var barbutton: UIBarButtonItem = UIBarButtonItem(customView: countBadge)
        
        self.navigationItem.rightBarButtonItem = barbutton

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
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
        
        let more = UITableViewRowAction(style: .default, title: "Detalle") { (action, indexPath) in
            
        }
        
        more.backgroundColor = UIColor.blue
        
        return [more]
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            tableView.deselectRow(at: indexPath, animated: true)
            let alertStepper = StepperAlertViewController(title: "Indique la cantidad", message: "\n\n\n", preferredStyle: .alert)
            present(alertStepper, animated: true, completion: nil)
    }
    
   

    
    
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
