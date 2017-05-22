//
//  YYCollectionView.swift
//  YYLibiary
//
//  Created by YY on 2017/5/18.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit

typealias SelectClosure = (Int) -> Void

class YYCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectClosure: SelectClosure?
    // 本地图片数组
    var localizationImageNamesGroup = [String]()  {
        didSet {
            imagePathsGroup = localizationImageNamesGroup
        }
    }
    
    var imagePathsGroup = [String]() {
        didSet {
            invalidateTimer()
            totalItemsCount = infiniteLoop ? imagePathsGroup.count * 100 : imagePathsGroup.count
            if imagePathsGroup.count != 1 {
                collectionView?.isScrollEnabled = true
                if autoScroll {
                    setupTimer()
                }
            } else {
                collectionView?.isScrollEnabled = false
            }
        }
    }
    // 是否自动滚动，默认自动滚动
    var autoScroll = true{
        didSet {
            invalidateTimer()
            if autoScroll {
                setupTimer()
            }
        }
    }
    // 是否无限循环，默认无限循环
    var infiniteLoop = true {
        didSet {
            if imagePathsGroup.count != 0 {
                totalItemsCount = infiniteLoop ? imagePathsGroup.count * 100 : imagePathsGroup.count
                collectionView?.reloadData()
            }
        }
    }
    
    
    var totalItemsCount = 0 // 总共的图片数量
    var collectionView: UICollectionView?
    var layout = UICollectionViewFlowLayout()
    var timer = Timer()
    var pageControlDotSize: CGSize = CGSize(width: 10, height: 10)
    var currentPageDotColor: UIColor = UIColor.white // 当前分页控件小圆标颜色
    var pageDotColor: UIColor = UIColor.lightGray // 其他分页控件小圆标颜色
    //    var currentPageDotImage: UIImageView // 当前分页控件小圆标图片
    //    var pageDotImage: UIImageView // 其他分页控件小圆标图片
    var animation = CATransition()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
        setupColloctionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialization() {
        
        infiniteLoop = true // 默认无限
        autoScroll = true // 默认自动滚动
        currentPageDotColor = UIColor.white
        pageDotColor = UIColor.lightGray
        
    }
    
    func setupColloctionView() {
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.scrollsToTop = false
        collectionView?.backgroundColor = UIColor.red
        addSubview(collectionView!)
//        collectionView?.register(UINib.init(nibName: "CycleCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "YYcell")
    }
    
    static func cycleScrollView(frame: CGRect, imageNameGroup: [String]) -> YYCollectionView {
        let cycleScrollView  = YYCollectionView(frame: frame)
        cycleScrollView.localizationImageNamesGroup = imageNameGroup
        return cycleScrollView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout.itemSize = self.frame.size;
        
        if (collectionView!.contentOffset.x == 0 &&  totalItemsCount != 0) {
            var targetIndex = 0;
            if (self.infiniteLoop) {
                targetIndex = Int(Double(totalItemsCount) * 0.5);
            }else{
                targetIndex = 0;
            }
            setAnimation()
            collectionView?.layer.add(animation, forKey: nil)
            
            collectionView?.scrollToItem(at: NSIndexPath(item: targetIndex, section: 0) as IndexPath, at: .right, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YYcell", for: indexPath)
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CycleCell
        let itemIndex = pageControlIndexWithCurrentCellIndex(index: indexPath.item)
//        cell.backgroundImageView.kf.setImage(with: URL(string: imagePathsGroup[itemIndex]))
//        cell.backgroundImageView.image = UIImage(named: imagePathsGroup[itemIndex])
        
        let imageView = UIImageView(frame:cell.bounds)
        imageView.image = UIImage(named: imagePathsGroup[itemIndex])
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //QL2("\(indexPath.row)")
        if self.selectClosure != nil  {
            selectClosure!(indexPath.row % imagePathsGroup.count)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsCount
    }
    
    func pageControlIndexWithCurrentCellIndex(index: Int) -> Int {
        return index % imagePathsGroup.count
    }
    
    func currentIndex() -> Int {
        
        if collectionView?.frame.size.width == 0 || collectionView?.frame.size.height == 0 {
            return 0
        }
        
        var currentIndex = 0
        if layout.scrollDirection == .horizontal {
            currentIndex = Int(((collectionView?.contentOffset.x)! + layout.itemSize.width * 0.5) / layout.itemSize.width)
        } else {
            currentIndex = Int(((collectionView?.contentOffset.y)! + layout.itemSize.height * 0.5) / layout.itemSize.height)
        }
        
        return max(0, currentIndex)
    }
    
    func setupTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
        self.timer = timer
    }
    
    func automaticScroll() {
        let index = currentIndex()
        let targetIndex = index + 1
        scrollToIndex(targetIndex: targetIndex)
    }
    
    func scrollToIndex(targetIndex: Int) {
        // 小动画
        setAnimation()
        collectionView?.layer.add(animation, forKey: nil)
        
        if targetIndex >= totalItemsCount {
            if infiniteLoop {
                let index = targetIndex % totalItemsCount
                collectionView?.scrollToItem(at: NSIndexPath(item: Int(index), section: 0) as IndexPath, at: .right, animated: false)
            }
            return
        }
        
        
        collectionView?.scrollToItem(at: NSIndexPath(item: targetIndex, section: 0) as IndexPath, at: .right, animated: true)
    }
    
    func setAnimation() {
        animation = CATransition()
        //设置运动轨迹的速度
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);
        //设置动画类型为立方体动画
        animation.type = "suckEffect";
        //设置动画时长
        animation.duration = 1;
        //设置运动的方向
        animation.subtype = kCATransitionFromRight;
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        invalidateTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if autoScroll {
            setupTimer()
        }
    }
    
    func invalidateTimer() {
        timer.invalidate()
    }
    
    deinit {
        collectionView?.delegate = nil
        collectionView?.dataSource = nil
    }

}
