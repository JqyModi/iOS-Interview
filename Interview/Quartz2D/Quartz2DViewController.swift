//
//  Quartz2DViewController.swift
//  Interview
//
//  Created by mac on 2018/3/8.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class Quartz2DViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    //
    var imageV: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageV = UIImageView()
        self.view.addSubview(imageV!)
    }
    
//    @IBAction func slide(_ sender: UISlider) {
//        varView.progressValue = CGFloat(sender.value)
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //绘制带圆环图片
//        self.imageView.image = drawImageWithCircle()
        
        //给图片添加水印
//        let image = UIImage(named: "icon_02")
//        let logo = UIImage(named: "activity")
//        self.imageV?.image = addWatermarkInImage(image: image!, logo: logo)
//        imageV?.frame = self.view.frame
        
        //将图片保存到沙盒
//        saveImageToFile(image: ImageContextTest())
        
        //将图片保存到相册
//        saveImageToPhotosAlbum(image: ImageContextTest())
        
        //获取屏幕截图
        self.imageView.image = getScreenshotOfView(view: self.view)
        saveImageToPhotosAlbum(image: getScreenshotOfView(view: self.view))
    }
    
    private func getScreenshotOfView(view: UIView) -> UIImage{
        //开启图片上下文
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        //获取屏幕截图：内部通过上下文渲染
        view.layer.render(in: context!)
        //获取截取的图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //关闭图片上下文
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    private func addWatermarkInImage(image: UIImage, mark: String = "Siri制作", logo: UIImage?) -> UIImage {
        //获取图片
        var image = image
        //开启图片上下文
        let margin: CGFloat = 20
        //将上下文每边增大10距离
        let size = CGSize(width: (image.size.width) + 2 * margin, height: (image.size.height) + 2 * margin)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        //获取当前上下文绘制圆环
        let context = UIGraphicsGetCurrentContext()
        //渲染图片
        image.draw(at: CGPoint(x: margin, y: margin))
        
        //绘制左上角文字
        let text: NSString = mark as NSString
        text.draw(at: CGPoint(x: margin*2, y: margin*2), withAttributes: nil)
        
        //绘制右下角logo
        let point = CGPoint(x: image.size.width * 0.8, y: image.size.height * 0.8)
        logo?.draw(at: point)
        
        //获取绘制好的图片
        image = UIGraphicsGetImageFromCurrentImageContext()!
        //关闭图片上下文
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    /**
     *  Desc: 绘制带圆环的图片
     *  Param:
     */
    private func drawImageWithCircle() -> UIImage{
        //获取图片
        var image = UIImage(named: "icon_02")
        //开启图片上下文
        let margin: CGFloat = 20
        //将上下文每边增大10距离
        let size = CGSize(width: (image?.size.width)! + 2 * margin, height: (image?.size.height)! + 2 * margin)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        //获取当前上下文绘制圆环
        let context = UIGraphicsGetCurrentContext()
        //绘制路径：圆环路径
        let center = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        let radius = size.width/2 - margin
        let start = CGFloat(0)
        let end = CGFloat(Double.pi * 2)
        context?.addArc(center: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        //设置样式：线宽
        context?.setLineWidth(margin)
        //渲染圆环
        context?.strokePath()
        
        //绘制图片裁剪区域
//        context?.setLineWidth(1) ??
        context?.addArc(center: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        //裁剪
        context?.clip()
        //渲染图片
        image?.draw(at: CGPoint(x: margin, y: margin))
        //获取绘制好的图片
        image = UIGraphicsGetImageFromCurrentImageContext()
        //关闭图片上下文
        UIGraphicsEndImageContext()
        
        return image!
    }
    
//  系统要求该方法要这么实现： - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {}
    @objc private func image(image: UIImage, didFinishSavingWithError error: NSError, contextInfo: Any) {
        debugPrint("func --> \(#function) : line --> \(#line) ：info --> \(contextInfo)")
    }
    
    
    
    //将绘制好的图形图片保存到手机相册
    private func saveImageToPhotosAlbum(image: UIImage) {
        //NSPhotoLibraryAddUsageDescription：系统要求需要配置用户提示弹窗
        //contextInfo：标记作用：传递参数
        var info = "我是保存的第一张图片~"
        let contextInfo = UnsafeMutableRawPointer(&info)
        
        var number = 5
        let numberPointer = UnsafeMutableRawPointer(&number)
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(Quartz2DViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //将绘制好的图形图片保存到沙盒
    private func saveImageToFile(image: UIImage) {
        //将图片转换为NSData对象
        let pngImageData = UIImagePNGRepresentation(image)
        //需要指定图片质量：0~1
        let jpegImageData = UIImageJPEGRepresentation(image, 0.5)
        //获取文件路径：第三个参数表示是否将路径缩写为~
//        var path: NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first as! NSString
        var homePath: NSString = NSHomeDirectory() as NSString
        //拼接路径
        homePath = homePath.appendingPathComponent("Documents/siri.png") as NSString
        let url = URL(fileURLWithPath: homePath as String)
        
        debugPrint("url = \(url)")
        
        do {
            try pngImageData?.write(to: url, options: .atomic)
        } catch {
//            debugPrint(error)
            //自定义一个异常
            let exception = NSException(name: NSExceptionName(rawValue: "图片保存失败~"), reason: "请检查路径是否正确", userInfo: nil)
            //抛出异常
            exception.raise()
        }
        
        
        
    }
    
    /**
     *  Desc: 通过图片类型上下文绘制并将绘制好的图形作为图片Image返回
     *  Param:
     */
    private func ImageContextTest() -> UIImage {
        
        //获取要绘制的图片
        let image = UIImage(named: "icon_02")
        
        //1.开启图片类型图形上下文:2种方式
        let size = CGSize(width: 300, height: 300)
//        UIGraphicsBeginImageContext(<#T##size: CGSize##CGSize#>)
        //opaque：true表示不透明  最后一个参数传0表示：自动根据屏幕缩放因子动态改变：相当于UIScreen.scale
        UIGraphicsBeginImageContextWithOptions((image?.size)!, false, 0)
        
        //获取当前上下文（当前是图片类型不是layer类型）进行绘图
        let context = UIGraphicsGetCurrentContext()
        //绘制路径
        //计算图片上下文的中点
        let center = CGPoint(x: (size.width) * 0.5, y: (size.height) * 0.5)
        context?.addArc(center: center, radius: 100, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        //渲染路径
//        context?.strokePath()
        //裁剪上下文可视区域：
        context?.clip()
        //渲染图片到上下文：按照指定的裁剪区域渲染
        image?.draw(at: CGPoint.zero)
        //通过图片类型上下文获取绘制好的图片作为图片（Image）返回
        let image1 = UIGraphicsGetImageFromCurrentImageContext()
        
        //结束图片类型上下文
        UIGraphicsEndImageContext()
        
        //将图片设置给ImageView
        return image1!
    }
}
