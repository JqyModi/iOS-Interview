//
//  SkinSwitchController.swift
//  Interview
//
//  Created by mac on 2018/3/22.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class SkinSwitchController: UIViewController {
    @IBOutlet weak var iv: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageName = "face"
        changeSkin(imageName: imageName)
    }
    @IBAction func redDidClicked(_ sender: UIButton) {
        let skin = "red"
        let imageName = "face"
        SkinTools.shared.saveCurrentThemeInfo(currentSkinInfo: skin)
        changeSkin(imageName: imageName)
    }
    
    @IBAction func greenDidClicked(_ sender: UIButton) {
        let skin = "green"
        let imageName = "face"
        SkinTools.shared.saveCurrentThemeInfo(currentSkinInfo: skin)
        changeSkin(imageName: imageName)
    }
    
    @IBAction func blueDidClicked(_ sender: UIButton) {
        let skin = "blue"
        let imageName = "face"
        SkinTools.shared.saveCurrentThemeInfo(currentSkinInfo: skin)
        changeSkin(imageName: imageName)
    }
    
    @IBAction func orangeDidClicked(_ sender: UIButton) {
        let skin = "orange"
        let imageName = "face"
        SkinTools.shared.saveCurrentThemeInfo(currentSkinInfo: skin)
        changeSkin(imageName: imageName)
    }
    
    fileprivate func changeSkin(imageName: String) {
        iv.image = SkinTools.shared.imageWithName(name: imageName)
    }
}
