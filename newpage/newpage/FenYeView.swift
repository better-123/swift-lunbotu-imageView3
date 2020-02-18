//
//  FenYeView.swift
//  newpage
//
//  Created by better on 2020/2/12.
//  Copyright © 2020 monstar. All rights reserved.
//

import UIKit

class FenYeView: UIView {

    
    //MARK: 属性
    lazy var leftImageView = UIImageView()
    lazy var centerImageView = UIImageView()
    lazy var rightImageView = UIImageView()

    lazy var scrollView = UIScrollView()

    lazy var pageControl = UIPageControl()
    
    var currentPage = 0
    
    var imageWidth: CGFloat = 0
    var imageHeight: CGFloat = 0
    
    var timer: Timer?
    
    var imageNames: [String]?
    
    //MARK: 自定义构造方法
    init(frame:CGRect , imageArr: [String]) {
        super.init(frame: frame)
        
        imageWidth = frame.width
        imageHeight = frame.height
        
        imageNames = imageArr
        
        setUP()
        loadPageContent()
        
        startTimer()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: 界面设置，定时器
extension FenYeView {
    
    
    func startTimer() {
        timer = Timer .scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    func setUP() {
        
        scrollView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        scrollView.contentSize = CGSize(width: imageWidth * 3, height: imageHeight)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.red
        
        
        
        leftImageView.frame = CGRect(x: imageWidth * 0, y: 0, width: imageWidth, height: imageHeight)
        leftImageView.backgroundColor = UIColor.yellow
        
        centerImageView.frame = CGRect(x: imageWidth * 1, y: 0, width: imageWidth, height: imageHeight)
        centerImageView.backgroundColor = UIColor.blue
        rightImageView.frame = CGRect(x: imageWidth * 2, y: 0, width: imageWidth, height: imageHeight)
        rightImageView.backgroundColor = UIColor.yellow
        
        scrollView.addSubview(leftImageView)
        scrollView.addSubview(centerImageView)
        scrollView.addSubview(rightImageView)
        
        scrollView.setContentOffset(CGPoint(x: imageWidth, y: 0), animated: false)
        
        self.addSubview(scrollView)
        
        if imageNames?.count ?? 0 < 2 {
            pageControl.isHidden = true
        } else {
            
            pageControl.frame = CGRect(x: ((imageWidth / 2) - (CGFloat((imageNames?.count ?? 0) * 20) / 2)), y: imageHeight - 40, width: CGFloat((imageNames?.count ?? 0) * 20), height: 20)
            pageControl.numberOfPages = imageNames?.count ?? 0
            pageControl.currentPage = currentPage
            pageControl.currentPageIndicatorTintColor = UIColor.red
            pageControl.pageIndicatorTintColor = UIColor.blue
            pageControl.backgroundColor = UIColor.gray
            
            self.addSubview(pageControl)
            
        }
    }
}

//MARK: 其他方法
extension FenYeView {
    @objc func nextPage() {
        
        UIView.animate(withDuration: 2.0) {
            
            self.currentPage = self.pageControl.currentPage + 1
            if self.currentPage == self.imageNames?.count {
                self.currentPage = 0
            }
            self.refeshImage()
            self.loadPageContent()
        }
    }

}

//MARK: 代理方法
extension FenYeView : UIScrollViewDelegate {
    
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        startTimer()
        refeshImage()
        
        loadPageContent()
        
        scrollView.contentOffset = CGPoint(x: imageWidth, y: 0)
        
        
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    
    
}
//MARK: 类中其他方法
extension FenYeView {
    
    
    func loadPageContent() {
        
        centerImageView.image = UIImage(named: imageNames?[currentPage] ?? "1.jpg")

        let leftIndex = (currentPage - 1 + (imageNames?.count ?? 0)) % (imageNames?.count ?? 0)
        leftImageView.image = UIImage(named: imageNames?[leftIndex] ?? "1.jpg")

        let rightIndex = (currentPage + 1) % (imageNames?.count ?? 0)
        rightImageView.image = UIImage(named: imageNames?[rightIndex] ?? "1.jpg")
        
        pageControl.currentPage = currentPage
        
    }
    
    func refeshImage() {
        
        if scrollView.contentOffset.x > imageWidth {
            //向左
            currentPage = (currentPage + 1) % (imageNames?.count ?? 0)
            
        } else if scrollView.contentOffset.x < imageWidth {
            //向右
            currentPage = (currentPage - 1 + (imageNames?.count ?? 0)) % (imageNames?.count ?? 0)
        }
    }
    
}
