//
//  LabelController.swift
//  Interview
//
//  Created by mac on 2018/3/22.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class LabelController: UIViewController {

    @IBOutlet weak var font: UILabel!
    @IBOutlet weak var fontColor: UILabel!
    @IBOutlet weak var bgColor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }

    private func setupStyle() {
        fontColor.textColor = SkinTools.shared.getColorWithKey(colorName: "label_textColor")!
        bgColor.backgroundColor = SkinTools.shared.getColorWithKey(colorName: "label_bgColor")!
    }
}
