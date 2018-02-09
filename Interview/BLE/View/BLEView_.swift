//
//  BLEView_.swift
//  Interview
//
//  Created by mac on 2018/2/9.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class BLEView_: UIView {

    var model: String? {
        didSet {
            icon?.image = UIImage(named: model!)
        }
    }
    
    @IBOutlet weak var icon: UIImageView!

    static func bleView() -> BLEView_ {
        //加载xib创建的View
        let xib = Bundle.main.loadNibNamed("BLEView_", owner: nil, options: nil)?.last as! BLEView_
        return xib
    }
    
    @IBAction func scan(_ sender: UIButton) {
        debugPrint("func --> \(#function) : line --> \(#line)")
    }
    
    @IBAction func stopScan(_ sender: UIButton) {
        debugPrint("func --> \(#function) : line --> \(#line)")
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        
    }
}
