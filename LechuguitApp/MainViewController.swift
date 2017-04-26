//
//  MainViewController.swift
//  Tappas
//
//  Created by bbva on 26/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

@objc
protocol MainControllerDelegate {
    @objc optional func togglePanel()
    @objc optional func collapsePanel()
}

class MainViewController: UIViewController {
    
    var delegate: MainControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
}
