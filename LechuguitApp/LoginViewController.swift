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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        self.activityIndicator?.startAnimating()
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "first_name, last_name, picture.type(large)"]).start { (connection, result, error) in
            
            if(result != nil){
                
                let dictionaryResult = result as! NSDictionary
                
                //Obtiene los datos
                let name = dictionaryResult.value(forKey: "first_name") as! String
                let lastName = dictionaryResult.value(forKey: "last_name") as! String
                let id = dictionaryResult.value(forKey: "id") as! String
                
                let pictureDict = dictionaryResult.value(forKey: "picture") as! NSDictionary
                let picture = pictureDict.value(forKey: "data") as! NSDictionary
                
                let pictureUrl = picture.value(forKey: "url") as! String
                
                //Guarda en sesion los datos como un objeto Usuario
                Session.user = User(name: name, lastName: lastName, picture: pictureUrl, idUser: id)
                //Guarda en sesion la imagen
                try? Session.profileImg = UIImage(data: NSData(contentsOf: NSURL(string: pictureUrl) as! URL) as Data)
                
                //Guarda o Actualiza en la BBDD el usuario obtenido (en función si el ID existe o no)
                UserNetwork.sharedInstance.saveOrUpdate(user: Session.user!, completionHandler: { () in
                    
                    //Redirige al contenedor principal si hay exito
                     self.redirectToMain()
                    
                }, errorHandler: { () in
                    //En caso de error, mostrar alerta
                    let alert = UIAlertController(title: Constants.cadenas.MSG_ERROR, message: Constants.cadenas.MSG_REINTENTAR, preferredStyle: .alert)
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                    alert.addAction(aceptar)
                    self.present(alert, animated: true, completion: nil)
                    
                    //Se desloguea al usuario
                    let loginManager = FBSDKLoginManager()
                    loginManager.logOut()
                })
 
            }
            self.activityIndicator?.stopAnimating()
        }
    }
    
    //Función para el botón logout
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    
    //Muestra la pantalla con el contenedor principal
    func redirectToMain(){
    
        let containterViewController = ContainerViewController()
        self.view.window?.rootViewController = containterViewController
        self.view.window?.makeKeyAndVisible()

    }

}
