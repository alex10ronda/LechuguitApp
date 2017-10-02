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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    @IBOutlet weak var icDesplegable: UIImageView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    class var expandedHeight: CGFloat{ get{ return 200 } }
    class var defaultHeight: CGFloat{ get{ return 44 } }
    
    func checkHeight() {
        datePicker.isHidden = (frame.size.height < MiPedidoViewCell.expandedHeight)
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
