//
//  AudioViewController.swift
//  Interview
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit
//1.导入框架
import AVFoundation


class AudioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        playAudio()
        //2.1获取音效文件URL
        let url = Bundle.main.url(forResource: "timeclock", withExtension: "wav")
        AudioTools.shared.palySystemSoundWithURL(url: url!)
    }
    
    //点击播放音效
    private func playAudio() {
        debugPrint("准备播放音效文件")
        //2.创建音效文件
        //2.1获取音效文件URL
        let url = Bundle.main.url(forResource: "timeclock", withExtension: "wav")
        //2.2定义一个变量记录当前音效ID
        var soundID = SystemSoundID()
        //2.3创建音效文件
        let audio = AudioServicesCreateSystemSoundID(url as! CFURL, &soundID)
        
        //3.播放音效文件
        AudioServicesPlaySystemSoundWithCompletion(soundID) {
            debugPrint("音效播放完成 ~")
            //释放音效
            debugPrint("soundID释放前 ---> \(audio)")
            AudioServicesDisposeSystemSoundID(soundID)
            debugPrint("soundID释放后 ---> \(audio)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        debugPrint("didReceiveMemoryWarning")
        //局部清理
        AudioTools.shared.clearCache()
    }

}
