//
//  NextViewController.swift
//  Interview
//
//  Created by mac on 2018/3/22.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var iv: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        iv.image = SkinTools.shared.imageWithName(name: "face")
    }

}
