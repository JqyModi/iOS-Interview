//
//  LocationViewController.swift
//  Interview
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit
import CoreLocation

/**
 *  Desc: 地理定位
 */
class LocationViewController: UIViewController {

    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        locationInCurrent()
    }

    /**
     *  Desc:定位当前位置坐标
     *  Param:
     */
    private func locationInCurrent() {
//        let location = CLLocation()
//        locationManager = CLLocationManager()
        
        //iOS 8.0开始必须代码请求用户授权 + 配置info.plist文件：判断是否存在requestWhenInUseAuthorization方法（表示是否是iOS 8.0）
        if locationManager.responds(to: "requestWhenInUseAuthorization") {
            //请求用户授权：用到时请求/总是请求
            locationManager.requestWhenInUseAuthorization()
//            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        debugPrint("当前位置：locations ==== \(locations.last)")
        //停止更新位置
        locationManager.stopUpdatingLocation()
    }
}
