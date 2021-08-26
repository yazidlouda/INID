//
//  HomeViewController.swift
//  INID
//
//  Created by Home on 8/17/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        homeMessage.text = "HELLO" + " " + LoginViewController.userId!
        // Do any additional setup after loading the view.
    }
    

  

}
