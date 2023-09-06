//
//  TabBarVC.swift
//  BestRecipes
//
//  Created by Ilyas Tyumenev on 30.08.2023.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    private lazy var addButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "createRecipeButton"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupTabBar()
        setupTabBarBG()
        setupItems()
    }
    
    @objc func buttonPressed() {
        let createRecipeVC = CreateRecipeViewController()
        present(createRecipeVC, animated: true)
    }
    
    private func setupTabBar() {
        view.addSubview(addButton)
        setupButton()
    }
    
    private func setupItems() {
       // let home = HomeViewController()
        let home = UINavigationController(rootViewController: HomeViewController())
        home.tabBarItem.image = UIImage(named: "Home/Inactive")
        home.tabBarItem.selectedImage = UIImage(named: "Home/Active")
        
        let bookmarks = DiscoverViewController()
        bookmarks.tabBarItem.image = UIImage(named: "Bookmark/Inactive")
        bookmarks.tabBarItem.selectedImage = UIImage(named: "Bookmark/Active")
        
        let createRecipe = UIViewController()
        createRecipe.tabBarItem.isEnabled = false
        
        let notifications = UIViewController()
        notifications.tabBarItem.image = UIImage(named: "Notification/Inactive")
        notifications.tabBarItem.selectedImage = UIImage(named: "Notification/Active")
        
        let profile = ProfileViewController()
        profile.tabBarItem.image = UIImage(named: "Profile/Inactive")
        profile.tabBarItem.selectedImage = UIImage(named: "Profile/Active")
        
        home.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        bookmarks.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        notifications.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        profile.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 7, right: 0)
        
        
        setViewControllers([home, bookmarks, createRecipe, notifications, profile], animated: true)
        
    }
    
    private func setupTabBarBG() {
        let appearance = UITabBarAppearance()
        appearance.backgroundImage = UIImage(named: "tabBarBG")
        appearance.backgroundEffect = .none
        appearance.backgroundImageContentMode = .scaleAspectFill
        appearance.shadowColor = .clear
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setupButton() {
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor, constant: -40),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
