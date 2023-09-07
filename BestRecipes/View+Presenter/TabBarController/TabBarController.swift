//
//  TabBarController.swift
//  BestRecipes
//
//  Created by Ilyas Tyumenev on 30.08.2023.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    private lazy var plusButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        button.setBackgroundImage(UIImage(named: "createRecipeButton"), for: .normal)
        return button
    }()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        plusButton.frame = CGRect(x: Int(self.tabBar.bounds.width)/2 - Int(plusButton.bounds.width)/2,
                                  y: -34,
                                  width: 48,
                                  height: 48)
    }
    
    override func loadView() {
        super.loadView()
        self.tabBar.addSubview(plusButton)
        setupCustomTabBar()
    }
    
    // MARK: - Private Methods
    private func setupCustomTabBar() {
        let shape = CAShapeLayer()
        shape.path = createPath()
        shape.fillColor = UIColor.white.cgColor
        shape.lineWidth = 8.0
        
        shape.shadowOffset = CGSize(width: 0, height: -1)
        shape.shadowColor = UIColor(red: 108/255, green: 108/255, blue: 108/255, alpha: 0.08).cgColor
        shape.shadowOpacity = 1
        self.tabBar.layer.insertSublayer(shape, at: 0)
    }
    
    private func setupItems() {
        let home = UINavigationController(rootViewController: HomeViewController())
        home.tabBarItem.image = UIImage(named: "Home/Inactive")
        home.tabBarItem.selectedImage = UIImage(named: "Home/Active")
        
        let bookmarks = DiscoverViewController()
        bookmarks.tabBarItem.image = UIImage(named: "Bookmark/Inactive")
        bookmarks.tabBarItem.selectedImage = UIImage(named: "Bookmark/Active")
        
        let createRecipe = CreateRecipeViewController()
        
        let notifications = UIViewController()
        notifications.tabBarItem.image = UIImage(named: "Notification/Inactive")
        notifications.tabBarItem.selectedImage = UIImage(named: "Notification/Active")
        notifications.tabBarItem.isEnabled = false
        
        let profile = ProfileViewController()
        profile.tabBarItem.image = UIImage(named: "Profile/Inactive")
        profile.tabBarItem.selectedImage = UIImage(named: "Profile/Active")
        
        home.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 15, bottom: 7, right: -15)
        bookmarks.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 3, bottom: 7, right: -3)
        createRecipe.tabBarItem.imageInsets = UIEdgeInsets(top: -35, left: -5, bottom: 32, right: -5)
        notifications.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: -3, bottom: 7, right: 3)
        profile.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: -15, bottom: 7, right: 15)
        
        setViewControllers([home, bookmarks, createRecipe, notifications, profile], animated: true)
    }
    
    private func createPath() -> CGPath {
        let minX: CGFloat = 0
        let centerX: CGFloat = self.tabBar.bounds.width/2
        let maxX: CGFloat = self.tabBar.bounds.width
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: minX, y: -20))
        path.addLine(to: CGPoint(x: centerX - 54.9, y: -20))
        path.addCurve(to: CGPoint(x: centerX - 32.9, y: -4),
                      controlPoint1: CGPoint(x: centerX - 45.1, y: -20),
                      controlPoint2: CGPoint(x: centerX - 36.9, y: -12.9))
        path.addCurve(to: CGPoint(x: centerX, y: 21),
                      controlPoint1: CGPoint(x: centerX - 27.7, y: 7.5),
                      controlPoint2: CGPoint(x: centerX - 17.8, y: 21))
        path.addCurve(to: CGPoint(x: centerX + 32.9, y: -4),
                      controlPoint1: CGPoint(x: centerX + 17.8, y: 21),
                      controlPoint2: CGPoint(x: centerX + 27.7, y: 7.5))
        path.addCurve(to: CGPoint(x: centerX + 54.9, y: -20),
                      controlPoint1: CGPoint(x: centerX + 36.9, y: -12.9),
                      controlPoint2: CGPoint(x: centerX + 45.1, y: -20))
        path.addLine(to: CGPoint(x: maxX, y: -20))
        path.addLine(to: CGPoint(x: maxX, y: 120))
        path.addLine(to: CGPoint(x: minX, y: 120))
        path.addLine(to: CGPoint(x: minX, y: -20))
        path.close()
        return path.cgPath
    }
}
