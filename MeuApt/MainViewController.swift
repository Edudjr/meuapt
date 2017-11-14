//
//  MainViewController.swift
//  MeuApt
//
//  Created by Eduardo Domene Junior on 13/11/17.
//  Copyright © 2017 Domene. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var shots = [ShotModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Register cell
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCellIdentifier")
        // Do any additional setup after loading the view, typically from a nib.
        Dribble.sharedInstance.getShots(page: 0) { (error, response) in
            if let err = error{
                print("\(err.localizedDescription)")
            }else if let resp = response{
                self.shots = resp
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCellIdentifier", for: indexPath) as! CustomTableViewCell
        let shot = shots[indexPath.row]
        cell.title.text = shot.title
        cell.count.text = "\(shot.viewsCount ?? 0)"
        cell.createdAt.text = shot.createdAt?.toString
        let url = URL(string: shot.image ?? "")
        cell.imgView.kf.setImage(with: url)
        return cell
    }
}

//MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate{
   
}

