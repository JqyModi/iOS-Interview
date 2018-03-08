//
//  Quartz2DViewController.swift
//  Interview
//
//  Created by mac on 2018/3/8.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class Quartz2DViewController: UIViewController {

    @IBOutlet weak var pieView: CustomProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func slide(_ sender: UISlider) {
        pieView.progressValue = CGFloat(sender.value)
    }
}
