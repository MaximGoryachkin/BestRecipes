import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    private var isChoosen : Bool = false
    
    private let unselectedItemImage : UIImage = (UIImage.tickCircle?.withTintColor(.black))!.imageResized(to: CGSize(width: 23.08, height: 23.08))
    
    private let imageBubleView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ingredientImage : UIImageView = {
        let img = UIImageView()
        img.image = .plus
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var ingredientNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold16
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.8
        lb.text = "Fish"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var weightLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegularLabel
        lb.textColor = .neutral50
        lb.textAlignment = .right
        lb.numberOfLines = 0
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.8
        lb.text = "250g"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var checkMarkButton : UIButton = {
        let btn = UIButton()
        btn.setImage(unselectedItemImage, for: .normal)
        btn.addTarget(self, action: #selector(didChoose(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .neutral10
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        containerView.addSubview(imageBubleView)
        imageBubleView.addSubview(ingredientImage)
        containerView.addSubview(ingredientNameLabel)
        containerView.addSubview(weightLabel)
        containerView.addSubview(checkMarkButton)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageBubleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            imageBubleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            imageBubleView.heightAnchor.constraint(equalToConstant: 52),
            imageBubleView.widthAnchor.constraint(equalToConstant: 52),
            imageBubleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            ingredientImage.topAnchor.constraint(equalTo: imageBubleView.topAnchor),
            ingredientImage.leadingAnchor.constraint(equalTo: imageBubleView.leadingAnchor),
            ingredientImage.trailingAnchor.constraint(equalTo: imageBubleView.trailingAnchor),
            ingredientImage.bottomAnchor.constraint(equalTo: imageBubleView.bottomAnchor),
            
            ingredientNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            ingredientNameLabel.leadingAnchor.constraint(equalTo: imageBubleView.trailingAnchor, constant: 16),
            ingredientNameLabel.trailingAnchor.constraint(equalTo: weightLabel.leadingAnchor, constant: -16),
            ingredientNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),

            weightLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            weightLabel.widthAnchor.constraint(equalToConstant: 50),
            weightLabel.trailingAnchor.constraint(equalTo: checkMarkButton.leadingAnchor, constant: -27),
            weightLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),

            checkMarkButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkMarkButton.heightAnchor.constraint(equalToConstant: 23),
            checkMarkButton.widthAnchor.constraint(equalToConstant: 23),
            checkMarkButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func didChoose(_ sender: UIButton) {
        isChoosen = !isChoosen
        
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.isChoosen == true ? sender.setImage(UIImage.tickCircle?.imageResized(to: CGSize(width: 23.08, height: 23.08)), for: .normal) : sender.setImage(self.unselectedItemImage, for: .normal)
        }
    }
    
    func loadImagwFromURL(pictureName: String) {
        if let url = URL(string: "https://spoonacular.com/cdn/ingredients_100x100/"+pictureName) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.ingredientImage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    
}
