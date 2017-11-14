//
//  ShotDetailsViewController.swift
//  MeuApt
//
//  Created by mac mini capgemini sp on 14/11/17.
//  Copyright © 2017 Domene. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ShotDetailsViewController: UIViewController{

    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    var id : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Dribbble.sharedInstance.getShot(byId: id){ (error, response) in
            if let err = error{
                print("\(err.localizedDescription)")
            }else if let shot = response{
                self.setup(shot: shot)
            }
        }
    }
    
    private func setup(shot: ShotModel){
        let desc = shot.description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        titleLabel.text = shot.title
        descriptionLabel.text = desc ?? ""
        commentsCountLabel.text = "\(String(describing: shot.commentsCount ?? 0))"
        viewCountLabel.text = "\(String(describing: shot.viewsCount ?? 0))"
        createdAtLabel.text = shot.createdAt?.toString
        let url = URL(string: shot.imageNormal ?? "")
        self.imgView.kf.setImage(with: url) { (image, error, chacheType, url) in
            let percentage = 100 - (image?.size.width)!*100/self.view.frame.width
            let newHeight = (image?.size.height)!*(percentage/100 + 1)
            self.imageHeight.constant = newHeight
        }
    }
}
