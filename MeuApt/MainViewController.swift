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
    private let refreshControl = UIRefreshControl()
    var shots = [ShotModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Register cell
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCellIdentifier")
        tableView.separatorStyle = .none
        tableView.alpha = 0
        
        //Navigation Bar Settings
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.alpha = 0
        
        //Animations
        fadeIn(view: self.navigationController?.navigationBar, duration: 1)
        
        //Pull to refresh
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        
        // Do any additional setup after loading the view, typically from a nib.
        Dribbble.sharedInstance.getShots(page: 0) { (error, response) in
            if let err = error{
                print("\(err.localizedDescription)")
            }else if let resp = response{
                self.shots = resp
                self.reloadAndFadeIn()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func handlePullToRefresh(_ refreshControl: UIRefreshControl){
        // Do any additional setup after loading the view, typically from a nib.
        Dribbble.sharedInstance.getShots(page: 0) { (error, response) in
            if let err = error{
                print("\(err.localizedDescription)")
            }else if let resp = response{
                self.shots = resp
                self.reloadAndFadeIn()
                refreshControl.endRefreshing()
            }
        }
    }
    
    private func reloadAndFadeIn(){
        tableView.reloadData()
        fadeIn(view: tableView, duration: 0.5)
    }
    
    private func fadeIn(view: UIView?, duration: Double){
        if let v = view {
            UIView.animate(withDuration: duration, animations: {
                v.alpha = 1
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            if let vc = segue.destination as? ShotDetailsViewController {
                if let index = self.tableView.indexPathForSelectedRow?.row{
                    let selected = shots[index]
                    vc.id = selected.id
                }
            }
        }
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
        cell.id = shot.id
        cell.title.text = shot.title
        cell.count.text = "\(shot.viewsCount ?? 0)"
        cell.createdAt.text = shot.createdAt?.toString
        let url = URL(string: shot.imageTeaser  ?? "")
        cell.imgView.kf.setImage(with: url)
        return cell
    }
}

//MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailsSegue", sender: self)
    }
}

