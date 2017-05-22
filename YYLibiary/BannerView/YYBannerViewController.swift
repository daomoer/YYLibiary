//
//  YYBannerViewController.swift
//  YYLibiary
//
//  Created by YY on 2017/5/19.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit

let Screen_Width = UIScreen.main.bounds.width

class YYBannerViewController: UIViewController {
    var scrollview = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        
        let imagesURLStrings = [
            "img_01.jpg",
            "http://www.g-photography.net/file_picture/3/3587/4.jpg",
            "http://img2.zjolcdn.com/pic/0/13/66/56/13665652_914292.jpg",
            "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
            "http://img3.redocn.com/tupian/20150806/weimeisheyingtupian_4779232.jpg",
            ];

        
        // 图片配文字
        let titles = ["感谢您的支持",
                      "如果代码在使用过程中出现问题",
                      "请拨打110报警电话"
        ];
        
        
        // 纯文本demo
        let titleDemo = LLCycleScrollView.llCycleScrollViewWithTitles(frame: CGRect.init(x: 0, y:64, width: Screen_Width, height: 100), titles: titles) { (index) in
            print("当前点击文本的位置为:\(index)")
        }
        titleDemo.customPageControlStyle = .none
        titleDemo.scrollDirection = .vertical
        titleDemo.font = UIFont.systemFont(ofSize: 13)
        titleDemo.textColor = UIColor.red
        titleDemo.titleBackgroundColor = UIColor.green.withAlphaComponent(0.3)
        titleDemo.numberOfLines = 2
        // 文本　Leading约束
        titleDemo.titleLeading = 30
        self.view.addSubview(titleDemo)
        
        
        // Demo--点击回调
        let bannerDemo = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y:64+titleDemo.frame.height+20, width: Screen_Width, height: 150), imageURLPaths: imagesURLStrings, titles:titles, didSelectItemAtIndex: { index in
            print("当前点击图片的位置为:\(index)")
        })
        bannerDemo.customPageControlStyle = .pill
        bannerDemo.customPageControlInActiveTintColor = UIColor.red
        // 下边约束
        bannerDemo.pageControlBottom = 20
        self.view.addSubview(bannerDemo)
        
        
        
        
        // Demo--延时加载数据之滚动方向控制
        let bannerDemo1 = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y:64+titleDemo.frame.height+bannerDemo.frame.height+30, width: Screen_Width, height:150 ))
        // 垂直滚动
        bannerDemo1.scrollDirection = .vertical
        bannerDemo1.customPageControlStyle = .snake
        self.view.addSubview(bannerDemo1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            bannerDemo1.imagePaths = imagesURLStrings
        }
        
        
        
        // Demo--其他属性
      let bannerDemo2 = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y:64+titleDemo.frame.height+bannerDemo.frame.height+bannerDemo1.frame.height+40, width: Screen_Width, height: 150))
        // 滚动间隔时间
        bannerDemo2.autoScrollTimeInterval = 1.0
        // 加载状态图
//        bannerDemo2.placeHolderImage = #imageLiteral(resourceName: "s1")
        // 没有数据时候的封面图
//        bannerDemo2.coverImage = #imageLiteral(resourceName: "s2")
        bannerDemo2.customPageControlStyle = .none
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            bannerDemo2.imagePaths = imagesURLStrings
        }
        self.view.addSubview(bannerDemo2)
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
