//
//  LoginViewController.swift
//  INID
//
//  Created by Home on 8/17/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    var ud = UserDefaults.standard
    static var userId : String?
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var sw: UISwitch!
    @IBOutlet weak var rememberMe: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
        
        // rounded buttons
        loginButton.layer.cornerRadius = 15.0
        loginButton.layer.cornerCurve = .continuous
        signUpButton.layer.cornerRadius = 15.0
        signUpButton.layer.cornerCurve = .continuous
        // Do any additional setup after loading the view.
        
        if (sw.isOn) { // if the switch is on, remember the last username/password combo entered and automatically enter it for the user
            username.text = ud.string(forKey: "username")
            password.text = ud.string(forKey: "username")
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        let thisUser = DBHelper.inst.getOneAccount(username: username.text!)
        let data = DBHelper.inst.getAccounts()
        for a in data {
            if (username.text == "admin" && password.text == "admin") { // bring up the special admin page if the username/password combo are correct
                // instantiate admin screen
                let adminPage = self.storyboard?.instantiateViewController(identifier: "admin") as! AdminViewController
                adminPage.modalPresentationStyle = .fullScreen
                self.present(adminPage, animated: true, completion: nil)
            }
            if (a.username == nil || a.password == nil){
                let alert = UIAlertController(title: "Wrong informations", message: "Enter a correct username or password", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            if (username.text == a.username! && password.text == a.password!) { // Verifies that the user credentials are in the core data and lets the user login
                let data = DBHelper.inst.getOneAccount(username: username.text!)
                LoginViewController.userId = data.username
                
                // instantiate dashboard screen
                DBHelper.inst.addCurrUser(object: username.text!)
                let dashboard = self.storyboard?.instantiateViewController(identifier: "home") as! HomeViewController
                dashboard.modalPresentationStyle = .fullScreen
                self.present(dashboard, animated: true, completion: nil)
            } else if (thisUser.blockedStatus == true) {
                // create the alert
                let alert = UIAlertController(title: "User Blocked", message: "You are blocked. Please create a new account.", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func rememberLogin(_ sender: UISwitch) {
        
        if (sw.isOn) {
            ud.set(sender.isOn, forKey: "mySwitchValue")
            ud.set(username.text, forKey: "username")
            ud.set(password.text, forKey: "password")
        } else {
            ud.removeObject(forKey: "username")
            ud.removeObject(forKey: "password")
        }
    }
    override func viewDidAppear(_ animated: Bool) { // used for userdefaults with regards to remembering the last password/username combo input
        sw.isOn = ud.bool(forKey: "mySwitchValue")
        username.text = ud.string(forKey: "username")
        password.text = ud.string(forKey: "password")
    }

}
