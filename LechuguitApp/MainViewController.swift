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
            print("Comida")
            self.activityIndicator?.startAnimating()
            ProductNetwork.sharedInstance.getAllProducts()
            delegate?.collapsePanel!()
            let comidaController = UIStoryboard.comidaViewController();
            comidaController.delegate = self.delegate
            self.navigationController?.pushViewController(comidaController, animated: true)
            
        case 3:
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
    
}
