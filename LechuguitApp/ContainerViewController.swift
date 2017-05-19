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
