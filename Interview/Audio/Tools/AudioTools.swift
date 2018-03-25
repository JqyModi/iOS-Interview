//
//  AudioTools.swift
//  Interview
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit
import AVFoundation

class AudioTools: NSObject {
    
    //缓存URL对应的音效ID
    var cacheDict: Dictionary<String, SystemSoundID>
    
//    override init() {
//        debugPrint("func --> \(#function) : line --> \(#line)")
//        cacheDict = Dictionary<String, SystemSoundID>()
//    }
    
    private override init() {
        cacheDict = Dictionary<String, SystemSoundID>()
    }
    
    private static let sigle = AudioTools()
    class var shared: AudioTools {
        return sigle
    }
    
    func palySystemSoundWithURL(url: URL) {

        //3.播放音效文件
        AudioServicesPlaySystemSoundWithCompletion(cacheSoundIDWithURL(url: url)) {
            debugPrint("音效播放完成 ~")
            //释放音效
//            AudioServicesDisposeSystemSoundID(self.cacheSoundIDWithURL(url: url))
        }
    }
    
    func cacheSoundIDWithURL(url: URL) -> SystemSoundID {
        //2.创建音效文件
        //2.1获取音效文件URL
        let url = url
        //2.1.1 获取path作为Key
        let path = url.absoluteString
        
        //2.2定义一个变量记录当前音效ID
        var soundID = SystemSoundID()
        
        soundID = SystemSoundID(self.cacheDict[path]?.hashValue ?? 0)
        
        //2.3创建音效文件
        if soundID == 0 {
            debugPrint("新生成ID")
            //如果不存在重新创建
            AudioServicesCreateSystemSoundID(url as! CFURL, &soundID)
            //重新缓存
            self.cacheDict[path] = soundID
        }else {
            debugPrint("缓存ID")
        }
        return soundID
    }
    
    //清理内存
    func clearCache() {
        //遍历获取soundID并清理对应的音效资源
        let dict: NSMutableDictionary = self.cacheDict as! NSMutableDictionary
        dict.enumerateKeysAndObjects { (key, value, nil) in
            //获取soundID
            let soundID = value as! SystemSoundID
            //通过soundID删除对应的音效内存引用
            AudioServicesDisposeSystemSoundID(soundID)
        }
        //字典也需要清理
        dict.removeAllObjects()
    }
    
}
