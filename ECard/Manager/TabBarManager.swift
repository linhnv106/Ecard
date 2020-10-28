//
//  TabBarManager.swift
//  BinaryNews
//
//  Created by Linh Nguyen on 8/31/20.
//  Copyright © 2020 BinaryFuel. All rights reserved.
//

import Foundation
import ESTabBarController_swift

class TabBarManager {
    static func systemStyle() -> UITabBarController {
        let tabBarController = UITabBarController()
        if let tabBar = tabBarController.tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .fillIncludeSeparator
        }
                let v1 = UIStoryboard.main.instantiateDashboardViewController()
                let v2 = UIStoryboard.main.instantiateHistoryViewController()
               let v3 = UIStoryboard.main.instantiateProfileViewController()

               v1?.tabBarItem = ESTabBarItem.init(TabBarItemView(),title: "Trang chủ", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))

            let nav = UINavigationController()
            nav.viewControllers  = [v1!]
        v2?.tabBarItem = ESTabBarItem.init(TabBarItemView(),title: "Lịch sử", image: UIImage(named: "history"), selectedImage: UIImage(named: "history"))
                v3?.tabBarItem = ESTabBarItem.init(TabBarItemView(),title: "Cá nhân", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))


               tabBarController.tabBar.shadowImage = nil
        let nav2 = UINavigationController()
        nav2.viewControllers  = [v3!]
        let nav3 = UINavigationController()
        nav3.viewControllers  = [v2!]
        tabBarController.viewControllers = [nav, nav3, nav2]
               
               return tabBarController
    }
}
