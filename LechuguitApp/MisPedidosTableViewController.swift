//
//  MisPedidosTableViewController.swift
//  LechuguitApp
//
//  Created by Alejandro Ruiz on 22/6/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

class MisPedidosTableViewController: UITableViewController, CaberceraPedidoDelegate {

    var delegate: MainControllerDelegate?
    var pedidoPresenter: PedidoPresenter?
    
    
    @IBAction func btnMenuClicked(_ sender: Any) {
        delegate?.togglePanel!()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //Registramos la cabecera de la tabla
        let nib = UINib(nibName: "CabeceraPedido", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "CabeceraPedido")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return  (pedidoPresenter?.arrayPedidos.count)!
    }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (pedidoPresenter?.arrayPedidos[section].collapsed)! ? 0 : (pedidoPresenter?.arrayPedidos[section].detalle.count)!
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CabeceraPedido") as! CabeceraPedido
        
        header.lblFecha.text = pedidoPresenter?.getPedidoBy(index: section).fecha
        header.lblImporte.text = (pedidoPresenter?.getPedidoBy(index: section).importe.description)! + " €"
        
        header.section = section
        header.delegate = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (pedidoPresenter?.arrayPedidos[section].fecha)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MisPedidosCell") as! MiPedidoViewCell
        let producto = (pedidoPresenter?.getPedidoBy(index: indexPath.section).detalle[indexPath.row].producto)! as Producto
        cell.pedidoLbl.text = producto.nombreProducto
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func toggleSection(header: CabeceraPedido, section: Int){}
    
   
    

}

class MiPedidoViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pedidoLbl: UILabel!
    @IBOutlet weak var precioLbl: UILabel!


    
   
}
