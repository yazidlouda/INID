//
//  RegisterViewController.swift
//  INID
//
//  Created by Home on 8/17/21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CreateAccount(_ sender: Any) {
        let dic = ["username" : userField.text, "password" : passField.text]
        DBHelper.inst.addUser(object: dic as! [String:String])
        
        if (userField.text!.isEmpty == false && passField.text!.isEmpty == false) {
            let alert = UIAlertController(title: "Signed Up", message: "Account created.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
                
            DBHelper.inst.addCurrUser(object: userField.text!)
        } else if (userField.text!.isEmpty && passField.text!.isEmpty) {
            let alert = UIAlertController(title: "Error.", message: "No account details provided. Account not created.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            DBHelper.inst.deleteOneUser(username: "")
        }
        
        userField.text = "" // reset the text fields to empty so the user can create another new user if they wish
        passField.text = ""
    }
    
   

}
