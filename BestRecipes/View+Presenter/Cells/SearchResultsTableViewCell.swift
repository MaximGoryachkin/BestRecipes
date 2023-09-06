//
//  SearchResultsTableViewCell.swift
//  BestRecipes
//
//  Created by иван Бирюков on 05.09.2023.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    var cellData : RecipeDataModel? {
        didSet {
            self.imageURLString = (cellData?.recipeImage)!
            self.titleLabel.text = cellData?.recipeTitle
        }
    }
    
    private var imageURLString : String = ""

    private let bubbleView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .neutral10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let iconBubleView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "pinkwhen")
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold16
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Serves fdsfdssdfdsadasdaasdadsasdads"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var actionButton : UIButton = {
        let btn = UIButton()
        btn.setImage(.arrowRight, for: .normal)
        btn.addTarget(self, action: #selector(taped(_:)), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        selectionStyle = .none
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(contentStack)
        contentStack.addArrangedSubview(iconBubleView)
        iconBubleView.addSubview(iconImage)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(actionButton)
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            contentStack.topAnchor.constraint(equalTo: bubbleView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor),
            
            iconImage.topAnchor.constraint(equalTo: iconBubleView.topAnchor),
            iconImage.leadingAnchor.constraint(equalTo: iconBubleView.leadingAnchor),
            iconImage.trailingAnchor.constraint(equalTo: iconBubleView.trailingAnchor),
            iconImage.bottomAnchor.constraint(equalTo: iconBubleView.bottomAnchor),
        ])
    }
    
    @objc private func taped(_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
    func loadRecipeImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        if let data = NetworkManager.shared.getDataFromCache(from: url) {
            self.iconImage.image = UIImage(data: data)
        } else {
            ImageManager.shared.fetchImage(from: url) { data, response in
                DispatchQueue.main.async {
                    self.iconImage.image = UIImage(data: data)
                    NetworkManager.shared.saveDataToCache(with: data, and: response)
                }
            }
        }
    }

}
