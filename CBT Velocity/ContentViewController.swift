//
//  ContentViewController.swift
//  CBT Velocity
//
//  Created by Ryan Hoffman on 3/23/16.
//  Copyright © 2016 Ryan Hoffman. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    // MARK: Variables
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = UIImage(named: imageFile)
        self.titleLabel.text = self.titleText
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
