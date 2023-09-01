//
//  OnboardingFirstViewController.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.09.2023.
//

import UIKit

//MARK: - OnboardingSecondViewController
class OnboardingSecondViewController: UIViewController {
    
    //MARK: - UIElements
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "page2")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let mainTitle: UILabel = {
        let label = UILabel()
        label.font = .poppinsBoldHeading
        label.text = "Recipes with each and every detail"
        label.textAlignment = .center
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 2
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .error10
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    private lazy var continueButton = CustomButton(style: .circleTextRed, title: "Continue")
    private lazy var skipButton = CustomButton(style: .skip, title: "Skip")
    
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
        view.addSubview(skipButton)
        continueButton.addTarget(self, action: #selector(continueButtonGetPressed), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonGetPressed), for: .touchUpInside)
    }
    
    //MARK: - Methods
    @objc private func continueButtonGetPressed() {
        let thirdVC = OnboardingThirdViewController()
        thirdVC.modalPresentationStyle = .fullScreen
        thirdVC.modalTransitionStyle = .crossDissolve
        present(thirdVC, animated: true)
    }
    
    @objc private func skipButtonGetPressed() {
        let mainVC = ViewController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .partialCurl
        present(mainVC, animated: true)
    }
}
//MARK: - OnboardingViewControllerDelegate

extension OnboardingSecondViewController: OnboardingViewControllerDelegate {
    func didChangePageIndex(index: Int) {
        pageControl.currentPage = index
    }
}

//MARK: - Set Constraints

extension OnboardingSecondViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            continueButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -10),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            continueButton.widthAnchor.constraint(equalToConstant: 193),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.heightAnchor.constraint(equalToConstant: 25),
            skipButton.widthAnchor.constraint(equalToConstant: 50),
            
            pageControl.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -35),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.heightAnchor.constraint(equalToConstant: 160),
            mainTitle.widthAnchor.constraint(equalToConstant: 260),
            mainTitle.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -35)
        ])
    }
}
