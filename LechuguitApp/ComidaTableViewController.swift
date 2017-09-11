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
        
        var barbutton: UIBarButtonItem = UIBarButtonItem(customView: Session.countBadge)
        
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
            
            let detalleProducto = UIStoryboard.detalleProductoViewController()
            if(indexPath.section == 0){
                detalleProducto.producto = self.productoPresenter?.getComida(pos: indexPath.row)
            }else if(indexPath.section == 1){
                 detalleProducto.producto = self.productoPresenter?.getComida25(pos: indexPath.row)
            }else {
                 detalleProducto.producto = self.productoPresenter?.getComida5(pos: indexPath.row)
            }
            self.navigationController?.pushViewController(detalleProducto, animated: true)
            
        }
        
        more.backgroundColor = UIColor.blue
        
        return [more]
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            tableView.deselectRow(at: indexPath, animated: true)
            let alertStepper = StepperAlertViewController(title: "Indique la cantidad", message: "\n\n\n", preferredStyle: .alert)
            if(indexPath.section == 0){
                alertStepper.producto = productoPresenter?.getComida(pos: indexPath.row)
            }else if(indexPath.section == 1){
                 alertStepper.producto = productoPresenter?.getComida25(pos: indexPath.row)
            }else{
                 alertStepper.producto = productoPresenter?.getComida5(pos: indexPath.row)
            }
            alertStepper.isComida = true
            present(alertStepper, animated: true, completion: nil)
    }
    
   

    
    
    // MARK: - Navigation
    //Botón para mostrar el menú lateral
    @IBAction func btnMenuClicked(_ sender: Any) {
         delegate?.togglePanel!()
    }
}

//Clase Celda Producto
class ProductoCell: UITableViewCell{
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    
    //Configura la celda de comida...
    //Setea el nombre y decodifica la imagen de base64
    func configureCell(producto:Producto){
        if(producto.imgProducto != nil){
            if let decodedData = Data(base64Encoded: producto.imgProducto!, options: .ignoreUnknownCharacters) {
                productImg.image = UIImage(data: decodedData)
            }
        }else{
            productImg.image = UIImage(named: "noImg")
        }
        
        productName.text = producto.nombreProducto
    }
}
