import UIKit

protocol TrendingCellProtocol {
    func updateItemSaved()
}

class TrendingNowCollectionViewCell: UICollectionViewCell {
    
    var cellData : RecipeDataModel? {
        didSet {
            self.itemSaved = cellData!.isSavedToFavorite!
            self.retingValueLabel.text = cellData?.recipeRating
            self.duratuinLabel.text = cellData?.cookDuration
            self.titleLabel.text = cellData?.recipeTitle
            self.authorNameLabel.text = cellData?.authorName
            self.recipeStringUrl = (cellData?.recipeImage)!
            self.avatarImage.image = cellData?.authorAvatar
        }
    }
    
    private var itemSaved : Bool = false
    var recipeStringUrl : String = ""
    
    private let imageBubble : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 180).isActive = true
        view.widthAnchor.constraint(equalToConstant: 280).isActive = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pickture : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "questionmark.folder")
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 12
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var rateStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let ratingBubleView : UIView = {
        let view = UIView()
        view.backgroundColor = .neutral90.withAlphaComponent(0.3)
        view.heightAnchor.constraint(equalToConstant: 27.6).isActive = true
        view.widthAnchor.constraint(equalToConstant: 58).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var ratingValuesStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 3
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let starIconImg : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 16).isActive = true
        img.widthAnchor.constraint(equalToConstant: 16).isActive = true
        img.image = .star!.imageResized(to: CGSize(width: 16, height: 16))
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var retingValueLabel : UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .poppinsBoldLabel
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var favoriteButton : UIButton = {
        let btn = UIButton()
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 16
        btn.backgroundColor = .white
        btn.setImage(UIImage(named: "Bookmark/Inactive"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(favoriteTaped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let videoDurationBuble : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .neutral90.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var duratuinLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegularLabel
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "2:00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var firstStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold16
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "How to sharwama at home"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var authStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let avatarImage : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 32).isActive = true
        img.widthAnchor.constraint(equalToConstant: 32).isActive = true
        img.clipsToBounds = true
        img.layer.cornerRadius = 16
        img.image = .plus
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var authorNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegularSmall
        lb.textColor = .neutral50
        lb.textAlignment = .left
        lb.text = "By Zeelicious foods"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(imageBubble)
        imageBubble.addSubview(pickture)
        imageBubble.addSubview(rateStack)
       // rateStack.addArrangedSubview(starButton)
        rateStack.addArrangedSubview(ratingBubleView)
        ratingBubleView.addSubview(ratingValuesStack)
        ratingValuesStack.addArrangedSubview(starIconImg)
        ratingValuesStack.addArrangedSubview(retingValueLabel)
        rateStack.addArrangedSubview(favoriteButton)
        imageBubble.addSubview(videoDurationBuble)
        videoDurationBuble.addSubview(duratuinLabel)
        contentView.addSubview(firstStackView)
        firstStackView.addArrangedSubview(titleLabel)
        contentView.addSubview(authStack)
        authStack.addArrangedSubview(avatarImage)
        authStack.addArrangedSubview(authorNameLabel)
        
        NSLayoutConstraint.activate([
            imageBubble.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBubble.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            pickture.topAnchor.constraint(equalTo: imageBubble.topAnchor),
            pickture.leadingAnchor.constraint(equalTo: imageBubble.leadingAnchor),
            pickture.trailingAnchor.constraint(equalTo: imageBubble.trailingAnchor),
            pickture.bottomAnchor.constraint(equalTo: imageBubble.bottomAnchor),

            rateStack.topAnchor.constraint(equalTo: imageBubble.topAnchor, constant: 8),
            rateStack.leadingAnchor.constraint(equalTo: imageBubble.leadingAnchor, constant: 8),
            rateStack.trailingAnchor.constraint(equalTo: imageBubble.trailingAnchor, constant: -8),

            ratingValuesStack.topAnchor.constraint(equalTo: ratingBubleView.topAnchor),
            ratingValuesStack.leadingAnchor.constraint(equalTo: ratingBubleView.leadingAnchor, constant: 8),
            ratingValuesStack.trailingAnchor.constraint(equalTo: ratingBubleView.trailingAnchor, constant: -7),
            ratingValuesStack.bottomAnchor.constraint(equalTo: ratingBubleView.bottomAnchor),
            
            videoDurationBuble.topAnchor.constraint(equalTo: imageBubble.topAnchor, constant: 147),
            videoDurationBuble.trailingAnchor.constraint(equalTo: imageBubble.trailingAnchor, constant: -8),

            duratuinLabel.centerXAnchor.constraint(equalTo: videoDurationBuble.centerXAnchor),
            duratuinLabel.centerYAnchor.constraint(equalTo: videoDurationBuble.centerYAnchor),
            
            firstStackView.topAnchor.constraint(equalTo: pickture.bottomAnchor, constant: 12),
            firstStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            firstStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            authStack.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 8),
            authStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
    
    @objc private func favoriteTaped(_ sender: UIButton) {
        guard let model = cellData else { return }
        itemSaved = !itemSaved
        
        if itemSaved {
            sender.setImage(UIImage(named: "Bookmark/Active"), for: .normal)
            DataManager.shared.arrayRecipes.updateValue(model, forKey: model.recipeId)
        } else {
            sender.setImage(UIImage(named: "Bookmark/Inactive"), for: .normal)
            DataManager.shared.arrayRecipes.removeValue(forKey: model.recipeId)
        }
    }
    
    
    func loadRecipeImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        if let data = NetworkManager.shared.getDataFromCache(from: url) {
            self.pickture.image = UIImage(data: data)
        } else {
            ImageManager.shared.fetchImage(from: url) { data, response in
                DispatchQueue.main.async {
                    self.pickture.image = UIImage(data: data)
                    NetworkManager.shared.saveDataToCache(with: data, and: response)
                }
            }
        }
    }
}

