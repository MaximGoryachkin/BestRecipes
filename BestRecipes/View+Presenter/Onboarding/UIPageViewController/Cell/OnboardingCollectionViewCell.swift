//
//  OnboardingCollectionViewCell.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 03.09.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UIElements
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.alpha = 0.5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.font = .poppinsBoldHeading
        label.textAlignment = .center
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews() {
        addSubview(backgroundImage)
        addSubview(mainTitle)
    }
    
    public func cellConfigure(model: OnboardingStruct) {
        backgroundImage.image = model.backgroundImage
        mainTitle.attributedText = model.mainTitle
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
            
            mainTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainTitle.heightAnchor.constraint(equalToConstant: 144),
            mainTitle.widthAnchor.constraint(equalToConstant: 280),
            mainTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200)
        ])
    }
}
