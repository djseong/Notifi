//
//  WelcomePageViewController.swift
//  Notifi
//
//  Created by Daniel Seong on 7/21/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class WelcomePageViewController: UIPageViewController, UIPageViewControllerDataSource {
    @IBOutlet var pageview: UIView!

    var viewcontrollers: [UIViewController] = [FirstPageController(nibName: "FirstPageController", bundle: nil), SecondPageViewController(nibName: "SecondPageViewController", bundle: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = viewcontrollers.first {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
        
        self.view.backgroundColor = UIColor.notifiDarkTeal()
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : AnyObject]?) {
        super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewcontrollers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewcontrollers.count > previousIndex else {
            return nil
        }
        
        return viewcontrollers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewcontrollers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = viewcontrollers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return viewcontrollers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewcontrollers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = viewcontrollers.indexOf(firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    


}
