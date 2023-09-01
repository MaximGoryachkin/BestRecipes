//
//  OnboardingPageViewController.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.09.2023.
//

import UIKit

//MARK: - OnboardingPageViewController
class OnboardingPageViewController: UIPageViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        if let startViewController = getViewControllers().first {
            setViewControllers([startViewController], direction: .forward, animated: true)
        }
    }
    
    //MARK: - Methods
    private func getViewControllers() -> [UIViewController] {
        let onboarding1 = OnboardingMainViewController()
        let onboarding2 = OnboardingFirstViewController()
        let onboarding3 = OnboardingSecondViewController()
        let onboarding4 = OnboardingThirdViewController()
        return [onboarding1, onboarding2, onboarding3, onboarding4]
    }
}

//MARK: - UIPageViewControllerDataSource

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = getViewControllers().firstIndex(of: viewController), index > 0 else { return nil }
        return getViewControllers()[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = getViewControllers().firstIndex(of: viewController), index < getViewControllers().count - 1 else { return nil }
        return getViewControllers()[index + 1]
    }
}
