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
    
    //读取字典操作只需要读取一次
    var colorLists: NSDictionary?
    
    //私有构造方法
    private override init() {
        super.init()
        self.skinInfo = loadCurrentThemeInfo()
        //plist中的字符串转颜色
        loadColorPlist()
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
    
    private func loadColorPlist() {
        //通过plist文件读取样式的颜色
        let colorPlistName =  "skin/\(self.skinInfo!)/SkinColors"
        let colorPath = Bundle.main.path(forResource: colorPlistName, ofType: "plist")
        let colorDict = NSDictionary(contentsOfFile: colorPath!)
        //将字典内容转为颜色
        var mutArr = NSMutableDictionary()
        colorDict?.enumerateKeysAndObjects({ (key, value, nil) in
            //分割字符串
            let arr = (value as AnyObject).components(separatedBy: ",")
            let r = NSString(string: arr[0]).floatValue
            let g = NSString(string: arr[1]).floatValue
            let b = NSString(string: arr[2]).floatValue
            let color = UIColor.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
            mutArr.addEntries(from: [key as! AnyHashable : color])
        })
        self.colorLists = mutArr
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
        //重新加载当前的colorPlist转换为对应的颜色值
        loadColorPlist()
    }
    
    /**
     *  Desc: colorName：格式：表示那个控件那个部分需要颜色：如label_textColor表示Label的text颜色
     *  Param:
     */
    func getColorWithKey(colorName: String) -> UIColor? {
//        //通过plist文件读取样式的颜色
//        let colorPath = Bundle.main.path(forResource: "color", ofType: "plist")
//        let colorDict = NSDictionary(contentsOfFile: colorPath!)
//        debugPrint("colorDict -------> \(colorDict)")
//        //通过字符串生成一个颜色
//        var color: UIColor?
//        if let colorStr = colorDict![colorName] as? String {
//            //分割字符串
//            let arr = colorStr.components(separatedBy: ", ")
//            let r = NSString(string: arr[0]).floatValue
//            let g = NSString(string: arr[1]).floatValue
//            let b = NSString(string: arr[2]).floatValue
//            color = UIColor.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
//        }
        
        //直接从转换好的颜色字典获取
        return self.colorLists?[colorName] as! UIColor
    }
    
}
