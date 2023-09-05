import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    private var isChoosen : Bool = false
    
    private let unselectedItemImage : UIImage = (UIImage.tickCircle?.withTintColor(.black))!.imageResized(to: CGSize(width: 23.08, height: 23.08))
    
    private let imageBubleView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 52).isActive = true
        view.widthAnchor.constraint(equalToConstant: 52).isActive = true
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
        lb.textAlignment = .center
         lb.numberOfLines = 0
        lb.text = "Fish"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
     lazy var weightLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegularLabel
        lb.textColor = .neutral50
        lb.textAlignment = .center
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
    
    private lazy var contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var leftStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var rightStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        contentView.layer.cornerRadius = 12
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(contentStack)
        contentStack.addArrangedSubview(leftStack)
        leftStack.addArrangedSubview(imageBubleView)
        imageBubleView.addSubview(ingredientImage)
        leftStack.addArrangedSubview(ingredientNameLabel)
        contentStack.addArrangedSubview(rightStack)
        rightStack.addArrangedSubview(weightLabel)
        rightStack.addArrangedSubview(checkMarkButton)
        
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            contentStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            contentStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),

            ingredientImage.topAnchor.constraint(equalTo: imageBubleView.topAnchor),
            ingredientImage.leadingAnchor.constraint(equalTo: imageBubleView.leadingAnchor),
            ingredientImage.trailingAnchor.constraint(equalTo: imageBubleView.trailingAnchor),
            ingredientImage.bottomAnchor.constraint(equalTo: imageBubleView.bottomAnchor),
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
