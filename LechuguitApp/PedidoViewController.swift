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
    var pedidoAmostrar = [ProductoPedido]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        pedidoAmostrar = Session.pedidoComida
        lblPrecio.text = Session.pedidoPrice.description + " €"
        
        tableView.layer.masksToBounds = true
        tableView.layer.borderWidth = 0.5
        tableView.layer.cornerRadius = tableView.frame.height / 16.0
        tableView.layer.borderColor = UIColor.blue.cgColor
        

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
        
        let json = pedidoToJSON(comidas: Session.pedidoComida , bebidas: Session.pedidoBebida)        
        print(json)
    }
    
    func pedidoToJSON(comidas: [ProductoPedido], bebidas: [ProductoPedido]) -> [Dictionary<String, Int>] {
        
        var pedido = [Dictionary<String, Int>]()
        var componente = Dictionary<String, Int>()
        
        for comida in comidas{
            componente.updateValue(comida.producto.idProducto, forKey: "id")
            componente.updateValue(comida.cantidad , forKey: "cantidad")
            pedido.append(componente)
        }
        
        for bebida in bebidas {
            componente.updateValue(bebida.producto.idProducto, forKey: "id")
            componente.updateValue(bebida.cantidad, forKey: "cantidad")
            pedido.append(componente)
        }
        return pedido
    }
}

class PedidoViewCell: UITableViewCell {
    
    @IBOutlet weak var nombreProducto: UILabel!
    @IBOutlet weak var cant: UILabel!
    
    
}
