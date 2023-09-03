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
}

//MARK: - OnboardingViewController
class OnboardingViewController: UIViewController {
    
    //MARK: - UIElements
    private lazy var nextButton = CustomButton(style: .circleTextRed, title: "Continue")
    private lazy var skipButton = CustomButton(style: .skip, title: "Skip")
    
    private var mainBackgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "mainPage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
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
    
    //MARK: - Properties
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
        view.addSubview(mainBackgroundImage)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        view.addSubview(skipButton)
        skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: idOnboardingCell)
        
        guard let imageMain = UIImage(named: "mainPage"),
              let imageFirst = UIImage(named: "page1"),
              let imageSecond = UIImage(named: "page2"),
              let imageThird = UIImage(named: "page3") else {
                return
        }
        
        let mainScreen = OnboardingStruct(backgroundImage: imageMain, mainTitle: "Best Recipe")
        
        let firstScreen = OnboardingStruct(backgroundImage: imageFirst, mainTitle: "Recipes from all over the World")
        
        let secondScreen = OnboardingStruct(backgroundImage: imageSecond, mainTitle: "Recipes with each and every detail")
        
        let thirdScreen = OnboardingStruct(backgroundImage: imageThird, mainTitle: "Cook it now or save it for later")
        
        onboardingArray = [mainScreen, firstScreen, secondScreen, thirdScreen]
    }
    
    //MARK: - Methods
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc private func nextButtonPressed() {
        if collectionItem == 2 {
            nextButton.setTitle("Start Cooking", for: .normal)
            skipButton.isHidden = true
            
        }
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
        HomeViewController().modalPresentationStyle = .fullScreen
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
            
            mainBackgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainBackgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            mainBackgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainBackgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20),
            
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -35),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageControl.heightAnchor.constraint(equalToConstant: 30),
            
            nextButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -10),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 193),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            skipButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}
