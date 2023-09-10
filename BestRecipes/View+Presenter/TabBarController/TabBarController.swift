//
//  TabBarController.swift
//  BestRecipes
//
//  Created by Ilyas Tyumenev on 30.08.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    private let kBarHeight: CGFloat = 120
    
    private lazy var plusButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        button.setBackgroundImage(UIImage(named: "createRecipeButton"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Override Methods
    override func loadView() {
        super.loadView()
        self.tabBar.addSubview(plusButton)
        setupCustomTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        plusButton.frame = CGRect(x: Int(self.tabBar.bounds.width)/2 - Int(plusButton.bounds.width)/2,
                                  y: 0,
                                  width: 48,
                                  height: 48)
        setupAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBar.frame.size.height = kBarHeight
        tabBar.frame.origin.y = view.frame.height - kBarHeight
    }
    
    // MARK: - Target actions
    @objc func plusButtonTapped() {
        let createRecipeViewController = CreateRecipeViewController()
        createRecipeViewController.modalPresentationStyle = .automatic
        present(createRecipeViewController, animated: true, completion: nil)
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
        self.tabBar.itemWidth = 40
    }
    
    private func setupItems() {
        let home = UINavigationController(rootViewController: HomeViewController())
        home.tabBarItem.image = .homeInactive
        home.tabBarItem.selectedImage = .homeActive
        
        let bookmarks = UINavigationController(rootViewController: DiscoverViewController())
        bookmarks.tabBarItem.image = .bookmarkInactive
        bookmarks.tabBarItem.selectedImage = .bookmarkActive
        
        let createRecipe = UIViewController()
        createRecipe.tabBarItem.isEnabled = false
        
        let notifications = UIViewController()
        notifications.tabBarItem.image = .notificationInactive
        notifications.tabBarItem.selectedImage = .notificationActive
        notifications.tabBarItem.isEnabled = false
        
        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.tabBarItem.image = .profileInactive
        profile.tabBarItem.selectedImage = .profileActive
        
        home.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: 15, bottom: -16, right: -15)
        bookmarks.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: 3, bottom: -16, right: -3)
        notifications.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: -3, bottom: -16, right: 3)
        profile.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: -15, bottom: -16, right: 15)
        
        setViewControllers([home, bookmarks, createRecipe, notifications, profile], animated: true)
    }
    
    private func createPath() -> CGPath {
        let minX: CGFloat = 0
        let centerX: CGFloat = self.tabBar.bounds.width/2
        let maxX: CGFloat = self.tabBar.bounds.width
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: minX, y: 14))
        path.addLine(to: CGPoint(x: centerX - 54.9, y: 14))
        path.addCurve(to: CGPoint(x: centerX - 32.9, y: 30),
                      controlPoint1: CGPoint(x: centerX - 45.1, y: 14),
                      controlPoint2: CGPoint(x: centerX - 36.9, y: 21.1))
        path.addCurve(to: CGPoint(x: centerX, y: 55),
                      controlPoint1: CGPoint(x: centerX - 27.7, y: 41.5),
                      controlPoint2: CGPoint(x: centerX - 17.8, y: 55))
        path.addCurve(to: CGPoint(x: centerX + 32.9, y: 30),
                      controlPoint1: CGPoint(x: centerX + 17.8, y: 55),
                      controlPoint2: CGPoint(x: centerX + 27.7, y: 41.5))
        path.addCurve(to: CGPoint(x: centerX + 54.9, y: 14),
                      controlPoint1: CGPoint(x: centerX + 36.9, y: 21.1),
                      controlPoint2: CGPoint(x: centerX + 45.1, y: 14))
        path.addLine(to: CGPoint(x: maxX, y: 14))
        path.addLine(to: CGPoint(x: maxX, y: kBarHeight))
        path.addLine(to: CGPoint(x: minX, y: kBarHeight))
        path.addLine(to: CGPoint(x: minX, y: -20))
        path.close()
        return path.cgPath
    }
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = .none
        appearance.backgroundImageContentMode = .scaleAspectFill
        appearance.shadowColor = .clear
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
