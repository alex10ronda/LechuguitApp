//
//  ContainerViewController.swift
//  Tappas
//
//  Created by bbva on 26/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

//Posibles estados menú lateral
enum State {
    case collapse
    case expanded
}

class ContainerViewController: UIViewController {
    
    //Estado inicial cerrado
    var currentState: State = .collapse
    
    
    var centerViewController: MainViewController!
    var centerNavigationController: UINavigationController!
    
    //Menu lateral
    var leftViewController:SideMenuViewController?
    
    //Cantidad de desplazamientos
    var centerPanelExpandedOffset: CGFloat = 65
    
    //var currentController: UIViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //El centreViewController es un MainViewController y su delegate está implementado aquí, este Delegate se encarga de cerrar y abrir el menú lateral
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        //Se añade al NavigationController y este a la vista
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMove(toParentViewController: self)
        
        //Se inicializa la cuenta de productos que se lleva en la barra de navigacion
        //Este countBadge está en sesion para ser compartida en todas las pantallas
        Session.countBadge.setImage(UIImage(named: "ic_plane"), for: UIControlState.normal)
        Session.countBadge.badgeString = Utils.getStringCount()
        Session.countBadge.badgeEdgeInsets=UIEdgeInsets.init(top:12, left: 0, bottom: 0, right: 10)
        Session.countBadge.addTarget(self, action: #selector(moveToPedido(sender:)), for: .touchUpInside)
        
    }
    
    //Función que se lanza cuando se pulsa en enviar pedido del NavigationController
    func moveToPedido(sender: UIBarButtonItem){
        
        //Si se ha seleccionado solo comida, muestra un alert con dos opciones:
        // 1. Ir al menú de bebidas
        // 2. Ir a finalizar pedido
        if(Session.FLAG_BEBIDA == 0 && Session.FLAG_COMIDA == 1){
            let alert = UIAlertController(title: Constants.cadenas.AVISO, message: Constants.cadenas.MSG_PEDIR_BEBIDA, preferredStyle: .alert)
            
            let bebidas = UIAlertAction(title: Constants.cadenas.IR_BEBIDA, style: .default, handler: { (action) in
                //Hace la misma función que si selecciona la opcion bebidas del menú lateral
                self.centerViewController.optionSelected(position: 2)
            })
            let cancelar = UIAlertAction(title: Constants.cadenas.PEDIR, style: .cancel, handler: {(action) in
                self.showPedidoController()
            })
            alert.addAction(bebidas)
            alert.addAction(cancelar)
            //Cuando se presenta la alerta se añade el gesto para reconocer cuando se clica fuera... en ese caso se cierra la alerta
            present(alert, animated: true, completion: {
                alert.view.superview?.isUserInteractionEnabled = true
                alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertClose(sender:))))

            })
            
            //Si solo se ha seleccionando bebida, hace lo contrario
        } else if(Session.FLAG_COMIDA == 0 && Session.FLAG_BEBIDA == 1){
            let alert = UIAlertController(title: Constants.cadenas.AVISO, message: Constants.cadenas.MSG_PEDIR_COMIDA, preferredStyle: .alert)
            
            let tapas = UIAlertAction(title: Constants.cadenas.IR_COMIDA, style: .default, handler: { (action) in
                self.centerViewController.optionSelected(position: 1)
            })
            let cancelar = UIAlertAction(title: Constants.cadenas.PEDIR, style: .cancel, handler: {(action) in
                self.showPedidoController()
            })
            alert.addAction(tapas)
            alert.addAction(cancelar)
            present(alert, animated: true, completion: {
                alert.view.superview?.isUserInteractionEnabled = true
                alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertClose(sender:))))
            })
            
            //Si se han seleccionado ambas, se redirige a la pantalla de finalizar pedido
        } else if(Session.FLAG_COMIDA == 1 && Session.FLAG_BEBIDA == 1){
            showPedidoController();
        }
        
    }
    
    //Función que se lanza cuando se reconoce un click fuera del alert, cierra el propio alert
    func alertClose(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Presenta la pantalla Pedido controller
    func showPedidoController(){
        
        let pedidoController = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: "PedidoViewController") as! PedidoViewController
        self.centerNavigationController.pushViewController(pedidoController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}


//Recupera todas las vistas con su controlador del StoryBoard
extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func centerViewController() -> MainViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    }
    
    class func sideMenuViewController() -> SideMenuViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
    }
    
    class func loginViewController() -> LoginViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    class func comidaViewController() -> ComidaTableViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "ComidaViewController") as!
        ComidaTableViewController
    }
    
    class func bebidaViewController() -> BebidaTableViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "BebidaViewController") as!
        BebidaTableViewController
    }
    
    class func misPedidosViewController() -> MisPedidosTableViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "MisPedidosVC") as! MisPedidosTableViewController
    }
    
    class func detalleProductoViewController() -> DetalleProductoViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "DetalleProducto") as! DetalleProductoViewController
    }

}


//Implementacion del MainControllerDelegate
extension ContainerViewController: MainControllerDelegate{
    
    //Función que se llama cuando se hace click en el icono de menú
    //Si está cerrano lo expande
    func togglePanel(){
        
        let notAlreadyExpanded = (currentState != .expanded)
        if(notAlreadyExpanded){
            addPanelViewController()
        }
        animatePanel(shouldExpand: notAlreadyExpanded)
    }
    
    
    //Añade el panel del Menu lateral
    func addPanelViewController(){
        
        if(leftViewController == nil){
            leftViewController = UIStoryboard.sideMenuViewController()
            addChildSidePanelController(sidePanelController: leftViewController!)
        }
    }
    
    //Añade el panel y añade el delegate que se encarga de gestionar las funciones del menu, de tipo SideMenuDelegate
    func addChildSidePanelController(sidePanelController: SideMenuViewController){
        
        sidePanelController.delegate = centerViewController
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    //Se encarga de abrir o cerrar el panel en funcion de lo que deba hacer
    func animatePanel(shouldExpand: Bool){
        if(shouldExpand){
            self.currentState = .expanded
            animateCenterPanelXPosition(targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
        }else{
            animateCenterPanelXPosition(targetPosition:0){ finished in
                self.currentState = .collapse
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil
                
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion:((Bool) -> Void)! = nil){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { 
            self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    //Cierra el panel, si debe hacerlo, llamando a togglePanel
    func collapsePanel(){
        if(currentState == .expanded){
            togglePanel()
        }
    }
}
