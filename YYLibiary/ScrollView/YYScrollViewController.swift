//
//  YYScrollViewController.swift
//  YYLibiary
//
//  Created by YY on 2017/5/18.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit

class YYScrollViewController: UIViewController , YYScrollViewDelegate {
    
    var scrollView : YYScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 去掉navigation 的自动留白，让scrollview从设置偏移量o点开始，不然会有空白处
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        /**
         初始化方法1,传入图片数组,以及pageControl的当前page点的颜色,无需依赖第三方库
         
         - parameter frame:          frame
         - parameter imgArray:       图片数组
         - parameter pagePointColor: pageControl的当前page点的颜色
         - parameter stepTime:       广告每一页停留时间
         
         - returns: ScrollView图片轮播器
         */
        scrollView = YYScrollView(
            frame: CGRect(x: 0, y: 64, width:UIScreen.main.bounds.width, height: 160),
            imageArray:imgArr(),
            pagePointColor: UIColor.orange,
            stepTime: 2.0)

        /**
         初始化方法2,传入图片URL数组,以及pageControl的当前page点的颜色,特别注意需要SDWebImage框架支持
         
         - parameter frame:          frame
         - parameter imgURLArray:    图片URL数组
         - parameter pagePointColor: pageControl的当前page点的颜色
         - parameter stepTime:       广告每一页停留时间
         
         - returns: ScrollView图片轮播器
//         */
//                scrollView = YYScrollView(
//                    frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height: 160),
//                    imageURLArray:urlStringArr(),
//                    pagePointColor: UIColor.orange,
//                    stepTime: 2.0)
        
        
        scrollView?.delegate = self
        
        scrollView?.imageClickBlock = {
        (index: Int) -> ()
        in
        print(index)
        }
        
        self.view.addSubview(scrollView!)
        
    }
    //获得图片数组
    func imgArr() ->[UIImage]
    {
        var arr = [UIImage]()
        
        for i in 0 ..< 5
        {
            let img = UIImage(named:"img_0\(i + 1)")
            
            arr.append(img!)
        }
        return arr
    }

    //获得图片URL数组
    func urlStringArr() ->[String]
    {
        var arr = [String]()
        
        for i in 0 ..< 5
        {
            let urlStr = "http://7xpbws.com1.z0.glb.clouddn.com/JMCarouselViewimg_0\(i+1).png"
            
            arr.append(urlStr)
        }
        return arr
    }

    func clickCurrentImage(_ currentIndxe: Int) {
        print(currentIndxe)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
