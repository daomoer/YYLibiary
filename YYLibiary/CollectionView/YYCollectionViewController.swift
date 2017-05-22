//
//  YYCollectionViewController.swift
//  YYLibiary
//
//  Created by YY on 2017/5/18.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit

class YYCollectionViewController: UIViewController {
    var bannerImageArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 去掉navigation 的自动留白，让scrollview从设置偏移量o点开始，不然会有空白处
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.white
        let yyCollectionView = YYCollectionView.cycleScrollView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: 150), imageNameGroup: self.bannerImageArray.count > 0 ? self.bannerImageArray : ["img_01", "img_02", "img_03","img_02","img_01","img_02","img_03"])
        yyCollectionView.selectClosure = { (index: Int) -> Void in
            print(index)
        }
        self.view.addSubview(yyCollectionView)
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
