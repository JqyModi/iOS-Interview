## 开启aria2c服务：aria2c --enable-rpc --rpc-listen-all

## MarkDown编辑器：MacOS+Windows: http://pad.haroopress.com/user.html#download

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

## UITableView：当图片下载速度过慢时可能会出现由Cell复用导致图片更新错行问题：解决方式：当图片下载完成更新对应的Cell：tableview.reloadRows....

## 缓存图片到内存中时：可能会出现内存警告⚠️：需要清理内存：手动创建一个缓存池：用字典存储：方便存取

## UITableview开启子线程下载图片时：在图片还没下载完成时不停拖动Cell列表可能会出现重复添加下载任务操作：需要将下载任务操作也缓存起来：下载前先判断是否已经添加到操作缓存池中：收到内存警告时也需要情况缓存

## block中使用self是否会出现循环引用？：分析是否会循环引用：解决循环引用：或者[weak self]

## 图片三级缓存：首先将图片缓存到内存中（用户启动之后无需重复加载）- 将图片保存到沙盒的Cache目录下（用户再次启动APP无需重复下载图片：直接从沙盒中读取图片并缓存到内存中）- 如果缓存和沙盒中都没有图片则从网络下载图片并缓存到内存及沙盒中

## 将可变数组转不可变数组：NSMutableArray().copy()

# 运行时设置UITextView提示文本控件
    1. fillBlank.setValue(placeHolderLabel, forKeyPath: "_placeholderLabel")

# PS: SnapKit + UITableViewCell：自动布局
    1.自定义Cell：重写init：design初始化方法：setupUI:懒加载控件
    2.添加控件到contentView：添加布局约束：
    3.自动布局：需要给BottomView添加底部约束
    4.设置UITableViewController自动布局：//1.设置估计值
    tableView.estimatedRowHeight = 400
    2.设置自动计算
    tableView.rowHeight = UITableViewAutomaticDimension

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
    
# UITableView添加右侧索引栏（类似通信录中的字母索引）：
    1.实现sectionIndexTitlesForTableView方法返回对应的索引标签

# UIAlertView带输入框显示：
    1.设置alertViewStyle为plainTextInput
    2.通过textFieldAtIndex获取弹出框中指点View控件
    
# UITableViewCell:
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
        1. 在控制器中通过Model模型数据计算出可变控件(UILabel)的Frame
        2.
        
### TableView中FootView只能修改X和Hight 若需要自定义可变样式View可以放一个容器View修改内部View即可

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
