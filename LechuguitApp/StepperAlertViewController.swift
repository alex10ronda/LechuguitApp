//
//  StepperAlertViewController.swift
//  LechuguitApp
//
//  Created by bbva on 19/5/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit

class StepperAlertViewController: UIAlertController {

    var labelCount:UILabel?
    //var countButton: MIBadgeButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       /* let alertStepper = UIAlertController(title: "Indique la cantidad", message: "\n\n\n", preferredStyle: .alert)*/
        
        
        let stepper: UIStepper = UIStepper(frame: CGRect(x: 60, y: 60, width: 100, height: 50))
        stepper.addTarget(self, action: #selector(changeCountValue), for: .valueChanged)
        self.view.addSubview(stepper)
        
        labelCount = UILabel(frame: CGRect(x: stepper.frame.origin.x + stepper.frame.size.width + 10, y: stepper.frame.origin.y - 12, width: 40, height: 50))
        
        labelCount?.textAlignment = .center
        labelCount?.font = UIFont.systemFont(ofSize: 32)
        labelCount?.text = "0"
        self.view.addSubview(labelCount!)
        
        let aceptar = UIAlertAction(title: "Aceptar", style: .default) { (action) in
            Session.productCount = Session.productCount + Int(stepper.value)
            Session.countBadge.badgeString = Utils.getStringCount()
            self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: Session.countBadge)
            
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        self.addAction(aceptar)
        self.addAction(cancelar)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeCountValue(sender:UIStepper){
        labelCount?.text = Int(sender.value).description
        
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
