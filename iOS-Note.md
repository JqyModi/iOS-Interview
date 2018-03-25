## 开启aria2c服务：aria2c --enable-rpc --rpc-listen-all

## 在线思维图制作：https://www.processon.com/diagrams

## Mac开启任何来源：sudo spctl --master-disable

## Git恢复提交： 用 git reflog  找到commit id  然后在git reset —hard 7517adb(commit id)

## 代码格式化：Ctrl + i

## MarkDown编辑器：MacOS+Windows: http://pad.haroopress.com/user.html#download

[Markdown](http://pad.haroopress.com/user.html#download)

# 学习基础语法及UI界面控件
# 熟悉项目框架结构
# 修改BUG
    1.点击我的收藏－>打开收藏分类－点击其中任意一个Item－返回－进入同步视频或仿真试验－点击其中任意一个下拉项－程序崩溃    －－解决
    2.仿真试验模块右上角搜索功能－数据接口错误        －－解决
    3.所有界面的分类排序无效    －－解决
    4.主页布局及Item样式修改    －－解决
    5.程序登录模块无效        －－解决
    6.清理缓存数据手机有效平板崩溃        －－解决
    7.平板启动页面图片大小尺寸不合适        －－待解决
    8.注册模块无效        －－解决
    9.重置密码模块无效        －－解决
    10.浏览记录模块无效        －－待解决
    11.是否收藏显示错误        －－解决
    12.列表分割线主题统一    －－待完善
    13.分享功能无效        －－待解决
    14.当网络情况不理想的情况下登录界面弹出延缓此时用户多次点击会生成多个登录页        －－待解决
    15.我的收藏模块加载数据无限重复    －－解决
    16.


# 经验积累：
    1.导入第三方库：
        1.1 pod之后重新打开项目之后一定要clean后再build否则会找不到刚刚安装的库
        1.2 因为很多三方库都是用OC写的故导入时需要新建一个桥接文件：bridging.h来引入第三方库中的.h头文件才可以进行使用:
         1.2.1 新建一个名字为bridging.h的头文件
         1.2.2 在配置文件中加入XXX/bridging.h路径：XXX-Build Settings-Swift Compiler - Code Generation-Objective-C Bridging Header-XXX/bridging.h
    2.self.presentViewController(…)以model形式跳转一个界面：先执行待跳转controller的ViedDidLoad方法再执行跳转动作 ：而pushViewController的方式是:先执行pushViewController(…)操作再执行界面的操作如：ViewDidLoad(...)
    3.LeanCloud中数据查询时如果一个表中包涵另一个表的指针直接查询出来是没有数据的只有指向该表的指针：若需要直接带数据查询需要加上incloudkey(keyname)
    4.swift中网络请求默认使用https：若要支持http则需要在XXX/info或者info.plist中添加App Transport Security Settings-Allow Arbitrary Loads-YES
    5.将swift 2.x 导入Xcode8/swift 3.x中时注意：
        1.根据提示选择convert - to swift 3.0 - .app - save
        2.若出现Alamofire报错则需要在pod中加入pod "Alamofire”更新到新版本
        3.若出现Use Swift Leagcy …/ …. ：解决方式：XXX - Build Settings - 搜索swift_version - 修改swift_version版本到3.0或者将Use Legacy swift.. 改为YES:表示允许使用低版本
        4.clean-build
    6.导入第三方字体：
        1.新建一个resource文件夹将字体复制到项目中
        2.在XXX-info中添加Font provided by application-Array类型下添加一个item-XXX.ttf
        3.在代码中通过:xxx.font = UIFont(name: fontName, size: 15)的方式设置字体样式:fontName表示改字体对应的英文名称：可以通过let arr=UIFont.familyNames();print(arr)来获取字体名称都有哪些
    7.可视化界面编程：
        1.storyboard:
            1.新建一个xxx.storyboard文件并设计出理想效果
            2.在右侧显示属性中找到：show the identity inspector-Custom Class中绑定一个文件中新建的xxxViewController(如：LoginViewController)并在Identity中为Storyboard设置一个ID如Login
            3.为界面添加约束等
            4.通过代码操作storyboard：
            //先获取storyboard
            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            //在可视化布局界面中设置Identifier = Login
            let loginVC = loginStoryboard.instantiateViewController(withIdentifier: "Login")
            self.present(loginVC, animated: true, completion: {
            print("跳转到登录页")
            })
        2.xib:
            1.新建一个XXX.xib文件如InputView.xib
            2.设计控件界面
            3.通过代码关联改xib：
            //初始化输入框控件:通过xib初始化一个控件(.last)
            self.commentInput = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)?.last as! InputView
            self.commentInput?.frame = CGRect(x: 0, y: SCREEN_HEIGHT-44, width: SCREEN_WIDTH, height: 44)
    8.界面跳转中数据传递方式:
        1.delegate：相当于安卓中的接口回调
            1.在带跳转的控制器中定义一个delegate及需要的方法
            2.声明delegate实例对象
            3.在该回调的地方回调该delegate中的方法并将需要的参数传递过去
            4.在跳转的控制器中实现该delegate获取回调数据
            5.PS:
            1.在定义一个delegate时可以在前面加上@objc表示用OC方式来定义一个delegate区别在于delegate中的方法可以设置为Optional的
            2.使用delegate很容易造成内存泄漏: 需要在声明时将delegate声明为一个weak类型的而swift中不支持直接设置为weak还需要将该delegate继承至class才可以进行此操作
        2.闭包/Block
            1.在待跳转控制器定义一个闭包：Block
            typealias Push_titleCallBack = (_ title: String) ->Void
            2.声明一个闭包回调：callback
            var callback: Push_titleCallBack?
            3.返回时通过callback回调返回数据:调用的时候需要实现该callback否则会报错
            self.callback!((self.tf?.text)!)
            4.在跳转处实现Block获取到下一页面传回的数据
            tc.callback = {(type: String, detialType: String) in
            print("type = \(type)")
            }
        3.NSNotification：通知:类似安卓广播
            1.发送通知操作:发送一个通知并将需要数据传递过去通过userinfo或者object
            NotificationCenter.default.post(name: Notification.Name(rawValue: "pushBookNotification"), object: nil, userInfo: ["success" : true])
            2.注册一个通知用来接收书评是否上传成功:跟添加点击事件类似
            NotificationCenter.default.addObserver(self, selector: #selector(pushNewBookController.pushBookNotification(_:)), name: NSNotification.Name(rawValue: "pushBookNotification"), object: nil)
            3.响应通知
            func pushBookNotification(_ notify: Notification){…}
            4.在deinit中移除通知
            //移除通知：不移除可能会使通知响应多次操作程序崩溃:移除对象上的所有通知:也可以按name来移除相对应的通知
            NotificationCenter.default.removeObserver(self)
    9.内存管理：
        1.在主控制器中进行内存泄漏检测：在析构函数deinit中输出log日志看是否有输出若输出则表示内存已经释放否则内存泄漏
        2.内存泄漏原因：
            1.delegate中使用self关键字导致控制器无法释放：将delegate设置成weak类型
            2.闭包中使用了self关键之导致控制器无法释放：将callback设置成weak：swift不存在这个原因：OC存在
            3…
    10.代码重构：
        1.工厂模式：将重复而具有相似操作的代码段封装成一个方法替换需要的地方：传入不同类型的参数几个生成不同的对象或返回目标值
        2.
    11.MVC模式：M、V、C
    12.调用系统相机相册：
        func photo(){
        //判断相机是否存在
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
        //开始调用相机拍照
        self.picker?.sourceType = UIImagePickerControllerSourceType.camera
        //跳转到系统相机界面：打开相机
        self.present(self.picker!, animated: true, completion: {
        print("打开相机回调")
        //
        })
        }else{
        //弹窗告诉用户相机不存在
        let alert = UIAlertController(title: "", message: "相机不可用", preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) in
        print("相机不可用弹窗回调")
        //关闭该弹出窗体
        self.dismiss(animated: true, completion: {
        print("关闭当前弹窗")
        })
        }))
        self.present(alert, animated: true, completion: {
        print("相机不可用跳转回调")
        })
        }
        }

        func gallery(){
        //打开相册
        self.picker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //跳转到系统相册：打开相册回调
        self.present(self.picker!, animated: true) {
        print("打开相册回调")
        }
        }
        //通过实现委托事件获取图片
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("获取图片")
        //通过该字符数组获取图片:强转成UIImage
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        //关闭图片选择界面
        self.picker?.dismiss(animated: true, completion: {
        print("关闭相册选择完成回调")
        self.dismiss(animated: true, completion: {
        print("关闭相册界面回调")
        //通过事件委托方式将选中的相片发送给pushNewBook...界面
        self.delegate?.getPhoto(img)
        })
        })

        }
        //当选择完成或者取消图片选择时回调
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("相册选择完成或者取消选择回调")
        self.picker?.dismiss(animated: true, completion: {
        print("关闭相册选择完成回调")
        self.dismiss(animated: true, completion: {
        print("关闭相册界面回调")
        })
        })
        }
    13.处理键盘遮挡：
        1.注册键盘显示隐藏通知
        2.获取键盘frame大小
        3.键盘弹出时将UI视图的bottom上移至键盘顶部top : PS:需要设置self.view.layoutIfNeeded()使UI视图一帧一帧上移：若使用storyboard作为界面时可以为约束添加一个上移动化使UI视图上移
        4.实例代码：
        /**
        * 响应键盘事件
        * keyboardWillShowNotification
        */
        func keyboardWillShowNotification(_ notify: Notification){
        UIView.animate(withDuration: 0.3, animations: {
        print("开始执行动画")
        //将约束设置为-200,则界面会上移，需要将上移过程变慢用以下操作layoutIfNeeded():一帧一帧上移界面：动画
        self.topLayout.constant = -200
        self.view.layoutIfNeeded()
        })
        }



# 考试系统
    1.如何动态计算UILabel的高度：
        1.1 label字符串
            let s = NSString(string: "string")
        1.2 Label的大小限制
            let size = CGSize(width: 100, height: 100)
        1.3 Label大小的计算方式
            let options = NSStringDrawingOptions.usesLineFragmentOrigin
        1.4 设置字体大小、字体类型等
            let attributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        1.5 通过NSString的boundingRect方法计算出字符串对应矩形的宽高
            let strSize = s.boundingRect(with: size, options: options, attributes: attributes, context: nil).size

    2.自动布局中如何动态调整控件的相对位置:通过可视化界面为需要调整的控件添加约束并在代码中添加约束变量，然后通过改变约束变量的值来改变控件的相对位置

    3.如何处理viewpager中页面的上下滚动与viewpager的左右滑动的冲突？？

    4.NSMutibaleDictionary存储数据时key唯一性：覆盖原有的值：不想被覆盖可以写成局部变量

    5.隐藏键盘操作：resignResponse。。。



# Objective-C
    1. .h / .m文件 : .h头文件用来定义对应.m类中应该有的变量及方法, .m文件实现.h中定义的方法，调用时只要导入.h文件即可

    2.    成员变量及成员方法的定义：@interface xxx ｛//定义成员变量｝//定义成员方法区 @end :PS: 普通方法[构造方法属于普通方法]前加－／类方法前加＋

    3.    . 点语法：通过点语法操作变量其实是通过调用get/set方法来操作成员变量

    4.    类别：category: 与 继承的区别：
    1.相同点：当原来的类无法满足需求是需要扩展
    2.不同点：继承中可以扩展变量跟方法［一般用在自定义时，需要新增大量变量］，类别只能扩展方法［一般用在扩展系统内库方法：如为NSString扩展一些方法］

    5.    %@格式化输出OC中的字符串

    6.    字符串与基本数据类型间的转换

    7.




# 项目预设：学习笔记回忆录：安卓－IOS
    1.网络链接视频播放器支持快进播放带声音



# 数字书法：
    1.viewController以push方式呈现时用popViewController关闭；以present方式呈现时用dismiss关闭
    2.设置cell阴影效果：
        self.layer.cornerRadius = 10;
        self.contentView.layer.cornerRadius = 10.0;
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true;

        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 4.0;
        self.layer.shadowOpacity = 0.5;
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath





# 运行循环：
    1.RunLoop：每个线程都有一个RunLoop来负责事件监听【触摸、时钟、网络】
    CFRunLoopStop(runloop)
    CFRunLoopStart()
    CFRunLoopGetCurrent()


# OC属性修饰符关键字：atomic原子属性/nonatomic 非原子属性
    1.原子属性特点：多线程情况下：原子属性在同一时刻只能有一个线程能对该属性赋值操作，读取都可以：系统默认会给setter方法加一把锁：自旋锁：并不能保证线程安全
    2.非原子属性特点：多个线程可以同时读取、赋值

    多线程：同步锁(互斥锁): synchronized(锁对象){代码块} ：每个对象都有一把锁，默认开着: 等待执行时会休眠而自旋锁不会休眠一直访问当前锁状态

    ARC/MRC：手动管理内存（原则：谁创建谁释放：自动释放池：autorelese：延时释放，释放前会向所有对象发送消息）

    线程池：好处：自动管理线程生命周期（创建-调度-销毁），复用线程避免频繁创建和销毁线程


# 消息循环：每个线程都有一个消息循环，主线程默认开启，子线程默认关闭（需要手动开启）
    1.创建消息
    2.将消息放入循环，并指定消息运行模式
    3.在与循环运行模式匹配时消息(事件：输入源&时钟源)才能运行
    4.疑问：NSTimer使用时没看到需要加入到运行循环中？？

# GCD(Grand Central Dispatch（调度）): 优化了多核下多线程执行效率，GCD = queue （队列：拥有多个任务待CPU调度执行）+ task（待执行的代码）
    1. 串行(Seiral)队列同步执行：不开启新的线程，在当前线程下（主线程）有序执行
    2.   串行(Seiral)队列异步执行：开启一个新的线程，在新开的线程下有序执行
    3.   并行(Concurrent)队列同步执行：不开启新的线程，在当前线程下（主线程）有序执行 = 1 中情况
    4.   并行(Concurrent)队列异步执行：开启多个新的线程，在多个线程下无序执行，效率最大
    5.   主队列（main）同步执行：线程死锁 ！！！
    6.   主队列（main）异步执行：在主线程顺序执行

## 全局队列（global）：创建需要两个参数：dispatch_queue_create_global(0,0) ：第一个表示优先级：ios8之后改成QoS，第二个是预留参数
    
## GCD: 只执行一次：通常用来创建单例：dispatch_once(&onceToken, block{…}) ：onceToken代表一个静态区的数字，线程安全：多线程环境下也只执行一次

# 延时执行：
    方式1：Timer：定时器
    方式2：NSThread的隐式延时方式：perform(<#T##aSelector: Selector##Selector#>, with: <#T##Any?#>, afterDelay: <#T##TimeInterval#>)
    方式3：GCD：dispatch_after(*,*,*) ：异步执行，进度高：精确到纳秒

# NSOperation(Operation) : 操作多线程与GCD类似：是GCD的封装（函数式），面向对象编程
    1.创建操作：NSInvoOperation/BlockOperation
    2.创建队列：OperationQueue：
    3.将操作添加到队列中：自动执行不需要调用start方法

## 线程间通信：主线程操作UI：OperationQueue.MainQueue.addblock...

## 图片缓存：将图片缓存到内存中：用一个字典(键值对方便存取)等存起来，当用时直接加载：用空间换取执行时间

## ：当图片下载速度过慢时可能会出现由Cell复用导致图片更新错行问题：解决方式：当图片下载完成更新对应的Cell：tableview.reloadRows....

## 缓存图片到内存中时：可能会出现内存警告⚠️：需要清理内存：手动创建一个缓存池：用字典存储：方便存取

## UITableview开启子线程下载图片时：在图片还没下载完成时不停拖动Cell列表可能会出现重复添加下载任务操作：需要将下载任务操作也缓存起来：下载前先判断是否已经添加到操作缓存池中：收到内存警告时也需要情况缓存

## block中使用self是否会出现循环引用？：分析是否会循环引用：解决循环引用：或者[weak self]

## 图片三级缓存：首先将图片缓存到内存中（用户启动之后无需重复加载）- 将图片保存到沙盒的Cache目录下（用户再次启动APP无需重复下载图片：直接从沙盒中读取图片并缓存到内存中）- 如果缓存和沙盒中都没有图片则从网络下载图片并缓存到内存及沙盒中

## 将可变数组转不可变数组：NSMutableArray().copy()

# 运行时设置UITextView提示文本控件
    1. fillBlank.setValue(placeHolderLabel, forKeyPath: "_placeholderLabel")

# PS: SnapKit + Cell：自动布局
    1.自定义Cell：重写init：design初始化方法：setupUI:懒加载控件
    2.添加控件到contentView：添加布局约束：
    3.自动布局：需要给BottomView添加底部约束
    4.设置Controller自动布局：//1.设置估计值
    tableView.estimatedRowHeight = 400
    2.设置自动计算
    tableView.rowHeight = AutomaticDimension

# 键盘遮挡问题：上移布局：view.frame.y = …

# 1125 * 2436 iPhone X 启动图

# OC：分类中不能增加成员变量但是可以增加一个属性：必须重写get/set方法

# 联合对象：AssociatedObject : 运行期间给某个对象增加属性

# 运行时：
    1.可以在运行时给某各类增加属性
    2.可以在运行时获取某个对象所有属性名称
    3.交换方法

# NSCache: 缓存机制：
    1.内存不足自动释放：需要判断空
    2.内存安全
    3.可以设置缓存（池）大小和数量

## PS：当收到内存警告后调用了NSCache对象的removeAllObject方法后系统会标记该NSCache对象，不能再往里面存储，但一般情况下调用removeAllObject还是可以继续使用该对象存储

# Swift3输出对象地址：
    方式一：debugPrint(unsafeBitCast(immutableArr, to: UnsafeRawPointer.self))
    方式二：debugPrint(Unmanaged.passUnretained(immutableArr).toOpaque())

# UIView不能与用户交互的三种情况：
    1.UIView的透明度小于0.01时控件不能响应事件
    2.设置控件的isUserInteractionEnabled为false时不能响应事件
    3.设置控件的isHidden为true时不能响应事件
    4.子控件超出了父控件的显示范围：UIView的Clip to Bounds 属性是否勾选

# 蓝牙开发：
1.可用框架：GameKit

# 通过xib方式创建自定义View：
    1.新建一个Empty文件
    2.拖一个UIView到界面上并在属性设置中设置Size为Freefrom：即可以自由修改大小
    3.布局View界面
    4.代码加载该xib创建的View
        - 方式1：
        //let xib: UIView = Bundle.main.loadNibNamed("BLEView_", owner: nil, options: nil)?.last as! UIView
        //view.addSubview(xib)
        - 方式2：
        //let xib: UIView = nibBundle?.loadNibNamed("BLEView_", owner: nil, options: nil)?.last as! UIView
        //view.addSubview(xib)
        - 方式3：
        //let nib = UINib(nibName: "BLEView_", bundle: Bundle.main)
        //let views: [UIView] = nib.instantiate(withOwner: nil, options: nil) as! [UIView]
        //let xib = views.last
        //view?.addSubview(xib!)
    5.若需要为View上面控件赋值：
        1.创建一个对应ViewClass并在属性设置中设置class为ViewClass
        2.通过拖拽方式将view上控件与ViewClass的一个属性关联
        3.通过模型类属性的赋值方法给控件赋值
    6.初始化代码封装到自定义View本身类中：
        1.写一个类方法将通过xib创建好的View返回

# instancetype与id类型区别：
    1.前者只能作为方法返回值：表示当前类的类型
    2.id指向任何类的类型
    
# UIScrollView实现喜马拉雅滚动效果(当滚动区域滚动到头部或者尾部时穿透效果)：
    1.拖入一个全屏的ScrollView并设置好内部布局
    1.1设置scrollView的contentSize
    2.将头部视图拖到scrollView的上面并设置透明度为0.6
    3.将底部视图拖到scrollView上并设置透明度为0.6
    4.设置scrollView的contentoffset和底部contentInset

# UIScrollView实现轮播器效果：
    1.设置好scrollView的大小及位置
    2.添加内部代表page的View并设置好frame
    3.设置scrollView的contentSize保证可用滚动
    4.设置分页属性：isPagingEnable = true
    5.设置pageControl在scrollView上大小及位置
    6.通过scrollView的contentoffset计算出当前页码并设置给pageControl
    7.通过let offsetX = scrollView.contentOffset.x + scrollView.frame.width * 0.5处理计算出页码效果较好：当滑动操过一半就跳到下一页
    8.通过定时器实现自动跳转：
        8.1.NSTimer:(时间间隔大于1秒)
        8.2.CADisplayLink:(时间间隔小于1秒)
    PS: scrollView分页依据是scrollView自身frame的大小，故每个page的大小最好一致否则出现分页不完整
    
# 应用程序图标+启动图片：@2x,@3x
    1.非视网膜屏幕：iPhone 3gs
        1.1 物理尺寸3.5英寸，点阵：320*480 分辨率(像素点)：320*480
    2.视网膜屏幕：retina：iPhone 4以上
        2.1 4/4S物理尺寸3.5英寸，点阵：320*480 分辨率(像素点)：640*960
        2.2 5/5C/5S 物理尺寸4英寸 点阵：320*588 分辨率(像素点)：640*1136
        2.3 6物理尺寸4.7英寸 点阵：375*667 分辨率(像素点)：750*1334
        2.4 6Plus物理尺寸5.5英寸 点阵：414*736 分辨率(像素点)：1242*2208
    3.分辨率：把屏幕进行横向和纵向等分所得
    4.在retina屏幕下一个点表示2个像素：@2x,在非retina屏幕下一个点表示一个像素，在plus下一个点表示3个像素：@3x
    
# 设置应用程序图标+启动图片：
    1.图标设置：直接在AppIcon中添加图标图片
    2.启动图片设置：
        2.1 使用LaunchScreen.storyboard/xib方式：（默认）
            2.1.1 内部原理也是将LaunchScreen.storyboard/xib运行时效果截图作为启动图片
        2.2 直接使用图片作为启动图：Use Asset Catalog -> Migrate -> LaunchImage（拖拽图片到此处）-> 删除原来默认的LaunchImage引用
    PS：控制器大小会根据启动图的大小来最终确定，当启动图中最大的启动图比预先设置的控制器大小要小时控制器大小等于启动图中最大尺寸那张图的大小：会引起一些UI控件错位问题：解决这一问题：将对应设备启动图补全
    
# 添加右侧索引栏（类似通信录中的字母索引）：
    1.实现sectionIndexTitlesForTableView方法返回对应的索引标签
    2.tableView.separatorInset在iOS8中无效？？
    
# UIAlertView带输入框显示：
    1.设置alertViewStyle为plainTextInput
    2.通过textFieldAtIndex获取弹出框中指点View控件
    
# Cell:
    1.通过xib方式实现：
        1.0 为每个Cell设置一个Identifier可重用标识
        1.1 通过xib搭建好界面并设置好Identitfier:相当于reuseIdentitfier来重用通过xib创建的Cell
        1.2 通过NSBundle来加载xib文件得到Cell对象
        1.2.1 没有可重用Cell则新建一个Cell并制定可重用的标识Identifier
        1.3 将1.2步骤封装到自定义Cell类中方便代码实现Cell时的修改
        1.4 将Cell设置给TableView
    2.通过代码方式实现：
        2.0 为每个Cell设置一个Identifier可重用标识
        2.1 先通过设置的ReuseIdentifier到缓存池中找可重用的Cell
        2.1.1 重写Cell的InitWithIdentitfier初始化方法来添加内部自控件
        2.2 没有可重用Cell则新建一个Cell并制定可重用的标识Identifier
        2.3 将获取到Cell设置给TableView
    3.动态计算TableViewCell行高：
        1. 新建一个CellFrame模型用来记录Cell中所有控件的Frame和Cell的行高
        2. 在CellFrame中给Model模型赋值时计算出所有子控件及可变控件(UILabel)的Frame，再通过最底部子控件 + margin 计算出行高rowHeight
        3. 在控制器中将计算好的CellFrame对象赋值给Cell对象
        4. 在Cell中加载CellFrame作为模型对象
        5. 在CellFrame模型对象赋值时设置Cell子控件的数据及计算好的Frame
        6. 通过CellFrame对象在控制器中的代理事件heightForRowAtIndexPath方法返回行高给Cell
    4.Cell通过系统提供的Controller中自带模板Cell实现
        4.1 在storyboard中Controller自带的模板Cell中指定Identifier
        4.2 在 CellForRow代理方法中通过模板中指定的identifier到缓存池中取Cell不需要再次判断缓存池中是没有Cell的情况，如果没有系统会自动通过模板中指定的identifier创建对应的Cell返回
        
### TableView中FootView只能修改X和Hight 若需要自定义可变样式View可以放一个容器View修改内部View即可

### UITableView在IOS8.0后通过系统代理方法editActionsForRowAtIndexPath即可实现Cell侧滑操作响应一个或多个按钮操作,8.0之前用JASwipeCell框架也可以实现

### 判断类是否实现了某个方法用respondsToSelector

### TableView局部刷新只适用于数据源条数没有发生变化情况

# 代理编写规范：
    1.定义方法：至少传递一个参数就是当前View本身
    2.命名应该以控件名称开头 + 该方法所实现功能
    
### 自定义View中当需要操作内部某个子控件是需要在awakeFromNib方法之后操作：所有子控件已经初始化完毕

# 拉升图片：平铺方式拉升
    1.通过UIImage的stretchableImageWithLeftCapWidth...TopCapHight方法来拉升图片：该方法会按照设置的距离左边的距离和距离上边的距离来平铺拉升图片

# 处理键盘弹出时控制器View的上移操作：
    1.通过键盘键盘广播：UIKeyboardWillChangeFrameNotification来响应键盘弹出和隐藏时的操作
    2.通过计算键盘弹出后的Y值来确定控制器View需要上移的距离：键盘高度 - 屏幕高度 = 负值 (正好是控制器View需要上移的高度，也是负值，当键盘隐藏时该值是0控制器View正好回到原点：巧妙解决了键盘弹出时遮挡问题)
    3.通过view的transform属性平移View即可
### 隐藏键盘另一种方式：将所有的View结束编辑：view.endEditing

### 当给UIButton设置背景图片后再设置文件过长情况下文字会超出所设置的背景图片效果（比如QQ聊天气泡效果）：
    1.先给UIButton及UIButton的textLabel设置背景色
    2.以平铺的方式拉升图片（背景）使得设置好的气泡背景不至于变形
    3.放大UIButton以包裹文字
    4.若第3步操作还是没有解决则需要给UIButton的textLabel加上内边距来解决
       
## 通过代理和通知都可以实现对象间通信：
    1.区别代理是一对一的
    2.通知（相当于广播）多对多的
    
# 实现分组效果且分组不仅仅包含标题文字还包含其他View控件：
    1.通过实现tableView的代理方法ViewForHeaderInSection来重新定义Group的样式效果
    2.为了可以重用每个相同样式的分组可以用系统的HeaderFooterView来取代UIView（继承关系）
    3.为了实现自定义的Group效果则重新自定义一个HeaderFooterView来初始化时添加内部UI控件
    4.通过一个类方法将创建HeaderFooterView及重用标识等封装到该自定义HeaderFooterView中
    4.1重写HeaderFooterView的initWithReuseIdentifier方法来返回自定义的HeaderFooterView
    4.2设置内部自定义子控件的frame
    5.将自定义的HeaderFooterView设置给tableview
    
### 获取当前屏幕的Window窗口：UIApplication.share.keyWindow
    
## 屏幕适配：
    1.autoresizing ：用父容器作为 参照 来设置子控件的frame的屏幕适配
    1.1 通过代码实现autoresizing：
        1.1.1 去掉系统默认勾选的autolayout + size classes
        1.1.2 通过代码的autoresizingMask来设置约束：多个同时作用用或(| 因为autoresizingMask是一个位枚举)
    2.autolayout ：不仅仅可以设置控件与父控件的参照规则，也可以设置控件与控件之间的参照规则
    3.size classes + autolayout : 可以在不同尺寸的屏幕下设置不同的约束规则
    4.设置好屏幕适配规则后可以在辅助编辑器中的导航条处找到preview来预览各个屏幕下的显示效果不再需要一个一个设备去运行
    5.Xcode6开始设置距离左右的约束时默认系统加入了margin = 16解决这个问题：
        5.1 勾选掉constrain to margins
        5.2 将左右边距该为0
    6.当设置上下左右边距约束时需要注意设置的参照时距离控制器的距离还是距离上下导航条的距离
    7.案例解决方案：一个游戏图片上面有设计好的按钮：要使点击图片上的按钮位置有响应
        7.1 可以用透明的按钮来代替该位置的响应事件
        7.2 当不同尺寸屏幕下需要屏幕适配：否则图片上按钮位置发生变化后透明按钮位置出现错位
        7.3 解决思路：将透明按钮位置找到图片上一个不变位置作为参照：如水平中线或者垂直中线
    8.约束被添加的位置：
        8.1 当约束不依赖任何控件时约束被添加到控件本身上面
        8.2 当控件约束依赖于父控件时约束被添加到父控件上
        8.3 当控件约束依赖于兄弟控件时约束被添加到两个兄弟控件的上一级相同父控件上
    9.代码实现Autolayout：
        1.禁止🚫autoresizing功能：通过View的属性translatesAutoresizingMaskIntoConstraints为false
        2.添加约束前一定要保证相关控件都已经添加到父控件上
        3.不用再设置frame：约束 = X、Y、Width、Height
        4.约束计算公式：view1.value(left/right/...) = view2.value * multiplier + constain
    10.通过约束实现动画效果：
        10.1 将要改变的约束拖线到控制器等用一个属性来记录
        10.2 在需要改变控件约束的地方改变约束的值
        10.3 通过动画的方式改变：以动画方式调用view.layoutIfNeeded()方法刷新布局即可实现动画效果：没有那么生硬

### 生成随机数：
    1.C语言函数生成随机数：
        1.1 arc4random():生成0~2^32 - 1 间的一个随机数：若希望生成1~n之间的随机数则：arc4random() % (n + 1)
        1.2 arc4random_uniform(n):生成0~n之间的一个随机数
    
## UI高级控件：通过设置数据源和代理来动态填充数据
### UIPickerView：
    1.点餐系统：随机点餐、滚动点餐
    2.城市选择：
        2.1： 二级联动选择
        2.2： 当两组数据同时滚动时会出现下标越界异常
        2.3：解决方式：每次都将新选中的省份保存起来：再从该保存的省份中获取该省包含的城市数据来显示
    3.国旗选择：
        3.1：通过UIPickerView的代理事件viewForRow方法设置每行显示的样式布局而不是通过titleForRow来显示文字信息
### UIDatePicker：
    1.选择日期：
    2.不需要设置frame自动占据键盘位置
    
# 自定义键盘即上方工具条：
    1.通过UITextField的inputView设置自定义View作为弹出（键盘）View
    2.通过inputAccessoryView设置键盘上方的工具条View：一般用UIToolBar：添加UIBaButtonItem
    
### 获取项目的info.plist文件：
    1.Bundle.main.infoDictionary

## 项目的PCH文件使用：
    1.预编译一些工具类：
    2.定义一些宏：
    3.控制项目的打印日志：
	*****************
	#ifdef __OBJC__
	#ifdef DEBUG
	#define MDLog(...) NSLog(__VA_ARGS__)
	#else
	#define MDLog(...)
	#endif
	#endif
	*****************
	4.第3部中包含C文件时报错可以添加：#ifdef __OBJC__ ··· #endif 来控制···该段代码只会在OC中起作用
	
## 应用程序对象：UIApplication
	1.执行应用级别的操作：如QQ接收到消息在图标出有消息数提示、联网时状态栏的菊花
	2.应用图标头像上的数字：applicationIconBadgeNumber
	3.应用程序联网状态：networkActivityIndicatorVisiable
	4.状态栏管理：系统默认是将状态栏交给控制器管理：通过prefersStatusBarHidden管理
		4.1 当我们在应用程序中的info.plist中添加一个Key为View controller-based status bar appearance - value 为 NO后控制器管理的状态栏失效转由UIApplication管理
		4.2 UIApplication通过isStatusBarHidden来管理
	5.openURL：打电话、发短信、跳转到其他应用程序
	
## 应用程序的启动原理：
	1.OC下可以看到入口函数：main.h main函数
		1.1 main函数接收两个参数：参数1表示参数个数：参数2表示参数具体值
	2.创建自动释放池
	3.执行UIApplicationMain方法：永远不会返回保证程序不会销毁
	4.3中将事件代理给AppDelegate
	5.AppDelegate实例化一个window并设置为应用程序的keyWindow（主窗口）
	6.系统根据info.plist文件中配置的Main.storyboard文件中带箭头的控制器来初始化界面
	7.应用程序生命周期方法
	8.应用程序销毁：
		8.1 通过Home键直接进入后台：
			8.1.1 不活跃状态 -> 进入后台 -> 进入任务栈 ->（拖走）不执行销毁方法：程序崩溃(相当于系统执行exit(9)) -----> 所有不能再销毁时在保存应用数据而是应该在进入后台时保存数据为宜
		8.2 通过任务栈进入后台：
			8.2.1 不活跃状态 -> 进入后台 -> 销毁（拖走）
	
## 判断类中是否包含某个方法：
    1.responseToSelector方法
    //判断当前类是否实现了某个方法
    let isExist = self.responds(to: "test2")

## UIWindow
	1.UIWindow的makeKeyAndVisiable表示设置为keyWindow和显示
	2.UIWindow默认是隐藏的
	3.应用场景：提示类的框架：如提示用户选座、加载等待菊花等

# 3种加载控制器方式：
	1.纯代码创建控制器
	2.通过storyboard创建控制器
		1.加载storyboard文件：UIStoryboard.storyboardWithName
		2.从storyboard中加载控制器
			2.1 加载箭头指向的控制器：storyboard.instantiateInitialViewController
			2.2 加载不带箭头的控制器：instantiateViewControllerWithIdentifier -> 需要在storyboard中指点Identity ID
			3. 系统默认加载带箭头的控制器：如果不指定带箭头控制器则可以通过Identity方式加载
	3.通过xib创建控制器：
		3.1 新建一个xib文件
		3.2 给xib文件指点file·s Owner
		3.3 给xib文件指点file·s Owner指点view试图
			3.3.1 通过控制器的initWithNibNamed方式初始化控制器加载
			3.3.2 直接通过ViewController的初始化方法初始化：ViewController（） -> 系统自动会找到名称与控制器完全一致的xib文件来创建 -> 若没有名称完全一致的则找到名称相似的来创建 -> 若还是没有则认为是代码创建的
	
# 导航控制器：
	1.改变系统导航栏默认生成的返回按钮：self.navigationItem.backBarButtonItem = UIBarButtonItem():self.navigationItem.backBarButtonItem
		
### 用storyboard编写界面还是代码： 可以通过看界面是否会有很大的改变来决定
	
## Segue
	1.自动型：不需要判断直接从控件跳转到下个控制器
		1.1 直接通过控件来拖线到下一个控制器
	2.手动型：需要判断是否满足条件才能决定是否可以跳转到下一个控制器
		2.1 拖线：通过控制器拖到控制器实现
		2.2 为界面上的Segue设置Identifier
		2.3代码中手动调用：performSegueWithIdentifier
	3.Segue执行过程：
		3.1 调用rformSegueWithIdentifier跳转或者自动跳转
		3.2 根据Identifier创建Segue并赋值sourceController及新建destinationController并赋值
		3.3 调用sourceViewController的perferSegue方法带赋值好目标控制器和来源控制器的Segue参数
		3.4 跳转到目标控制器
	
## 断言测试
    let sel = ...
    assert(sel == nil, "断言生效 ~ ····")


## 数据存储
	1.plist(xml)存储：拥有writeToFile方法的对象（数组、字典）可以用这种方式存储，NSString也可以但是plist默认不支持（不会显示类型）
	2.偏好设置：UserDefault：保存到沙盒->Library->Preference下
	3.自定义对象：归档/解档
		3.1 遵守NSCoding协议
		3.2 解析文件重写initWithCoder方法
		3.3 序列化文件重写encodeWithCoder方法

## 多控制器管理：
	1.UINavigationController
	2.UITabbarController
		2.1 不指定任何子控制器时底部空白导航条
		2.2 导航条内部UITabBarButton子控件的个数由UITabbarController的子控件个数决定
		2.3 导航条内部子控件样式由UITabbarController每个子控制器中的UITabBarButton决定（导航控制器类似）
	3.控制器嵌套：同时拥有两种UINavigationController和UITabbarController
		3.1 两种嵌套方式：
			3.1.1 UITabbarController -> UINavigationController -> ViewController  -- 正确嵌套方法	
			3.1.2 UINavigationController -> UITabbarController -> ``` -> ViewController -- 错误嵌套方法 ---> 1.设置导航栏文字冲突···	

## UISearchController + UISearchBar = 搜索界面： 2种方式
	1. 搜索结果界面与UISearchController共用同一个控制器
		1.1 新建一个来显示搜索结果
		1.2 新建UISearchController并指定searchResultsController为nil
		1.3 设置事件代理及结果更新代理
			searchController?.delegate = self
            //设置搜索结果显示代理
            searchController?.searchResultsUpdater = self
           	//将SearchBar添加到TableView头部视图
            tableView.tableHeaderView = searchController?.searchBar
            //样式设置
            searchController?.searchBar.placeholder = "请输入视频、讲义、碑帖名称"
            searchController?.searchBar.searchBarStyle = .minimal
            //决定searchBar是否优先显示到当前self.view上跟随父控制器滚动显示:
            self.definesPresentationContext = true
            //设置大小位置
            searchController?.searchBar.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
            //设置searchBar代理事件
            searchController?.searchBar.delegate = self
            //共用相同控制器不需要遮罩层
            searchController?.dimsBackgroundDuringPresentation = false
        1.4 在updateSearchResults代理方法中获取(初始化)搜索结果数据源
		1.5 正常设置TableView的数据源方法及代理事件
	2. 搜索结果控制器 + UISearchController： 只需要将1.2 新建UISearchController并指定searchResultsController为nil 改为显示结果界面的控制器即可

## Storyboard中跳转方式：
	1. Modal方式：当点击后要执行的操作跟要跳转的Controller没有业务逻辑关联：如动态 -> 评论
	2. Push方式：当点击后要执行的操作跟要跳转的Controller有业务逻辑关联： 如标题 -> 详情
	3. push/modal(过期) -> show :因为两种方式都是通过Segue来实现可共用 

## Quartz2D ： 绘图 纯C语言的 封装到Core Graphics框架中 -> OC可用
	1.获取（图形上下文）对象：类似一张草稿纸:UIGraphicsGetCurrentContext()
		1.1 CGContextRef上下文包含信息：
			1.1.1 绘图路径：CGPathRef、CGMutablePathRef、UIBezierPath(可以将C的path转化为OC的path)
			1.1.2 绘图状态：颜色、线宽、样式（线宽、头尾、连接处）、旋转、缩放、平移、图片裁剪区等
			1.1.3 输出目标：绘制到什么地方 -> UIView 图片、PDF、打印机、Window等	
	2.向（图形上下文）对象添加路径
		2.1 CGContextAddPath
	3.渲染（将上下文中图形绘制到界面上）
	4.OC封装写法：
		4.1 直接用UIBezierPath
		4.2 拼接路径
		4.2.1 设置颜色：OC方式：UIColor().setStroke() ：C方式：context.setRGB... 
		4.3 直接用path.stroke绘制：内部会自动调用上下文CGContextRef
	5.在drawRect方法中绘图：
		5.1 只有在drawRect中才能正确获取上下文对象
		5.2 drawRect在UIView初始化时会调用 + 界面重绘时会调用（setNeedDisplay）
		5.3  
	6.渲染方式：
		6.1 填充：CGContextStrokePath(context)
		6.2 描边: CGContextFillPath(context)
		6.3 通用：CGContextDrawPath(context,一个枚举)
		6.4 奇偶填充规则：枚举：EOFill：不是系统默认规则
		6.5 非0环绕数规则：系统默认方式：从右往左 -1 从左往右 +1 结果为0则不填充 否则填充
		6.6 饼图绘制：for循环：start = 0 end = 0 ...结束角度 = 开始角度 + 2*3.14 * 比例
    	6.7 柱状图绘制：demo：
    		***********************
    		for var i in (0..<count) {
            let spaceWidth = 10
            let width = (self.bounds.size.width - CGFloat((count-1)*spaceWidth)) / CGFloat(count)
            let height = self.bounds.size.height * array[i]
            let x: CGFloat = (width + CGFloat(spaceWidth)) * CGFloat(i)
            let y: CGFloat = self.bounds.size.height - height
            let rect = CGRect(x: x, y: y, width: width, height: height)
            let path = UIBezierPath(rect: rect)
            //设置样式
            getRandomColor().set()
            path.lineWidth = 1
            path.fill()
        	}
            ***********************
	7.self.center : center is center of frame.(根据父控件计算获得) 
	
    8.矩阵变换：
    	1.旋转
    		1.1 获取上下文 -> 旋转上下文 -> 绘制路径 ···
    	2.平移
    		2.1 获取上下文 -> 平移上下文 -> 绘制路径 ···
    	3.缩放
    		3.1 获取上下文 -> 缩放上下文 -> 绘制路径 ···

	9.图形上下文栈：
    	1.保存到栈：可以保存多个状态 
    	2.恢复栈内信息

	10.绘制文字：
    	1.NSString自带的方法：
    		1.1 str.drawAtPoint：从Point点开始绘制
    		1.2 str.drawInRect：在一个指定的矩形中绘制 自动换行	
    		1.3 设置文字属性时：要设置阴影效果需要同时设置下划线

	11.绘制图片：
    	1.Image自带方法
    		1.1 draw...	

	12.裁剪上下文渲染区域：如图片圆形裁剪
    	1.获取上下文
    	2.绘制要裁剪路径
    	3.裁剪：CGContextClip(context)
    	4.裁剪的是可视区域并不是将上下文裁剪成对应的路径形状

	13.图片(bitmap)类型的图形上下文：可以在图片上下文上绘制图形并作为图片返回
    	1.开启图片上下文：UIGraphicsBeginImageContextWithOption...可以指定不同屏幕下缩放因子：UIScreen.scale = 0 传0系统默认传屏幕缩放因子
    	2.获取当前layer类型上下文绘制图形
    	3.通过layer类型的上下文渲染绘制的图形到图片类型的上下文上
    	4.通过UIGraphicsGetImageFromCurrentImageContext()获取到绘制到的图片image
    	5.关闭图片类型的图形上下文
    	6.显示获取到的image到界面上

	14.将图片或者无writeToFile方法的对象保存到沙盒：
    	1.先将对象转为NSData对象：图片通过UIImagePNGRepresentation转换
    	2.通过writeToFile方法将对象保存沙盒	

	15.获取裁剪后图片：
		1.开启图片上下文
		2.关闭图片上下文
		3.获取当前上下文
		4.绘制要裁剪区域
		5.裁剪：context.clip()
		6.将图片绘制（渲染到界面上）：image.draw()
		
	16.将图片（UIImage）保存到手机相册：
		1.调用UIImageWriteToSavedPhotosAlbum方法保存

	17.给图片添加水印：
		1.绘制大图
		2.绘制文字
		3.绘制logo

	18.屏幕截图：
		1.开启图片上下文：相当于在上下文栈的栈顶添加一个新的上下文 -> 再次获取当前上下文就是新开启的图片上下文 
		2.关闭图片上下文：相当于在上下文栈中将栈顶元素出栈 -> 再次获取当前上下文就是系统为我们创建的上下文
		3.获取当前上下文
		4.调用UIView的layer的renderInContext方法截取整个View的图片不包含状态栏等无关信息
		5.通过上下文获取渲染好View截图的Image：UIGraphicsGetImageFromCurrentImageContext
		

## 触摸事件：UITouch + UIEvent
	1.响应者链条：一系列执行TouchBegin的所有对象按先后顺序连接：第一个执行touchbegin方法的对象就叫第一响应者
	2.click事件（Selector）也相当于touch事件：当系统找到对应的控件响应了click事件后事件终止

<<<<<<< .merge_file_djrtkl
### 手势解锁：	
=======
### 手势解锁：
	1.初始化按钮并九宫格布局：
		1.1 通过 i%lineCount 来控制同一行下一个X坐标 * (按钮宽 + margin) + margin
		1.2 通过i/lineCount 来控制下一行Y坐标 * (按钮宽 + margin) + margin
	2.禁用按钮点击事件改用touch事件来响应操作：
		1.touchesBeagin: 使点击的按钮变为选中或者高亮状态
		2.touchesMove: 使经过的的按钮变为选中或者高亮状态
		3.touchesEnd: 取现所有状态
	3.Quartz2D绘制按钮间连线及最后一个按钮与手指间的连线：
	4.通过按钮的tag拼接字符串密码
	5.设置block作为回调：响应用户密码的正确性操作并显示错误提示信息
		1.定义一个回调：函数类型block回调：如 var passBlock: ((pass: String) -> Bool)?
		2.在密码拼接处设置回调：self.checkPassBlock!(pass)供用户获取当前手势密码

### 手势冲突：
	1.系统默认不支持多种手势同时操作：
	2.解决方法：通过实现代理方法告诉系统可以支持多种手势操作
		1.gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool

## CALayer: 给UIView设置样式属性实际上是在给CALayer设置样式属性：系统内部完成：如背景颜色，图片，字体等等
	1.CALayer与UIView的关系：UIView负责监听事件响应，CALayer负责显示界面样式：
	2.属性：边框，圆角，阴影需要配合透明度(Opacity = 1)使用，bounds，position(center)，content(一般设置图片)
		2.1 bounds + position(center) = frame :一般不要给CALayer直接设置frame在动画操作上可能会出问题：position默认在center位置：可以通过anchorPoint(锚点)来调整
		2.2 阴影需要配合透明度(Opacity = 1)使用
		2.3 圆角需要配合裁剪使用：masksToBounds = true
	3.CA : Core Animation：改变CALayer属性会自带动画效果：隐式动画：animatable标记的属性
	4.控件的根layer是没有隐式动画的
	5.禁用根layer的隐式动画：事务：CATransaction
		5.1 开启事务：CATransaction begin
		5.2 禁用隐式动画：CATransaction.setDisableActions = true
		5.3 操作：
		5.4 提交事务：commit
	6.transform：3D动画:CATransform3D + 缩放/旋转/平移 / CGAffineTransform平面动画
	7.anchorPoint：锚点：x,y取值范围是0~1：改变layer的中心点位置

## Core Animation：核心动画
	1.CAAnimation是作用在layer上的：
	2.基本动画：是属性动画的一种：通过keyPath方式改变属性的值从而实现动画效果
		2.1 基本动画CAAnimation：动画执行完会回到原来的位置上
	3.关键帧动画：属性动画的一种：也是通过keyPath方式改变属性的值从而实现动画效果
		3.1 根据指定点执行动画：values：可以指定多个点
			3.1.1 通过NSValue的构造方法可以将CGPoint转化为NSValue
		3.2 根据路径执行动画：path：可以绘制各种路径
		3.3 values和path同时设置执行后者
	4.转场动画：CATransition
		4.1 创建动画
		4.2 通过字符串type设置动画效果：cube、
		4.2.1 改变动画方向：subtype 系统默认是从上到下
		4.3 往layer上添加动画：layer.add(anima..)
	5.画板案例：
		1.搭建界面
		2.多条线绘制
		3.设置线宽、样式
		4.设置颜色：系统路径没有颜色属性：自定义一个路径创建颜色属性存储
		5.工具条功能实现：清屏、回退、橡皮擦、保存到相册
	6.绘制圆形路径时最好用arc方式画圆：如果以椭圆方式OverInRect方式画圆两个路径本质不一样长

#	添加2D(平面)动画：在原来的基础上添加旋转动画：累加

	self.rotateImageView.transform.rotated(by: CGFloat(angle * s * 10)) //错误做法这样只是改变了原来的没有设置到layer上
    	self.rotateImageView.layer.setAffineTransform(self.rotateImageView.transform.rotated(by: CGFloat(angle))) 	//正确做法

## 应用启动图决定了当前应用的分辨率大小：bounds.size
<<<<<<< HEAD

## UICollectionView通过注册Cell方式从缓存池中获取Cell，如果获取不到系统会自动新建一个Cell返回不需要手动创建到缓存池中
=======
>>>>>>> .merge_file_RiLi3Y

## 设置应用导航栏颜色样式注意点：
	1.设置样式用navigationBar：高度44
	2.设置内容用navigationItem
	3.通过self.NavigationController.navigationBar.setBackgroundColor:单纯的设置44高度的navigationBar的背景颜色
	4.通过self.NavigationController.navigationBar.setTintColor:设置主题色调：文字主题色
	5.通过self.NavigationController.navigationBar.setBarTintColor:设置64高度的导航栏颜色：状态栏也设置 特殊处理后的颜色：系统默认半透明处理
	6.如果不想要系统特殊处理后的颜色可以取消：通过self.NavigationController.navigationBar.setTranslucent = false : 设置会使TableView显示的起点坐标有变换y值增加64：因为不透明看不到内容了没有意义



>>>>>>> 6a8fbf7a0dc5702acefe813aedfc84c39ae20f00

### 指纹识别：
	1. 8.0开始开发指纹识别接口：但是iPhone5S已经有指纹识别功能
	2. 导入LocalAuthentication
	3. 判断当前系统版本是否大于8.0
	4. 开启指纹识别：LAContext.evaluateP...
	5. 处理成功及错误回调：如果涉及到UI更新需要在主线程：指纹识别是异步操作

### 内存分析：
    1.静态分析工具：Xcode自带：Analyze
    2.动态分析工具：Xcode自带：Profile：Xcode自动调用Instruments工具箱：点击Leaks可以检测内存泄漏
        2.1 点击开始录制按钮工具自动运行程序并检测内存情况：你可以操作应用程序看看有没有内存泄漏问题：红叉表示内存泄漏
        2.2 停止录制后可以点击Leaks来查看当前内存泄漏情况具体定位到自己写的代码上：点击Leaks - Leaks - CallTree - CallTree - Hide System Libraries可以查看当前用户定义的类内存泄漏情况
    3.真机调试：模拟器性能跟电脑配置有关
    4.release模式：系统会优化代码，看门狗模式会关闭：检测比较严格
    
### 播放音效文件：
    1.导入AVFoundation框架
    2.创建音效文件：AudioCreate。。。
    3.播放音效文件：AudioPlay。。。
    4.释放：AudioDispose。。。

## 音乐播放：
	1.导入AVFoundation
	2.创建播放器：AVAudioPlayer
	3.播放前准备：prepare..
	4.播放：play：内部检查是否准备没有自动调用准备操作
	5.暂停：pause
	6.停止：stop：手动将时间清零

## 录音：
	1.AVFoundation
		1.1 获取要存储的路径
		1.2 配置录音录制参数：字典：录音格式、采样率、通道数、位深度等
	2.AVAudioRecorder初始化
	3.准备录音：prepare
	4.开始录音：start
	5.暂停录音：pause
	6.停止录音：stop

	7.自动停止录音：分贝检测：没有声音时自动停止
		7.1 打开分贝检测：meteringEnabled
		7.2 通过计时器循环检测分贝大小
		7.3 初始化定时器：CADisplayLink并在暂停和停止的地方暂停定时器
		7.4 更新分贝信息：updateMeters
		7.5 获取更新后的分贝值（负值最大是0）：averagePowerForChannel： 0
		7.6  判断分贝值在一定时间(次数)内一直低于某个值则认为可以自动停止录音：count记录次数：如120次内持续低于某个值则自动停止
		7.7 真机上运行注意：
			7.1.1 提示用户授权
			7.1.2 需要添加AVAudioSession的分类并指定类型是录音：record

## 视频播放：
	1.导入MediaPlayer
	2.带view的播放器
		2.0 获取视频URL路径
		2.1 MPMoviePlayerViewController
		2.2 模态弹出控制器：present。。
		2.3 需要在弹出控制器的view加载完毕之后才弹出播放器：否则可能会出现没有画面或报警告
	3.不带view的播放器
		3.1 设置frame
		3.2 将播放器控制器的view添加到目标view上
		3.3 强引用播放器：否则会被销毁
			3.3.1 设置播放器控制模式：controlStyle
		3.4 准备播放
		3.5 播放
		3.6 通过通知来监听视频播放器的播放结束：播放完成、播放出错、列表播放完毕
			3.6.1 连续播放：在播放结束通知时切换视频URL并播放  
		3.7 不带view的播放器播放完成移除view：removefromsuperview
		 
	4.iOS9后视频播放：
		4.1 导入AVKit
		4.2 AVPlayerViewController
		4.3 设置AVPlayer：player（重点）
		4.4 播放：play
		4.5 弹出控制器：present。。。
		4.6 自定义播放器大小：改变frame添加到目标view上即可

		4.7 视频截图：
			4.7.1 获取要截取视频资源URL
			4.7.2 获取AVAsset资源
			4.7.3 创建图像资源生成器：AVAseetImageGenerator
			4.7.4 设置要截取哪一帧的时间：CMTime：CMTime(5,1) = 第五帧/每秒一帧
			4.7.4.1 将CMTime转化为NSValue类型
			4.7.5 通过AVAseetImageGenerator生成截图并在回调中获取截图 - 主线程更新UI

		4.8 视频录制：跟拍照类似
			1.判断相机是否可用UIImagePickerController：isSourceTypeAvailable
			2.初始化相机选择控制器：
			3.设置source类型：sourceType
			4.设置媒体类型：
				4.1 需要导入key所在库：MobileCoreServices
				4.2 设置media类型：kUITypeMovie
				4.3 设置相机检测模式：cameraCaptureMode
				4.4 设置录制视频的质量：videoQuality
			5.设置相机选择控制器代理事件获取录制好的文件
			6.弹出控制器：present。。。
			7.代理方法中获取录制的视频(URL)：并播放
			8.保存视频:
				8.1 导入资源库：AssetsLibrary
				8.2 通过ALAssetsLibrary的writeVideo方法保存视频

		4.9 视频压缩：
			1.通过URL获取视频资源：AVAsset(url)
			2.设置压缩格式：低质量压缩：AVAssetExportSession：presetName表示压缩质量
			3.设置到处路径：session.outputURL
			4.设置导出类型：outputFileType：Movie或者MPEG4等
			5.开始导出：session.exportAsynchronous...：回调




## 进阶：
	1.地理定位，导航
	2.分享：SSO授权
	3.应用程序间通信
	4.Git操作
	5.二维码生成及扫描
	6.高质量换肤
	7.人脸识别框架Face ++
	8.第三方存储服务：LeanCloud
	9.指纹识别
	10.传感器
	11.蓝牙
	12.音频处理
	13.视频处理
	14.内存分析:Instruments
	15.打包，调试，上架
	16.支付宝支付
	17.推送，通知
	18.广告，内购
	19.静态库(.a,.framework)，动态库



















