1.Objective-C如何对内存管理的,说说你的看法和解决方法?
答：内存管理有两种：MRC/ARC 1.MRC下通过对象本身计数器retain和release来开辟和释放内存空间或者我们可以通过系统提供的autorelease来管理内存  2.ARC：编译器会在编译时自动生成管理内存代码

2.内存管理的几条原则是什么？按照默认法则.哪些方法生成的对象需要手动释放？在和property结合的时候怎样有效的避免内存泄露？
答：1.凡是通过alloc/copy/new生成的新对象都必须在最后调用一次release或者autorelease
2.代码中调用了retain方法的生成的对象需要在最后调用一次release或者autorelease
3.@property如果用了copy/retain就需要对不再使用的对象做一次release

3.属性和成员变量的区别：
答：1.属性 = 成员变量(var) + getter(可能涉及到其他属性或者成员变量) + setter(可能涉及到其他属性或者成员变量)

4.分类是否能扩充一个属性？
答：能，在分类中扩充一个成员变量并实现getter/setter（利用 关联对象 将该成员变量与之对应的_xxx成员变量关联起来）方法使外界可以正常读写，可以认为是给类扩充了一个属性

4.分类是否能扩充一个成员变量？
答：不能

5.mutable 与 immutable 区别？
答：以NSMutableArray与NSArray为例：通过NSArray()创建方式会开辟一块不可变的内存空间，当我们希望向数组中加入新的内容时系统会在堆中开辟另一个内存空间并将指向原来创建的指针指向新开辟的内存空间，同时会将原来内存空间的内容拷贝到新的内存空间下，而NSMutableArray()是通过动态申请内存空间的方式开辟内存空间大小，当我们向数组中添加新的内容时会在原来开辟的基础上动态申请内存空间

6.What is responder chain(响应者链)?
答：1.响应者链是有多个响应者(UIResponder)对象组成的链条：每个UIResponder都有一个nextResponder属性，通过该属性可以组成一个响应者链，事件或者消息可以在链条上传递
2.如果当前UIResponder没有出来传递给它的事件，则会将未处理的消息继续传递给自己的下一个响应者(nextResponder)
3.响应者链传递规则：找响应者(hitTest)：UIApplication -> UIWindow -> UIViewController -> UIView -> SubView（UIView）-> 事件响应(touchesBegan) -> Superview（UIView）->···->UIView -> UIViewController -> UIWindow -> UIApplication

7.Difference between method and selector?
答：Selector可以获取到方法地址间接调用方法执行

8.定义属性时，什么情况使用copy、assign、retain？
答：1>copy：NSString、Block等类型
2>assign：基本数据类型
3>retain：OC对象类型

蓝牙开发官方文档：https://developer.apple.com/library/content/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/AboutCoreBluetooth/Introduction.html#//apple_ref/doc/uid/TP40013257-CH1-SW1
