//
//  ContainerViewController.swift
//  Tappas
//
//  Created by bbva on 26/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

enum State {
    case collapse
    case expanded
}

class ContainerViewController: UIViewController {
    
    var currentState: State = .collapse
        
    var centerViewController: MainViewController!
    var centerNavigationController: UINavigationController!
    
    var leftViewController:SideMenuViewController?
    
    var centerPanelExpandedOffset: CGFloat = 65
    
    //var currentController: UIViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        //currentController = centerViewController
        
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMove(toParentViewController: self)
        
        Session.countBadge.setImage(UIImage(named: "ic_plane"), for: UIControlState.normal)
        
        Session.countBadge.badgeString = Utils.getStringCount()
        Session.countBadge.badgeEdgeInsets=UIEdgeInsets.init(top:12, left: 0, bottom: 0, right: 10)
        Session.countBadge.addTarget(self, action: #selector(moveToPedido(sender:)), for: .touchUpInside)
        
    }
    
    func moveToPedido(sender: UIBarButtonItem){
        print(Session.pedido)
        
        
        if(Session.FLAG_BEBIDA == 0 && Session.FLAG_COMIDA == 1){
            let alert = UIAlertController(title: "Aviso", message: "No has pedido nada para beber", preferredStyle: .alert)
            
            let bebidas = UIAlertAction(title: "Ir a Bebidas", style: .default, handler: { (action) in
                self.centerViewController.optionSelected(position: 2)
            })
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alert.addAction(bebidas)
            alert.addAction(cancelar)
            present(alert, animated: true, completion: nil)
            
        } else if(Session.FLAG_COMIDA == 0 && Session.FLAG_BEBIDA == 1){
            let alert = UIAlertController(title: "Aviso", message: "No has pedido nada para comer", preferredStyle: .alert)
            
            let bebidas = UIAlertAction(title: "Ir a Tapas", style: .default, handler: { (action) in
                self.centerViewController.optionSelected(position: 1)
            })
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alert.addAction(bebidas)
            alert.addAction(cancelar)
            present(alert, animated: true, completion: nil)
            
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
}

extension ContainerViewController: MainControllerDelegate{
    
    func togglePanel(){
        
        let notAlreadyExpanded = (currentState != .expanded)
        if(notAlreadyExpanded){
            addPanelViewController()
        }
        animatePanel(shouldExpand: notAlreadyExpanded)
    }
    
    
    func addPanelViewController(){
        
        if(leftViewController == nil){
            leftViewController = UIStoryboard.sideMenuViewController()
            addChildSidePanelController(sidePanelController: leftViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SideMenuViewController){
        
        sidePanelController.delegate = centerViewController
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
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
    
    func collapsePanel(){
        if(currentState == .expanded){
            togglePanel()
        }
    }
}
