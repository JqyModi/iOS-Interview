//
//  BLEViewController.swift
//  Interview
//
//  Created by mac on 2018/2/6.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit
import GameKit
import CoreBluetooth
import MultipeerConnectivity

class BLEViewController: UIViewController {

    var cm: CBCentralManager?
    
    //记录需要的外部设备
    var peripheral: CBPeripheral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(patternImage: UIImage(named:"demo_img")!)
        
        //添加View
        view.addSubview(bleView)
        bleView.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bleTest()
    }

    private func bleTest() {
        //1.初始化蓝牙中心管理者
        cm = CBCentralManager.init(delegate: self, queue: DispatchQueue.main, options: nil)
        
    }
    
    //懒加载
    private lazy var bleView = BLEView()
}

extension BLEViewController : CBCentralManagerDelegate, CBPeripheralDelegate, BLEViewDelegate {
    
    //MARK: - CBCentralManagerDelegate
    func findPeripheral() {
        debugPrint("func --> \(#function) : line --> \(#line)")
    }
    
    //MARK: - CBCentralManagerDelegate
    //2.初始化完成调用代理中的centralManagerDidUpdateState更新状态
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        debugPrint("func --> \(#function) : line --> \(#line)")
        
        switch central.state {
        case .unknown:
            break
        case .resetting:
            break
        case .unsupported:
            break
        case .unauthorized:
            break
        case .poweredOff:
            break
        case .poweredOn:
            debugPrint("func --> 开启状态 : line --> \(#line)")
            //3.搜索(扫描)外部设备
            cm?.scanForPeripherals(withServices: nil, options: nil)
            break
        default:
            break
        }
    }
    
    //4.发现外部设备
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        debugPrint("||||| central --> \(central) ||||| peripheral --> \(peripheral) ||||| advertisementData --> \(advertisementData) ||||| RSSI --> \(RSSI) |||||")
        //5.过滤需要的蓝牙外设：通过名字前缀+信号强度过滤
        if peripheral.name == "Amazfit Cor" && abs(RSSI.intValue) > 40 {
            //6.记录当前需要的外设
            self.peripheral = peripheral
            //7.停止扫描外设
            cm?.stopScan()
            //8.链接该外设
            cm?.connect(self.peripheral!, options: nil)
            
        }
    }
    
    //9.链接成功调用
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        debugPrint("central --> \(central) : peripheral --> \(peripheral)")
        debugPrint("外设链接成功")
    }
    
    //MARK: - CBPeripheralDelegate
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
    }
    
}
