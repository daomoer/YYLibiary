//
//  YYCaCheViewController.swift
//  YYLibiary
//
//  Created by YY on 2017/5/23.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit

class YYCaCheViewController: UIViewController {
    /**
     *  模拟数据请求URL
     */
    let URLString = "http://www.returnoc.com"
    
    /**
     *  模拟服务器请求数据
     */
    let responseObject = [
        "time" : "1444524177",
        "isauth" : "0",
        "openid" : "1728484287",
        "sex" : "男",
        "city" : "",
        "cover" : "http://tp4.sinaimg.cn/1728484287/180/5736236738/1",
        "logintime" : "1445267749",
        "name" : "",
        "group" : "3",
        "loginhit" : "4",
        "id" : "234328",
        "phone" : "",
        "nicheng" : "辉Allen",
        "apptoken" : "bae4c30113151270174f724f450779bc",
        "face" : "http://tp4.sinaimg.cn/1728484287/180/5736236738/1",
        "desc" : "比你牛B的人都在努力,你还有什么理由偷懒!",
        "infoverify" : "1"
    ]
    
    let titleStr = ["同步缓存","异步缓存","获取缓存数据","缓存数据大小(M)","缓存路径","清楚缓存"]
    
    var Btn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createBtn()
    }
    
    func createBtn(){
        for index in 0..<6{
            let btn = UIButton(type:UIButtonType.custom)
            btn.backgroundColor = UIColor.orange
            btn.frame = CGRect(x:15, y:15*(index+1)+45*index+64, width:Int(self.view.bounds.width-30), height:45)
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 5.0
            btn.setTitle(titleStr[index], for: UIControlState.normal)
            btn.setTitleColor(UIColor.white, for: UIControlState.normal)
            btn.tag = index
            btn.addTarget(self, action: #selector(BtnClick), for: UIControlEvents.touchUpInside)
            self.view.addSubview(btn)
            self.Btn = btn
        }
    }
    
    func BtnClick(button:UIButton){
        switch button.tag {
        // 同步缓存数据
        case 0:
            if YYCaChe.saveJsonResponseToCacheFile(responseObject as AnyObject, URL: URLString){
                print("(同步)保存/更新成功")
            }else{
                print("(同步)保存/更新失败")
            }
            break
            
        // 异步缓存数据
        case 1:
            YYCaChe.save_asyncJsonResponseToCacheFile(responseObject as AnyObject, URL: URLString) { (result) in
                if(result){
                    print("(异步)保存/更新成功")
                }else{
                    print("(异步)保存/更新成功")
                }
            }
            break
            
         // 获取缓存数据
        case 2:
            if let json = YYCaChe.cacheJsonWithURL(URLString){
                print(json)
            }
            break
            
        // 获取缓存大小（M）
        case 3:
            let size = YYCaChe.cacheSize()
            print("缓存大小(M)=\(size)")
            break
            
        // 获取缓存路径
        case 4:
            let path = YYCaChe.cachePath()
            print("缓存路径=" + path)
            break
            
       // 清除缓存
        case 5:
            if YYCaChe.clearCache(){
                print("清除缓存成功")
            }else{
                print("清除缓存失败")
            }
            break
            
        default:
            print("not button click")
            break
        }
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
