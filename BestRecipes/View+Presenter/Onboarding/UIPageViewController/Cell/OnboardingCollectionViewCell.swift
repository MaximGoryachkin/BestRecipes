//
//  OnboardingCollectionViewCell.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 03.09.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mainPage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let topTitleImage: UIImageView = {
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
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews() {
        addSubview(backgroundImage)
        addSubview(topTitleImage)
        addSubview(topTitle)
        addSubview(mainTitle)
        addSubview(bottomLabel)
    }
    
    public func cellConfigure(model: OnboardingStruct) {
        backgroundImage.image = model.backgroundImage
        mainTitle.text = model.mainTitle
        topTitle.text = model.topTitle
        topTitleImage.image = model.topTitleImage
        bottomLabel.text = model.bottomTitle
    }
}

//MARK: - SetConstraints
extension OnboardingCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            topTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            topTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            topTitleImage.trailingAnchor.constraint(equalTo: topTitle.leadingAnchor, constant: -5),
            topTitleImage.centerYAnchor.constraint(equalTo: topTitle.centerYAnchor),
            topTitleImage.heightAnchor.constraint(equalToConstant: 16),
            topTitleImage.widthAnchor.constraint(equalToConstant: 16),
            
            bottomLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -55),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            mainTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainTitle.heightAnchor.constraint(equalToConstant: 160),
            mainTitle.widthAnchor.constraint(equalToConstant: 260),
            mainTitle.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: -10)
        ])
    }
}
