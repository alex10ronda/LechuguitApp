//
//  DetalleProductoViewController.swift
//  LechuguitApp
//
//  Created by Alejandro Ruiz on 11/9/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

class DetalleProductoViewController: UIViewController {
    
    var producto: Producto! = nil

    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var imgProducto: UIImageView!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNombre.text = producto.nombreProducto
        lblPrecio.text = (producto.precio?.description)! + " €"
        lblDescripcion.text = producto.descripcion
        
        if(producto.imgProducto != nil){
            if let decodedData = Data(base64Encoded: producto.imgProducto!, options: .ignoreUnknownCharacters) {
                imgProducto.image = UIImage(data: decodedData)
            }
        }else{
            imgProducto.image = UIImage(named: "noImg")
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
