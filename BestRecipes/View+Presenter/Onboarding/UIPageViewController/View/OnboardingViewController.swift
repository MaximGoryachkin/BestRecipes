//
//  OnboardingViewController.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.09.2023.
//

import UIKit

//MARK: - OnboardingStruct
struct OnboardingStruct {
    let backgroundImage: UIImage
    let mainTitle: String
    let topTitle: String?
    let topTitleImage: UIImage?
    let bottomTitle: String?
    let nextButton: CustomButton?
    let skipButton: CustomButton?
}

//MARK: - OnboardingViewController
class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var nextButton = CustomButton(style: .squareTextRed, title: "Get Started")
    private lazy var skipButton = CustomButton(style: .skip, title: "Skip")
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .error10
        pageControl.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        pageControl.isEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let idOnboardingCell = "idOnboardingCell"
    
    private var onboardingArray = [OnboardingStruct]()
    
    private var collectionItem = 0
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    //MARK: - SetupViews
    private func setupViews() {
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        view.addSubview(collectionView)
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: idOnboardingCell)
        
        guard let imageMain = UIImage(named: "mainPage"),
              let starImage = UIImage(named: "star"),
              let imageFirst = UIImage(named: "page1"),
              let imageSecond = UIImage(named: "page2"),
              let imageThird = UIImage(named: "page3") else {
                return
        }
        
        let mainScreen = OnboardingStruct(backgroundImage: imageMain, mainTitle: "Best Recipe", topTitle: "100k+ premium recipes", topTitleImage: starImage, bottomTitle: "Find best recipes for cooking", nextButton: CustomButton(style: .squareTextRed, title: "Get Started"), skipButton: nil)
        
        let firstScreen = OnboardingStruct(backgroundImage: imageFirst, mainTitle: "Recipes from all over the World", topTitle: nil, topTitleImage: nil, bottomTitle: nil, nextButton: CustomButton(style: .circleTextRed, title: "Continue"), skipButton: CustomButton(style: .skip, title: "Skip"))
        
        let secondScreen = OnboardingStruct(backgroundImage: imageSecond, mainTitle: "Recipes with each and every detail", topTitle: nil, topTitleImage: nil, bottomTitle: nil, nextButton: CustomButton(style: .circleTextRed, title: "Continue"), skipButton: CustomButton(style: .skip, title: "Skip"))
        
        let thirdScreen = OnboardingStruct(backgroundImage: imageThird, mainTitle: "Cook it now or save it for later", topTitle: nil, topTitleImage: nil, bottomTitle: nil, nextButton: CustomButton(style: .circleTextRed, title: "Continue"), skipButton: nil)
        
        onboardingArray = [mainScreen, firstScreen, secondScreen, thirdScreen]
    }
    
    //MARK: - Methods
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc private func nextButtonPressed() {
        if collectionItem == 3 {
            saveUserDefaults()
            present(HomeViewController(), animated: true)
        } else {
            collectionItem += 1
            let index: IndexPath = [0, collectionItem]
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = collectionItem
        }
    }
    
    @objc private func skipButtonPressed() {
        saveUserDefaults()
        present(HomeViewController(), animated: true)
    }
    
    private func saveUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnboardingWasViewed")
    }
}

//MARK: - UICollectionViewDataSourse & DelegateFlowLayout
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idOnboardingCell, for: indexPath) as! OnboardingCollectionViewCell
        let model = onboardingArray[indexPath.row]
        cell.cellConfigure(model: model)
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}


//MARK: - SetConstraints
extension OnboardingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -35),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -10),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.widthAnchor.constraint(equalToConstant: 193),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.heightAnchor.constraint(equalToConstant: 25),
            skipButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
