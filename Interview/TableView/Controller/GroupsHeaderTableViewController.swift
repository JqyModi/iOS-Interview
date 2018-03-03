//
//  GroupsHeaderTableViewController.swift
//  Interview
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class GroupsHeaderTableViewController: UITableViewController {

    //定义模型数据
    var groups: [Group]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        setupData()
        
        //设置TableView行高
        tableView.rowHeight = 60
        //设置Group高度
        tableView.sectionHeaderHeight = 44
    }

    private func setupData() {
        let bundle = Bundle.main
        let path = bundle.path(forResource: "friends.plist", ofType: nil, inDirectory: "")
        let array = NSArray.init(contentsOfFile: path!)
        debugPrint(array)
        
        var arr = NSMutableArray()
        for item in array! {
            let group = Group(dict: item as! [String : Any])
            arr.add(group)
        }
        self.groups = arr as! [Group]
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (self.groups?.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let s = self.groups![section]

        //根据当前组被点击状态来控制是否展开(其实就是是否返回对应的数据条数)分组操作
        var count: Int = 0
        if s.isVisiable {
            count = (s.friends?.count)!
        }
        return count
    }
    
    //MARK: - Table View delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = FriendTableViewCell.cellWithTableView(tableView: tableView)
        
        let group = self.groups![indexPath.section]
        
        let friend = group.friends![indexPath.row] as! Friend
        cell.imageView?.image = UIImage(named: friend.icon!)
        cell.textLabel?.text = friend.nick
        cell.detailTextLabel?.text = friend.qm
        return cell
    }
    
    //通过该方法可以设置分组栏View的样式
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //为了重用该分组View可以通过重写系统的: UITableViewHeaderFooterView(reuseIdentifier: "ID") 来指定重用标识
        //UITableViewHeaderFooterView也是继承至UIView
        
        //开始创建的GroupHeaderView没有指定frame但是我们可以看到GroupHeaderView已经有frame，原因是当tableView用到GroupHeaderView时系统会根据设置的tableView.sectionHeaderHeight = 44来设置GroupHeaderView的frame
        let v = GroupHeaderView(reuseIdentifier: "ID")
        //为组设置一个tag用来标记被点击的组
        v.tag = section
        v.delegate = self
        v.group = self.groups?[section]
        
        return v
    }
    
    //设置分组的高度
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let group = self.groups![section]
//        return group.name
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        testRandom()
    }
    
    //测试随机数
    func testRandom() {
        let r = arc4random_uniform(10)
        debugPrint("r = \(r)")
        
        let r1 = arc4random() % (10 + 1)
        debugPrint("r1 = \(r1)")
        
        //UIPickerView的用法：跟UITableView的用法一样
//        let picker = UIPickerView()
        //表示第0组选择的行索引
//        picker.selectedRow(inComponent: 0)
        
        //显示应用程序图标上的数字
        let app = UIApplication.shared
//        app.alternateIconName = "SIRI"
        
        //IOS8.0后使用必须注册通知：registerUserNotificationSettings
        let set = Set<UIUserNotificationCategory>.init(arrayLiteral: UIUserNotificationCategory())
        let userNotificationSettings = UIUserNotificationSettings(types: .badge, categories: set)
        app.registerUserNotificationSettings(userNotificationSettings)
        
        app.applicationIconBadgeNumber = 10
        app.isNetworkActivityIndicatorVisible = true
        
        app.isStatusBarHidden = true
    }
    
}

extension GroupsHeaderTableViewController: GroupHeaderViewDelegate, UIPickerViewDelegate {
    func groupHeaderViewGroupDidClicked(groupHeaderView: GroupHeaderView) {
        //点击按钮时需要重新刷新TableView才会调用numberOfRowsInSection方法以实现分组展开与合上效果
//        tableView.reloadData()
        //直接tableView.reloadData会浪费内存资源：采用只刷新某个组的方式刷新TableView
        
        //NSIndexSet表示某一组：通过创建组时标注tag来创建一个组对象
        let indexSet = NSIndexSet(index: groupHeaderView.tag)
        //局部刷新某一组
        tableView.reloadSections(indexSet as IndexSet, with: .automatic)
        
//        testRandom()
    }
}
