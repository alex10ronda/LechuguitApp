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
    
    //Muestra el importe total
    @IBOutlet weak var lblTotal: UILabel!
    
    var delegate: MainControllerDelegate?
    
    var activityIndicator: UIActivityIndicatorView?

    @IBAction func btnComida(_ sender: Any) {
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Cada vez que aparece la vista establece la cantidad total que está almacenada en Sesion
        lblTotal.text = ((Session.user?.total)?.description)! + "0 €"
    }
    
    
    //Cuando carga la vista
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Establece el Activity Indicator
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator?.color = UIColor.black
        activityIndicator?.center = self.view.center
        
        self.view.addSubview(activityIndicator!)
        
        //Se establece el botón de la barra de navegación con la cuenta.
        // Este botón está guardado en sesión para fácil manejo en las distintas pantallas
        let barbutton: UIBarButtonItem = UIBarButtonItem(customView: Session.countBadge)
        
        self.navigationItem.rightBarButtonItem = barbutton

        //También se establece aquí el importe total
        //TODO: Quizás no sea necesario porque ya lo hace el viewWillAppear
        lblTotal.text = ((Session.user?.total)?.description)! + "0 €"

    }

    

    // MARK: - Navigation
    //Cuando se pulsa el botón menu en esta pantalla principal, se llama al togglePanel del delegate
    //de tipo MainControllerDelegate implementado en el Container
    
    @IBAction func btnMenuClicked(_ sender: Any) {
        delegate?.togglePanel!()
    }
 
}


//Implementación del SideMenuControllerDelegate, que gestiona las pulsaciones en el menú lateral
extension MainViewController: SideMenuViewControllerDelegate{
    
    
    //Gestiona la opción seleccionada
    func optionSelected(position: Int) {
        
        
        switch position {
        case 0:
            print("Volver al menu principal")
            //Cierra el panel, toma el Main Controller que es el primero de la pila de navegación
            self.delegate?.collapsePanel!()
            let mainController = navigationController?.viewControllers[0]
            self.navigationController?.popToViewController(mainController!, animated: true)
        
            
        case 1:
            print("Comida")
            self.delegate?.collapsePanel!()
            self.activityIndicator?.startAnimating()
            
            //Si no tiene la información de comida guardada en sesión, se realiza la petición.
            //Esto se hace de esta forma, para no realizar una petición cada vez que se selecciona 
            // la opción Comida
            
            if(Session.arrayComida.count == 0){
                ProductNetwork.sharedInstance.getAllProducts(completionHandler: { (comida, comida25, comida5) in
                    
                    //En caso de éxito se guardan en sesión los distintos arrays de comidas según su precio.
                    
                    //Ya están divididas según su precio para mayor facilidad a mostrarlas en secciones.
                    Session.arrayComida = comida
                    Session.arrayComida25 = comida25
                    Session.arrayComida5 = comida5
                    
                    //Redirige hacia la pantalla de Tapas
                    self.redirectToTapas()
                    
                }, errorHandler: { () in
                    
                    //En caso de error se muestra un alert con el error
                    self.activityIndicator?.stopAnimating()
                    self.showAlert(msg: Constants.cadenas.MSG_ERROR_CONEXION)
                
                })
  
            }else{
                
                //Si ya se tiene guardado en sesión se redirige directamente hacia la pantalla de Tapas.
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
            
            
        case 3:
            print("Mis Pedidos")
            self.delegate?.collapsePanel!()
            self.activityIndicator?.startAnimating()
            
            PedidoNetwork.sharedInstance.getUltimosPedidos(completionHandler: { (respuesta) in
                print(respuesta)
            }, errorHandler: {
                self.activityIndicator?.stopAnimating()
                self.showAlert(msg: Constants.cadenas.MSG_ERROR_CONEXION)
            })
            redirectToMisPedidos()
            
            
        case 4:
            print("Salir")
            //Al salir se guardan los datos en el Preferences
            Utils.saveDataPreferences()
            
            //Se hace Logout en Facebook
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            
            //Se presenta la pantalla de Login
            self.navigationController?.present(UIStoryboard.loginViewController(), animated: true, completion: nil)
            
            break
        default:
            print("Default")
        }
        
    }
    
    
    /**
        Método que se llama para redirigir a la pantalla de Mis Pedidos Recientes
     */
    func redirectToMisPedidos(){
        
        let misPedidosController = UIStoryboard.misPedidosViewController()
        
        //Esta nueva pantalla tiene un delegate que se iguala al de esta (Principal) para poder abrir/cerrar el menú lateral
        misPedidosController.delegate = self.delegate
        self.navigationController?.pushViewController(misPedidosController, animated: true)
        self.activityIndicator?.stopAnimating()
    }
    
    
    /**
     Método que se llama para redirigir a la pantalla de Comida
     */
    func redirectToTapas(){
       
       let comidaController = UIStoryboard.comidaViewController()
        comidaController.delegate = self.delegate
        self.navigationController?.pushViewController(comidaController, animated: true)
        self.activityIndicator?.stopAnimating()
    }
    
    
    /**
     Método que se llama para redirigir a la pantalla de Bebidas
     */
    func redirectToBebidas(){
        let bebidaController = UIStoryboard.bebidaViewController()
        bebidaController.delegate = self.delegate
        self.navigationController?.pushViewController(bebidaController, animated: true)
        self.activityIndicator?.stopAnimating()
    }
    
    
    /**
        Método al que se llama para mostrar un alert de error cuando sea necesario
    */
    func showAlert(msg:String){
        let alert = UIAlertController(title: Constants.cadenas.ERROR, message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: Constants.cadenas.ACEPTAR, style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
}
