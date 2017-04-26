//
//  SideMenuViewController.swift
//  Tappas
//
//  Created by bbva on 26/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

@objc
protocol SideMenuViewControllerDelegate {
    @objc optional func optionSelected()
}

class SideMenuViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SideMenuViewControllerDelegate?
    
    var optionsPresenter: OptionsPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        optionsPresenter = OptionsPresenter()
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.optionsPresenter?.getCount())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! OptionCell
        
        cell.configureCell(option: (self.optionsPresenter?.getOptionAt(index: indexPath.row))!)
        
        return cell
    }
 
}


class OptionCell: UITableViewCell {
    
    @IBOutlet weak var opName: UILabel!
   
    @IBOutlet weak var opImg: UIImageView!
    
    func configureCell(option: Option){
        self.opName.text = option.nameOption
        self.opImg.image = UIImage(named: option.imgOption)
    }
    
}
