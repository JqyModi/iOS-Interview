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
    
    @IBOutlet var bleView: BLEView!
    
    var cm: CBCentralManager?
    
    //记录需要的外部设备
    var peripheral: CBPeripheral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(patternImage: UIImage(named:"demo_img")!)
        bleView.delegate = self
        
        let xib: BLEView_ = BLEView_()
        xib.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        xib.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        xib.model = "demo_img"
        view.addSubview(xib)
        
        //加载xib创建的View
//        let xib: BLEView_ = Bundle.main.loadNibNamed("BLEView_", owner: nil, options: nil)?.last as! BLEView_
//        xib.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
//        xib.model = "demo_img"
//        view.addSubview(xib)
        
//        let xib: BLEView_ = nibBundle?.loadNibNamed("BLEView_", owner: nil, options: nil)?.last as! BLEView_
//        xib.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
//        xib.model = "demo_img"
//        view.addSubview(xib)
        
//        let nib = UINib(nibName: "BLEView_", bundle: Bundle.main)
//        let views: [UIView] = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
//        let xib = views.last
//        view?.addSubview(xib!)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        bleTest()
//    }

    private func bleTest() {
        //1.初始化蓝牙中心管理者
        cm = CBCentralManager.init(delegate: self, queue: DispatchQueue.main, options: nil)
        
    }
    
    //懒加载
//    private lazy var bleView: BLEView = {
//        let b = Bundle.main.loadNibNamed("BLEView", owner: nil, options: nil)?.last as! BLEView
//        b.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        b.backgroundColor = UIColor.orange
//        b.delegate = self
//        return b
//    }()
}

extension BLEViewController : CBCentralManagerDelegate, CBPeripheralDelegate, BLEViewDelegate {
    
    //MARK: - CBCentralManagerDelegate
    @objc func findPeripheral() {
        debugPrint("func --> \(#function) : line --> \(#line)")
        bleTest()
    }
    
    //MARK: - CBCentralManagerDelegate
    //2.初始化完成调用代理中的centralManagerDidUpdateState更新状态
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        debugPrint("func --> \(#function) : line --> \(#line)")
        
        switch central.state {
        case .unknown:
            debugPrint("centralManagerDidUpdateState --> 状态 : unknown")
            break
        case .resetting:
            debugPrint("centralManagerDidUpdateState --> 状态 : resetting")
            break
        case .unsupported:
            debugPrint("centralManagerDidUpdateState --> 状态 : unsupported")
            break
        case .unauthorized:
            debugPrint("centralManagerDidUpdateState --> 状态 : unauthorized")
            break
        case .poweredOff:
            debugPrint("centralManagerDidUpdateState --> 状态 : poweredOff")
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
        debugPrint("********************* central --> \(central) ||||| peripheral --> \(peripheral) ||||| advertisementData --> \(advertisementData) ||||| RSSI --> \(RSSI) *********************")
        //5.过滤需要的蓝牙外设：通过名字前缀+信号强度过滤
        if peripheral.name == "mb_0cao0Nv5" && abs(RSSI.intValue) > 40 {
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
        //10.设置已经链接的外设的代理事件
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    //MARK: - CBPeripheralDelegate
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        debugPrint("didDiscoverServices ---> \(error)")
    }
    
}
