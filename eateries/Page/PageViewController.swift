//
//  PageViewController.swift
//  eateries
//
//  Created by Anna Zhaglina on 01.07.2021.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var headersArray = ["Записывайте", "Находите"]
    var subheadersArray = ["Создайте свой список любимых ресторанов", "Найдите и отметьте на кaрте ваши любимые рестораны"]
    var imagesArray = ["food", "iphone map"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let fistVC = displayViewController(atIndex: 0){
            setViewControllers([fistVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    func displayViewController(atIndex index: Int) -> ContentViewController? {
        guard index >= 0 else { return nil }
        guard index < headersArray.count else { return nil}
        guard let contentVC = storyboard?.instantiateViewController(identifier: "contentViewController") as? ContentViewController else { return nil }
        contentVC.imageFile = imagesArray[index]
        contentVC.header = headersArray[index]
        contentVC.subheader = subheadersArray[index]
        contentVC.index = index
        return contentVC
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index -= 1
        return displayViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index += 1
        return displayViewController(atIndex: index)
        
    }
}

