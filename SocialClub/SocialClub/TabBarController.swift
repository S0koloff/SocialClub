//
//  TabBarController.swift
//  SocialClub
//
//  Created by Sokolov on 14.11.2023.
//

import UIKit

final class TabBarController {
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.tintColor = Colors.lightBlue
        tabBarController.tabBar.unselectedItemTintColor = Colors.gray
        
        let userListVC = UINavigationController(rootViewController: UserListVC())
        let historyVC = UINavigationController(rootViewController: HistoryVC())
        
        userListVC.tabBarItem = UITabBarItem(title: "List", image: Icons.tabBarUserList, selectedImage: Icons.tabBarUserListSelected)
        historyVC.tabBarItem = UITabBarItem(title: "History", image: Icons.tabBarHistory, selectedImage: Icons.tabBarHistory)
        
        tabBarController.setViewControllers([userListVC, historyVC], animated: true)
        
        return tabBarController
    }
}
