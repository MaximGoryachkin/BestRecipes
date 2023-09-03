//
//  OnboardingFirstViewController.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.09.2023.
//

import UIKit

//MARK: - OnboardingThirdViewController
class OnboardingThirdViewController: UIViewController {
    
    //MARK: - UIElements
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "page3")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let mainTitle: UILabel = {
        let label = UILabel()
        label.font = .poppinsBoldHeading
        label.text = "Cook it now or save it for later"
        label.textAlignment = .center
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 3
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .error10
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    private lazy var continueButton = CustomButton(style: .circleTextRed, title: "Start Cooking")
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - SetupViews
    private func setupViews() {
        view.addSubview(backgroundImage)
        view.addSubview(mainTitle)
        view.addSubview(pageControl)
        view.addSubview(continueButton)
        continueButton.addTarget(self, action: #selector(startCookingGetPressed), for: .touchUpInside)
    }
    
    //MARK: - Methods
    @objc private func startCookingGetPressed() {
        let mainVC = HomeViewController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .partialCurl
        present(mainVC, animated: true)
    }
}
//MARK: - OnboardingViewControllerDelegate

extension OnboardingThirdViewController: OnboardingViewControllerDelegate {
    func didChangePageIndex(index: Int) {
        pageControl.currentPage = index
    }
}

//MARK: - Set Constraints

extension OnboardingThirdViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            continueButton.widthAnchor.constraint(equalToConstant: 193),
            
            pageControl.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -35),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.heightAnchor.constraint(equalToConstant: 160),
            mainTitle.widthAnchor.constraint(equalToConstant: 260),
            mainTitle.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -35)
        ])
    }
}
