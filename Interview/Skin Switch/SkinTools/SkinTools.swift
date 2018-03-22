//
//  SkinTools.swift
//  Interview
//
//  Created by mac on 2018/3/22.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

/**
 *  Desc: 要求：1.用户不需要关心当前皮肤样式 2.不需要关心skinKey:保存到ud中的Key
 *  Param:
 */
class SkinTools: NSObject {
    
    func initialize() {
        debugPrint("initialize")
    }
    
    func load() {
        debugPrint("load")
    }
    
    var skinInfo: String?
    
    //私有构造方法
    private override init() {
        super.init()
        self.skinInfo = loadCurrentThemeInfo()
    }
    //单例
    private static let sharedInstance = SkinTools()
    class var shared: SkinTools {
        return sharedInstance
    }
    
    func loadCurrentThemeInfo() -> String {
        //读取当前主题信息
        let standard = UserDefaults.standard
        var skinInfo = standard.value(forKey: "SkinInfo")
        if skinInfo == nil {
            skinInfo = "red"
        }
        return skinInfo as! String
    }
    
    func imageWithName(name: String) -> UIImage {
        let imageName = "skin/\(self.skinInfo!)/\(name)"
        let image = UIImage(named: imageName)
        return image!
    }
    
    func saveCurrentThemeInfo(currentSkinInfo: String) {
        //读取当前主题信息
        let standard = UserDefaults.standard
        standard.set(currentSkinInfo, forKey: "SkinInfo")
        //保存当前的主题信息
        self.skinInfo = currentSkinInfo
    }
    
    /**
     *  Desc: colorName：格式：表示那个控件那个部分需要颜色：如label_textColor表示Label的text颜色
     *  Param:
     */
    func getColorWithKey(colorName: String) -> UIColor? {
        //通过plist文件读取样式的颜色
        let colorPath = Bundle.main.path(forResource: "color", ofType: "plist")
        let colorDict = NSDictionary(contentsOfFile: colorPath!)
        debugPrint("colorDict -------> \(colorDict)")
        //通过字符串生成一个颜色
        var color: UIColor?
        if let colorStr = colorDict![colorName] as? String {
            //分割字符串
            let arr = colorStr.components(separatedBy: ", ")
            let r = NSString(string: arr[0]).floatValue
            let g = NSString(string: arr[1]).floatValue
            let b = NSString(string: arr[2]).floatValue
            color = UIColor.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
        }
        return color
    }
    
}
