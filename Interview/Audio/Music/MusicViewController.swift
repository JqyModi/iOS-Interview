//
//  MusicViewController.swift
//  Interview
//
//  Created by Mac on 2018/3/25.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {
    
    //
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(white: 1, alpha: 0.93)
        // Do any additional setup after loading the view.
        setupUI()
        
        playMusic()
        
    }
    
    private func setupUI() {
        let start = UIButton()
        start.bounds = CGRect(x: 0, y: 0, width: 100, height: 30)
        start.center = self.view.center
        start.backgroundColor = UIColor.lightGray
        start.frame.origin.y = start.frame.origin.y - 40
        start.addTarget(self, action: #selector(self.start), for: .touchUpInside)
        start.setTitle("播放", for: .normal)
        
        let pause = UIButton()
        pause.bounds = CGRect(x: 0, y: 0, width: 100, height: 30)
        pause.center = self.view.center
        pause.backgroundColor = UIColor.lightGray
        pause.addTarget(self, action: #selector(self.pause), for: .touchUpInside)
        pause.setTitle("暂停", for: .normal)
        
        let stop = UIButton()
        stop.bounds = CGRect(x: 0, y: 0, width: 100, height: 30)
        stop.center = self.view.center
        stop.frame.origin.y = stop.frame.origin.y + 40
        stop.backgroundColor = UIColor.lightGray
        stop.addTarget(self, action: #selector(self.stop), for: .touchUpInside)
        stop.setTitle("停止", for: .normal)
        
        self.view.addSubview(start)
        self.view.addSubview(pause)
        self.view.addSubview(stop)
        
    }
    
    @objc private func start() {
        //播放
        player?.play()
    }
    
    @objc private func pause() {
        //播放
        player?.pause()
    }
    
    @objc private func stop() {
        //播放
        player?.stop()
        //手动清零时间
        player?.currentTime = 0
    }

    private func playMusic() {
        //2.1获取音效文件URL
        let url = Bundle.main.url(forResource: "timeclock", withExtension: "wav")
        do {
            //创建播放器
            let player = try AVAudioPlayer(contentsOf: url!)
            self.player = player
            //准备播放
            player.prepareToPlay()
            
        }catch {
            debugPrint(error)
        }
        
    }
    
}
