//
//  PedidoViewController.swift
//  LechuguitApp
//
//  Created by Alejandro Ruiz on 1/6/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

class PedidoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicator: UIActivityIndicatorView?
    
    var pedidoAmostrar = [ProductoPedido]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        if(Session.pedidoComida.count > 0){
            pedidoAmostrar = Session.pedidoComida
        }else{
            pedidoAmostrar = Session.pedidoBebida
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
        cell.cant.text = (pedidoAmostrar[indexPath.row].cantidad).description
        
        return cell
    }
    
    @IBAction func segmentSelected(_ sender: Any) {
        
        if(segmentControl.selectedSegmentIndex == 0){
            pedidoAmostrar = Session.pedidoComida
            self.tableView.reloadData()
        }else if(segmentControl.selectedSegmentIndex == 1){
            self.pedidoAmostrar = Session.pedidoBebida
            self.tableView.reloadData()
        }
    }
    
    @IBAction func btnPedir(_ sender: Any) {
        
        self.activityIndicator?.startAnimating()
        
        let json = ProductoPedido.pedidoToJSON(comidas: Session.pedidoComida , bebidas: Session.pedidoBebida)
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
        Session.pedidoComida = [ProductoPedido]()
        Session.pedidoBebida = [ProductoPedido]()
        Session.pedido = [ProductoPedido]()
        Session.countBadge.badgeString = ""
        
        Session.FLAG_BEBIDA = 0
        Session.FLAG_COMIDA = 0
        self.navigationController?.popToViewController(mainController!, animated: true)

    }
    
}

class PedidoViewCell: UITableViewCell {
    
    @IBOutlet weak var nombreProducto: UILabel!
    @IBOutlet weak var cant: UILabel!
    
    
}
