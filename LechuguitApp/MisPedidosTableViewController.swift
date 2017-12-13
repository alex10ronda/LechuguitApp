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
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Registramos la cabecera de la tabla
        let nib = UINib(nibName: "CabeceraPedido", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "CabeceraPedido")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //El número de secciones el igual al número de pedidos
    override func numberOfSections(in tableView: UITableView) -> Int {
        return  (pedidoPresenter?.arrayPedidos.count)!
    }

    //El número de celdas en la sección es 0 si está colapsada y  el número de productos del pedido en caso de que no lo esté
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (pedidoPresenter?.arrayPedidos[section].collapsed)! ? 0 : (pedidoPresenter?.arrayPedidos[section].detalle.count)!
    }
    
    //La altura de las celdas es 0 si está colapsada y automatico si no lo está
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (pedidoPresenter?.arrayPedidos[(indexPath as NSIndexPath).section].collapsed)! ? 0 : UITableViewAutomaticDimension
    }
    
    //Método que carga la cabecera de las secciones
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CabeceraPedido") as! CabeceraPedido
        
        header.lblFecha.text = pedidoPresenter?.getPedidoBy(index: section).fecha
        header.lblImporte.text = (pedidoPresenter?.getPedidoBy(index: section).importe.description)! + " €"
        
        header.flecha.text = ">"
        header.setCollapsed(collapsed: (pedidoPresenter?.arrayPedidos[section].collapsed)!)
        
        header.section = section
        header.delegate = self
        return header
    }
    
    
    //Titulo para la seccion
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (pedidoPresenter?.arrayPedidos[section].fecha)
    }
    
    
    //Carga las celdas de cada seccion con los productos de cada pedido
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MisPedidosCell") as! MiPedidoViewCell
        
        let pedido = (pedidoPresenter?.arrayPedidos[indexPath.section])! as Pedido
        let productoPedido = pedido.detalle[indexPath.row] as ProductoPedido
        let producto = productoPedido.producto as Producto
    
        cell.pedidoLbl.text = producto.nombreProducto
        cell.precioLbl.text = (productoPedido.precio?.description)! + " €"
        return cell
    }
    
    
    //Altura de la seccion
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    //Para reducir la separacion entre secciones
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    
    //Método del Delegate que cambia el estado de una celda de colapsada a no colapsada y viceversa
    func toggleSection(header: CabeceraPedido, section: Int){
    
        let collapsed = !(pedidoPresenter?.arrayPedidos[section].collapsed)!
        
        pedidoPresenter?.arrayPedidos[section].collapsed = collapsed
        
        header.setCollapsed(collapsed: collapsed)
        
        tableView.reloadSections(NSIndexSet(index:section) as IndexSet, with: .automatic)
    }

}

class MiPedidoViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pedidoLbl: UILabel!
    @IBOutlet weak var precioLbl: UILabel!


    
   
}
