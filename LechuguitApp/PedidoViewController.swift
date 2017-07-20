//
//  PedidoViewController.swift
//  LechuguitApp
//
//  Created by Alejandro Ruiz on 1/6/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

class PedidoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicator: UIActivityIndicatorView?
    
    var pedidoAmostrar = [ProductoPedido]()
    
    var pedidoComida = [ProductoPedido]()
    var pedidoBebida = [ProductoPedido]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pedidoComida = ProductoPedido.getPedidoComida()
        pedidoBebida = ProductoPedido.getPedidoBebida()
        
        tableView.delegate = self
        tableView.dataSource = self
        if(pedidoComida.count > 0){
            pedidoAmostrar = pedidoComida
        }else{
            pedidoAmostrar = pedidoBebida
            segmentControl.selectedSegmentIndex = 1
        }
        
        lblPrecio.text = Session.pedidoPrice.description + " €"
        
        tableView.layer.masksToBounds = true
        tableView.layer.borderWidth = 0.5
        tableView.layer.cornerRadius = tableView.frame.height / 16.0
        tableView.layer.borderColor = UIColor.blue.cgColor
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator?.color = UIColor.black
        activityIndicator?.center = self.view.center
        self.view.addSubview(activityIndicator!)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidoAmostrar.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PedidoCell") as! PedidoViewCell
        cell.nombreProducto.text = (pedidoAmostrar[indexPath.row].producto ).nombreProducto
        cell.productCant.text = (pedidoAmostrar[indexPath.row].cantidad).description
        cell.productCant.delegate = self
        
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let cell = textField.superview?.superview as! PedidoViewCell
        let arrayIndex = Session.pedido.index(where: {$0.producto.nombreProducto == cell.nombreProducto.text})
        let newCant = Int(textField.text!)
        if(segmentControl.selectedSegmentIndex == 0) {
             let arrayIndexComida = pedidoComida.index(where: {$0.producto.nombreProducto == cell.nombreProducto.text})
            if(newCant == 0){
                Session.pedido.remove(at: arrayIndex!)
                pedidoComida.remove(at: arrayIndexComida!)
            }else{
                Session.pedido[arrayIndex!].cantidad = newCant!
                pedidoComida[arrayIndexComida!].cantidad = newCant!
            }
        }else{
            let arrayIndexBebida = pedidoBebida.index(where: {$0.producto.nombreProducto == cell.nombreProducto.text})
            if(newCant == 0){
                Session.pedido.remove(at: arrayIndex!)
                pedidoBebida.remove(at: arrayIndexBebida!)
            }else{
                Session.pedido[arrayIndex!].cantidad = newCant!
                pedidoBebida[arrayIndexBebida!].cantidad = newCant!
            }
        }
        
               
        //Recalcula el importe del pedido
        Session.pedidoPrice = Utils.getPedidoPrice()
        self.lblPrecio.text = Session.pedidoPrice.description + " €"
        
        self.view.endEditing(true)
        return false
    }
    
    
    
    @IBAction func segmentSelected(_ sender: Any) {
        
        if(segmentControl.selectedSegmentIndex == 0){
            pedidoAmostrar = pedidoComida
            self.tableView.reloadData()
        }else if(segmentControl.selectedSegmentIndex == 1){
            self.pedidoAmostrar = pedidoBebida
            self.tableView.reloadData()
        }
    }
    
    @IBAction func btnPedir(_ sender: Any) {
        
        self.activityIndicator?.startAnimating()
        
        //let json = ProductoPedido.pedidoToJSON(comidas: Session.pedidoComida , bebidas: Session.pedidoBebida)
        let json = ProductoPedido.pedidoToJSON(productos: Session.pedido)
        PedidoNetwork.sharedInstance.savePedido(pedidoJSON: json, completionHandler: { 
            print("Exito")
            self.activityIndicator?.stopAnimating()
            self.showAlert(exito: true)
            
        }) {
            print("Fallo")
            self.activityIndicator?.stopAnimating()
            self.showAlert(exito: false)
        }
    }
    
    func showAlert(exito: Bool){
        
        let alert: UIAlertController
        if(exito) {
            alert = UIAlertController(title: Constants.cadenas.PEDIDO_OK_TITLE, message: Constants.cadenas.PEDIDO_OK_SUB, preferredStyle: .alert)
            let goMain = UIAlertAction(title: "Ir a la pantalla principal", style: .default, handler: { (action) in
                self.goMainView()
            })
            alert.addAction(goMain)
            
            
        } else {
            alert = UIAlertController(title: Constants.cadenas.PEDIDO_ERROR, message: Constants.cadenas.MSG_REINTENTAR, preferredStyle: .alert)
            let reint = UIAlertAction(title: "Reintentar", style: .default, handler: nil)
            alert.addAction(reint)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func goMainView(){
        let mainController = navigationController?.viewControllers[0]
        Session.productCount = 0
        //Session.pedidoComida = [ProductoPedido]()
        //Session.pedidoBebida = [ProductoPedido]()
        Session.pedido = [ProductoPedido]()
        Session.countBadge.badgeString = ""
        
        Session.FLAG_BEBIDA = 0
        Session.FLAG_COMIDA = 0
        self.navigationController?.popToViewController(mainController!, animated: true)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.pedidoAmostrar.remove(at: indexPath.row)
            let cell = tableView.cellForRow(at: indexPath) as! PedidoViewCell
            let arrayIndex = Session.pedido.index(where: {$0.producto.nombreProducto == cell.nombreProducto.text})
            Session.pedido.remove(at: arrayIndex!)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            if(segmentControl.selectedSegmentIndex == 0) {
                let arrayIndex = pedidoComida.index(where: {$0.producto.nombreProducto == cell.nombreProducto.text})
                pedidoComida.remove(at: arrayIndex!)
            }else{
                let arrayIndex = pedidoBebida.index(where: {$0.producto.nombreProducto == cell.nombreProducto.text})
                pedidoBebida.remove(at: arrayIndex!)
            }
            
            //Recalcula el importe del pedido
            Session.pedidoPrice = Utils.getPedidoPrice()
            self.lblPrecio.text = Session.pedidoPrice.description + " €"
        }
    }
    
}

class PedidoViewCell: UITableViewCell {
    
    @IBOutlet weak var nombreProducto: UILabel!
    @IBOutlet weak var productCant: UITextField!
    
    
    
}
