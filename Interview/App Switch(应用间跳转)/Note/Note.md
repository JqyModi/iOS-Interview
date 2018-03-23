#  应用程序间跳转：
    1.通过URL形式跳转
    2.为要跳转的应用程序配置URL或者搜索第三方的URL跳转：
        2.1 配置URL：配置文件 —> target -> info -> URL Type -> Schemes：如Interview
    3.在需要跳转的地方通过UIApplication.shared.OpenURL(string)来跳转应用
    4.跳转前加上判断是否可以跳转：canOpenURL：http://dev.umeng.com/ ：友盟开发文档
        4.1 加上判断后需要到info.plist文件中配置一个白名单列表：【Key：value】: 防止URL劫持：配置跟第三方一样的URLScheme：如微信支付时
                <key>LSApplicationQueriesSchemes</key>
                <array>
                <string>待跳转的schemes</string>
                ...
                </array>
    5.完整URL = URLSchemes + path
        5.1 通过path来跳转到指定应用的指定界面：如：Lottery://setting ：表示跳转到Lottery应用的setting界面
        5.2 在目标应用中的AppDelegate中重写open url方法处理响应：判断当前path包含的路径跳转到相对应界面
        5.3 每次跳转前应该重根控制器跳转：popRootViewController
        5.4 循环跳转：path中添加当前应用程序的scheme再在目标App中通过特殊符号判断源App的scheme进行跳转：如URL=Lottery://setting.Interview：【.后面表示源App】
        5.5 跳转时的URL通过info.plist读取不要硬编码
