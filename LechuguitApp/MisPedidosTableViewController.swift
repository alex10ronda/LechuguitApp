//
//  MisPedidosTableViewController.swift
//  LechuguitApp
//
//  Created by Alejandro Ruiz on 22/6/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

class MisPedidosTableViewController: UITableViewController {

    var delegate: MainControllerDelegate?
    var selectedIndexPath: IndexPath?
    
    @IBAction func btnMenuClicked(_ sender: Any) {
        
        delegate?.togglePanel!()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MisPedidosCell", for: indexPath) as! MiPedidoViewCell
       
        cell.pedidoLbl.text = "Mi Pedido"
        cell.tablaDetalle.layer.masksToBounds = true
        cell.tablaDetalle.layer.borderWidth = 0.5
        cell.tablaDetalle.layer.cornerRadius = cell.tablaDetalle.frame.height / 16.0
        cell.tablaDetalle.layer.borderColor = UIColor.blue.cgColor

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let previousIndexPath = selectedIndexPath
        
        if indexPath == selectedIndexPath {
            self.selectedIndexPath = nil
        }else{
            selectedIndexPath = indexPath as IndexPath?
        }
        
        var indexPaths: Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        
        if let current = selectedIndexPath{
            indexPaths += [current]
        }
        
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }
    
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! MiPedidoViewCell).watchFrameChanges()
        var celdaSeleccionada = cell as! MiPedidoViewCell
        if(celdaSeleccionada.frame.height == 200){
            celdaSeleccionada.icono.image = UIImage(named: "ic_menos")
        }else{
            celdaSeleccionada.icono.image = UIImage(named: "ic_mas")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! MiPedidoViewCell).ignoreFrameChanges()
    }
    
    
     override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableView.visibleCells as! [MiPedidoViewCell] {
            cell.ignoreFrameChanges()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath as IndexPath == selectedIndexPath {
            return MiPedidoViewCell.expandedHeight
        } else {
            return MiPedidoViewCell.defaultHeight
        }
    }
    
    

}

class MiPedidoViewCell: UITableViewCell {
    
    var isObserving = false;
    
    @IBOutlet weak var pedidoLbl: UILabel!
    @IBOutlet weak var icono: UIImageView!
    @IBOutlet weak var tablaDetalle: UITableView!


    
    class var expandedHeight: CGFloat{ get{ return 220 } }
    class var defaultHeight: CGFloat{ get{ return 50 } }
    
    func checkHeight() {
        tablaDetalle.isHidden = (frame.size.height < MiPedidoViewCell.expandedHeight)
    }
    
    func watchFrameChanges() {
        /*if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.new,NSKeyValueObservingOptions.initial], context: nil)
            isObserving = true;
            
            }*/
    }
    
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutableRawPointer) {
        if keyPath == "frame" {
            checkHeight()
        }
    }

}
