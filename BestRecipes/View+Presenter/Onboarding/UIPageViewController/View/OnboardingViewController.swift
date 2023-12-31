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
    let mainTitle: NSMutableAttributedString
}

//MARK: - OnboardingViewController
class OnboardingViewController: UIViewController {
    
    //MARK: - UIElements
    private lazy var nextButton = CustomButton(style: .circleTextRed, title: "Continue")
    private lazy var skipButton = CustomButton(style: .skip, title: "Skip")
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
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
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Properties
    private var labelFirst: NSMutableAttributedString?
    private var labelSecond: NSMutableAttributedString?
    private var labelThird: NSMutableAttributedString?
    private let idOnboardingCell = "idOnboardingCell"
    private var onboardingArray = [OnboardingStruct]()
    private var collectionItem = 0
    private lazy var homeViewController = HomeViewController()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configurePageControl()
        setConstraints()
        setDelegates()
        UserDefaults.standard.set(true, forKey: "OnboardingWasViewed")
    }
    
    //MARK: - SetupViews
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: idOnboardingCell)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        view.addSubview(skipButton)
        skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        
        guard let imageFirst = UIImage(named: "firstOnboarding"),
              let imageSecond = UIImage(named: "secondOnboarding"),
              let imageThird = UIImage(named: "thirdOnboarding") else {
                return
        }
        
        labelFirst = setLabels(firstString: "Recipes from all", secondString: " over the World")
        labelSecond = setLabels(firstString: "Recipes with", secondString: " each and every detail")
        labelThird = setLabels(firstString: "Cook it now or", secondString: " save it for later")
        
        let firstScreen = OnboardingStruct(backgroundImage: imageFirst, mainTitle: labelFirst!)
        let secondScreen = OnboardingStruct(backgroundImage: imageSecond, mainTitle: labelSecond!)
        let thirdScreen = OnboardingStruct(backgroundImage: imageThird, mainTitle: labelThird!)
        
        onboardingArray = [firstScreen, secondScreen, thirdScreen]
    }
    
    //MARK: - Methods
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setLabels(firstString: String, secondString: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: firstString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]))
        attributedString.append(NSAttributedString(string: secondString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.rating]))
        return attributedString
    }
    
    @objc private func nextButtonPressed() {
        if collectionItem == 0 {
            nextPage()
        } else if collectionItem == 1 {
            nextPage()
            nextButton.setTitle("Start Cooking", for: .normal)
            skipButton.isHidden = true
        } else if collectionItem == 2 {
            showHomeScreen()
        }
    }
    
    @objc private func skipButtonPressed() {
        showHomeScreen()
    }
    
    private func nextPage() {
        collectionItem += 1
        let index: IndexPath = [0, collectionItem]
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = collectionItem
    }
    
    private func configurePageControl() {
        pageControl.numberOfPages = onboardingArray.count
            pageControl.currentPage = 0
            if #available(iOS 14.0, *) {
                pageControl.preferredIndicatorImage = UIImage(named: "pageIndicator")
            }
            pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .error10
    }
    
    private func showHomeScreen() {
        let resultVC = AuthViewController()
        resultVC.modalPresentationStyle = .fullScreen
        present(resultVC, animated: true)
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
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
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
