//
//  MainViewController.swift
//  Tappas
//
//  Created by bbva on 26/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit
import FBSDKLoginKit

@objc
protocol MainControllerDelegate {
    @objc optional func togglePanel()
    @objc optional func collapsePanel()
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var lblTotal: UILabel!
    var delegate: MainControllerDelegate?
    
    var activityIndicator: UIActivityIndicatorView?

    @IBAction func btnComida(_ sender: Any) {
        NetworkClient.sharedInstance.getAllEstados()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator?.color = UIColor.black
        activityIndicator?.center = self.view.center
        
        self.view.addSubview(activityIndicator!)
        
        var barbutton: UIBarButtonItem = UIBarButtonItem(customView: Session.countBadge)
        
        self.navigationItem.rightBarButtonItem = barbutton

        lblTotal.text = ((Session.user?.total)?.description)! + "0 €"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    @IBAction func btnMenuClicked(_ sender: Any) {
        delegate?.togglePanel!()
    }
 
}


extension MainViewController: SideMenuViewControllerDelegate{
    
    
    func optionSelected(position: Int) {
        
        
        switch position {
        case 0:
            print("Volver al menu principal")
            self.delegate?.collapsePanel!()
            let mainController = navigationController?.viewControllers[0]
            self.navigationController?.popToViewController(mainController!, animated: true)
        
        case 1:
            print("Comida")
            self.delegate?.collapsePanel!()
            self.activityIndicator?.startAnimating()
            
            if(Session.arrayComida.count == 0){
                ProductNetwork.sharedInstance.getAllProducts(completionHandler: { (comida, comida25, comida5) in
                    Session.arrayComida = comida
                    Session.arrayComida25 = comida25
                    Session.arrayComida5 = comida5
                    self.redirectToTapas()
                    
                }, errorHandler: { () in
                    self.activityIndicator?.stopAnimating()
                    self.showAlert(msg: Constants.cadenas.MSG_ERROR_CONEXION)
                
                })
  
            }else{
                redirectToTapas()
            }
        
            
        case 2:
            print("Bebidas")
            self.delegate?.collapsePanel!()
            self.activityIndicator?.startAnimating()
            
            if(Session.arrayBebidas.count == 0){
                ProductNetwork.sharedInstance.getDrinks(completionHandler: { (productos) in
                    Session.arrayBebidas = productos
                    self.redirectToBebidas()
                }, errorHandler: { () in
                    self.activityIndicator?.stopAnimating()
                    self.showAlert(msg: Constants.cadenas.MSG_ERROR_CONEXION)
                })
            }else{
                redirectToBebidas()
            }
            
            
            
            
        case 4:
            print("Salir")
            Utils.saveDataPreferences()
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            self.navigationController?.present(UIStoryboard.loginViewController(), animated: true, completion: nil)
            
            break
        default:
            print("Default")
        }
        
    }
    
    func redirectToTapas(){
       
       let comidaController = UIStoryboard.comidaViewController()
        comidaController.delegate = self.delegate
        self.navigationController?.pushViewController(comidaController, animated: true)
        self.activityIndicator?.stopAnimating()
    }
    
    func redirectToBebidas(){
        let bebidaController = UIStoryboard.bebidaViewController()
        bebidaController.delegate = self.delegate
        self.navigationController?.pushViewController(bebidaController, animated: true)
        self.activityIndicator?.stopAnimating()
    }
    
    func showAlert(msg:String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
}
