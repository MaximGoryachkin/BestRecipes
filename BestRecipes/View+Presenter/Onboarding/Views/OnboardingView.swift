//
//  OnboardingView.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 28.08.2023.
//

import UIKit

//MARK: - OnboardingViewController
class OnboardingMainViewController: UIViewController {
    
    //MARK: - UIElements
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mainPage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleImage: UIImageView = {
        let image = UIImageView()
        image.image = .star
        image.tintColor = .neutral100
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let topTitle: UILabel = {
        let label = UILabel()
        label.text = "100k+ premium recipes"
        label.font = .poppinsRegular20
        label.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.font = .poppinsBoldHeading
        label.text = "Best Recipe"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Find best recipes for cooking"
        label.font = .poppinsRegular20
        label.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var startButton = CustomButton(style: .squareTextRed, title: "Get Started")

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - setupViews
    private func setupViews() {
        view.addSubview(backgroundImage)
        view.addSubview(titleImage)
        view.addSubview(topTitle)
        view.addSubview(mainTitle)
        view.addSubview(bottomLabel)
        view.addSubview(startButton)
        startButton.addTarget(self, action: #selector(startButtonGetPressed), for: .touchUpInside)
    }
    
    //MARK: - Methods
    @objc private func startButtonGetPressed() {
        let firstVC = OnboardingFirstViewController()
        firstVC.modalPresentationStyle = .fullScreen
        firstVC.modalTransitionStyle = .crossDissolve
        present(firstVC, animated: true)
    }
}

//MARK: - setConstraints
extension OnboardingMainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            topTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleImage.trailingAnchor.constraint(equalTo: topTitle.leadingAnchor, constant: -5),
            titleImage.centerYAnchor.constraint(equalTo: topTitle.centerYAnchor),
            titleImage.heightAnchor.constraint(equalToConstant: 16),
            titleImage.widthAnchor.constraint(equalToConstant: 16),
            
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 56),
            startButton.widthAnchor.constraint(equalToConstant: 156),
            
            bottomLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -35),
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.heightAnchor.constraint(equalToConstant: 160),
            mainTitle.widthAnchor.constraint(equalToConstant: 260),
            mainTitle.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: -10)
        ])
    }
}
