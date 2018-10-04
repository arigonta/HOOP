//
//  SwipeViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 03/10/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit

class SwipeViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var userData = UserDefaults.standard
    var pageControl = UIPageControl()
    var subViewController:[UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "demo1") as! demo1ViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "demo2") as! demo2ViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "demo3") as! demo3ViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileBoard") as! ProfileViewController
        ]
    }()
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 100,width: UIScreen.main.bounds.width,height: 70))
        self.pageControl.numberOfPages = subViewController.count
        self.pageControl.currentPage = 0
        self.pageControl.alpha = 1
        self.pageControl.tintColor = .black
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = .black
        self.view.addSubview(pageControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        setViewControllers([subViewController[0]], direction: .forward, animated: true, completion: nil)
        configurePageControl()
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewController.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = subViewController.index(of: pageContentViewController)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewController.index(of: viewController) ?? 0
        if (currentIndex <= 0){
            return nil
        }
        return subViewController[currentIndex-1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewController.index(of: viewController) ?? 0
        if (currentIndex >= subViewController.count-1){
            return nil
        }
        return subViewController[currentIndex+1]
    }
}
