//
//  FriendTableViewCell.swift
//  Interview
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    var friend: Friend? {
        didSet {
//            setupData()
        }
    }
    
    static func cellWithTableView(tableView: UITableView) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ID")
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "ID")
        }
        return cell!
    }
    
    
//    private func setupData() {
//        self.imageView?.image = UIImage(named: (friend?.icon!)!)
//        self.textLabel?.text = friend?.nick
//        self.detailTextLabel?.text = friend?.qm
//    }
}
