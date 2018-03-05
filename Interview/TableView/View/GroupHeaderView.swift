//
//  GroupHeaderView.swift
//  Interview
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

protocol GroupHeaderViewDelegate {
    //展开Group代理方法: 代理编写规则：一般至少带一个参数就是控件本身
    func groupHeaderViewGroupDidClicked(groupHeaderView: GroupHeaderView)
}

class GroupHeaderView: UITableViewHeaderFooterView {

    var group: Group? {
        didSet {
            title?.setTitle(group?.name, for: .normal)
            let s = "\(group!.online)" + "/" + "\(group!.friends!.count)"
            online?.text = s
        }
    }
    
    var delegate: GroupHeaderViewDelegate?
    
    var title: UIButton?
    var online: UILabel?
    
    @objc private func groupDidClicked() {
        debugPrint("func --> \(#function) : line --> \(#line)")
        //改变Group中的isVisiable
        self.group?.isVisiable = !(self.group?.isVisiable)!
        
        //点击是不会展开/合上分组：因为只有当数据源改变才会重新调用numberOfRowsInSection方法所有需要刷新TableView
        delegate?.groupHeaderViewGroupDidClicked(groupHeaderView: self)

    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //添加自定义的子控件
        let btnTitle = UIButton()
//        btnTitle.backgroundColor = UIColor.brown
        //设置按钮内容水平左对齐
        btnTitle.contentHorizontalAlignment = .left
        //设置内容与按钮的左边距
        btnTitle.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        //设置按钮文字和图标间距
        btnTitle.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        btnTitle.setImage(UIImage(named: "right_arrow"), for: .normal)
        //设置按钮文字颜色
        btnTitle.setTitleColor(UIColor.gray, for: .normal)
        //设置点击效果
        
        self.title = btnTitle
        
        //添加按钮点击事件
        btnTitle.addTarget(self, action: "groupDidClicked", for: .touchUpInside)
        
        self.addSubview(btnTitle)
        
        let onlineLabel = UILabel()
//        onlineLabel.backgroundColor = UIColor.green
        
        onlineLabel.textAlignment = .center
        self.online = onlineLabel
        
        self.addSubview(onlineLabel)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //当控件的frame改变时调用
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title?.frame = self.bounds
        
        let width: CGFloat = 100
        let height: CGFloat = self.bounds.height
        let x: CGFloat = self.bounds.width - width - 20
        let y: CGFloat = 0
        online?.frame = CGRect(x: x, y: y, width: width, height: height)
        
    }
    
}
