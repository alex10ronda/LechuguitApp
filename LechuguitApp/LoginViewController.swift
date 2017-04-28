//
//  LoginViewController.swift
//  LechuguitApp
//
//  Created by bbva on 27/4/17.
//  Copyright © 2017 bbva. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var loginButton = FBSDKLoginButton()
    
    var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.center = self.view.center
        loginButton.readPermissions = ["public_profile", "email"]
        loginButton.delegate = self
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator?.color = UIColor.black
        activityIndicator?.center = self.view.center
        
        self.view.addSubview(loginButton)
        self.view.addSubview(activityIndicator!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        self.activityIndicator?.startAnimating()
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "first_name, last_name, picture.type(large)"]).start { (connection, result, error) in
            
            if(result != nil){
                self.redirectToMain()
                self.activityIndicator?.stopAnimating()
            }

        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
    func redirectToMain(){
    
        let containterViewController = ContainerViewController()
        self.view.window?.rootViewController = containterViewController
        self.view.window?.makeKeyAndVisible()

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
