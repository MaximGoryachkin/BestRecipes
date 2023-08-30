//
//  TabBarVC.swift
//  BestRecipes
//
//  Created by Ilyas Tyumenev on 30.08.2023.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupTabBar()
        setupTabBarBG()
        setupItems()
        setupCreateRecipeButton()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .white
    }
    
    private func setupItems() {
        let home = UIViewController()
        home.tabBarItem.image = UIImage(named: "Home/Inactive")
        home.tabBarItem.selectedImage = UIImage(named: "Home/Active")
        
        let bookmarks = UIViewController()
        bookmarks.tabBarItem.image = UIImage(named: "Bookmark/Inactive")
        bookmarks.tabBarItem.selectedImage = UIImage(named: "Bookmark/Active")
        
        let createRecipe = UIViewController()
        
        let notifications = UIViewController()
        notifications.tabBarItem.image = UIImage(named: "Notification/Inactive")
        notifications.tabBarItem.selectedImage = UIImage(named: "Notification/Active")
        
        let profile = UIViewController()
        profile.tabBarItem.image = UIImage(named: "Profile/Inactive")
        profile.tabBarItem.selectedImage = UIImage(named: "Profile/Active")
        
        home.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        bookmarks.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        notifications.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        profile.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        
        setViewControllers([home, bookmarks, createRecipe, notifications, profile], animated: true)
    }
    
    private func setupCreateRecipeButton() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 24, y: -37, width: 48, height: 48))        
        middleButton.setImage(UIImage(named: "createRecipeButton"), for: .normal)
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(createRecipeButtonPressed), for: .touchUpInside)
        self.view.layoutIfNeeded()
    }
    
    @objc func createRecipeButtonPressed(sender: UIButton) {
        print("createRecipeButtonPressed")
    }
    
    private func setupTabBarBG() {
        let tabBarBG = UIImageView()
        tabBarBG.image = UIImage(named: "tabBarBG")
        tabBarBG.contentMode = .scaleAspectFill
        tabBarBG.frame = tabBar.bounds
        tabBar.addSubview(tabBarBG)
        tabBar.sendSubviewToBack(tabBarBG)
    }
}
