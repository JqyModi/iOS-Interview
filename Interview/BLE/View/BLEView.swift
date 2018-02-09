//
//  BLEView.swift
//  Interview
//
//  Created by mac on 2018/2/7.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

protocol BLEViewDelegate {
    func findPeripheral()
}

class BLEView: UIView {

    var delegate: BLEViewDelegate?
    
    @IBAction func findPeripheral(_ sender: UIButton) {
        self.delegate?.findPeripheral()
    }
    
}
