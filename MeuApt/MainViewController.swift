//
//  MainViewController.swift
//  MeuApt
//
//  Created by Eduardo Domene Junior on 13/11/17.
//  Copyright © 2017 Domene. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Dribble.sharedInstance.getShots(page: 0) { (error, response) in
            if let err = error{
                print("\(err.localizedDescription)")
            }else if let resp = response{
                print("\(resp)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

