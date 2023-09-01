//
//  TabBarVC.swift
//  BestRecipes
//
//  Created by Ilyas Tyumenev on 30.08.2023.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    func updateRecipeStorage(with recipe: Int)
}

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    private var recipesID = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupTabBar()
        setupTabBarBG()
        setupItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .white
    }
    
    private func setupItems() {
        let home = HomeViewController()
        home.tabBarItem.image = UIImage(named: "Home/Inactive")
        home.tabBarItem.selectedImage = UIImage(named: "Home/Active")
        
        let bookmarks = DiscoverViewController()
        let discoverPresenter = DiscoverPresenter(recipesID: recipesID)
        bookmarks.tabBarItem.image = UIImage(named: "Bookmark/Inactive")
        bookmarks.tabBarItem.selectedImage = UIImage(named: "Bookmark/Active")
        
        let createRecipe = CreateRecipeViewController()
        createRecipe.tabBarItem.image = UIImage(named: "createRecipeButton")
        
        let notifications = UIViewController()
        notifications.tabBarItem.image = UIImage(named: "Notification/Inactive")
        notifications.tabBarItem.selectedImage = UIImage(named: "Notification/Active")
        
        let profile = UIViewController()
        profile.tabBarItem.image = UIImage(named: "Profile/Inactive")
        profile.tabBarItem.selectedImage = UIImage(named: "Profile/Active")
        
        home.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        bookmarks.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        createRecipe.tabBarItem.imageInsets = UIEdgeInsets(top: -37, left: 0, bottom: 37, right: 0)
        notifications.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        profile.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        
        
        setViewControllers([home, bookmarks, createRecipe, notifications, profile], animated: true)
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

extension TabBarVC: TabBarViewProtocol {
    func updateRecipeStorage(with recipe: Int) {
        recipesID.insert(recipe)
    }
}
