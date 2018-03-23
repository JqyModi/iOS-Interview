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
    var cacheDict: NSMutableDictionary?
    
    override init() {
        debugPrint("func --> \(#function) : line --> \(#line)")
        cacheDict = NSMutableDictionary.init(capacity: 10)
    }
    
    func palySystemSoundWithURL(url: URL) {

        //3.播放音效文件
        AudioServicesPlaySystemSoundWithCompletion(cacheSoundIDWithURL(url: url)) {
            debugPrint("音效播放完成 ~")
            //释放音效
//            AudioServicesDisposeSystemSoundID(soundID)
        }
    }
    
    func cacheSoundIDWithURL(url: URL) -> SystemSoundID {
        //2.创建音效文件
        //2.1获取音效文件URL
        let url = url
        //2.1.1 获取path作为Key
        let path = url.absoluteString
        
        //2.2定义一个变量记录当前音效ID
        var soundID = self.cacheDict![path] as! SystemSoundID
        
        //2.3创建音效文件
        if soundID == 0 {
            //如果不存在重新创建
            AudioServicesCreateSystemSoundID(url as! CFURL, &soundID)
            //重新缓存
            self.cacheDict?.addEntries(from: [path  : soundID])
        }
        return soundID
    }
    
}
