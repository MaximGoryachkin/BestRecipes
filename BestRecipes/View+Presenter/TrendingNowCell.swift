import UIKit

class TrendingNowCell: UICollectionViewCell {
    
    var cellData : RecipeDataModel? {
        didSet {
            self.starButton.setTitle("\(cellData?.recipeRating ?? "0.0")", for: .normal)
            self.ingredientsLabel.text = "\(cellData?.ingredients.count ?? 0) Ingredients"
            self.timeLabel.text = (cellData?.cookDuration)! + " " + "min"
        }
    }
    
    private var itemSaved : Bool = false
    
    private let picture : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 200).isActive = true
        img.widthAnchor.constraint(equalToConstant: 343).isActive = true
        img.image = .plus
        img.clipsToBounds = true
        img.layer.cornerRadius = 12
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var starButton : UIButton = {
        let btn = UIButton()
        btn.setImage(.star, for: .normal)
        btn.setTitle("5,0", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .neutral90.withAlphaComponent(0.3)
        btn.titleLabel?.font = .poppinsBoldLabel
        btn.heightAnchor.constraint(equalToConstant: 27.6).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 58).isActive = true
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var firstStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold16
        lb.textColor = .white
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.text = "How to make yam & vegetable sauce at home"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var descStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
  
    private lazy var ingredientsLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegularSmall
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "9 Ingredients"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let lineImage : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 18).isActive = true
        img.widthAnchor.constraint(equalToConstant: 1).isActive = true
        img.backgroundColor = .white
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var timeLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegularSmall
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "25 min"
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
        contentView.addSubview(picture)
        picture.addSubview(starButton)
        picture.addSubview(firstStackView)
        firstStackView.addArrangedSubview(titleLabel)
        firstStackView.addArrangedSubview(descStack)
        descStack.addArrangedSubview(ingredientsLabel)
        descStack.addArrangedSubview(lineImage)
        descStack.addArrangedSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: contentView.topAnchor),
            picture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            starButton.topAnchor.constraint(equalTo: picture.topAnchor, constant: 8),
            starButton.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 8),
            
            firstStackView.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 16),
            firstStackView.trailingAnchor.constraint(equalTo: picture.trailingAnchor, constant: 16),
            firstStackView.bottomAnchor.constraint(equalTo: picture.bottomAnchor, constant: -16)
        ])
        
    }

    func loadRecipeImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        if let data = NetworkManager.shared.getDataFromCache(from: url) {
            self.picture.image = UIImage(data: data)
        } else {
            ImageManager.shared.fetchImage(from: url) { data, response in
                DispatchQueue.main.async {
                    self.picture.image = UIImage(data: data)
                    NetworkManager.shared.saveDataToCache(with: data, and: response)
                }
            }
        }
    }
    
}
