import UIKit

class CategoryesItemsCollectionViewCell: UICollectionViewCell {
    
    private var itemSaved : Bool = false
    
    private let itemImage : UIImageView = {
        let img = UIImageView()
        img.image = .profileActive
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 55
        img.clipsToBounds = true
        img.heightAnchor.constraint(equalToConstant: 110).isActive = true
        img.widthAnchor.constraint(equalToConstant: 110).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let contentBubbleView : UIView = {
        let view = UIView()
        view.backgroundColor = .neutral10
        view.heightAnchor.constraint(equalToConstant: 176).isActive = true
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var itemTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        lb.textColor = .neutral100
        lb.textAlignment = .center
        lb.text = "Chicken and Vegetable wrap"
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var timeStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 4
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var timeTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        lb.textColor = .neutral30
        lb.textAlignment = .left
        lb.text = "Time"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var timeStackInherenceStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var timeCountLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "5 Mins"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var favoriteButton : UIButton = {
        let btn = UIButton()
        btn.heightAnchor.constraint(equalToConstant: 34).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 34).isActive = true
        btn.layer.cornerRadius = 17
        btn.backgroundColor = .white
        btn.setImage(.bookmarkInactive, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(favoriteTaped(_:)), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(contentBubbleView)
        contentBubbleView.addSubview(itemImage)
        contentBubbleView.addSubview(itemTitleLabel)
        contentBubbleView.addSubview(timeStack)
        timeStack.addArrangedSubview(timeTitleLabel)
        timeStack.addArrangedSubview(timeStackInherenceStack)
        timeStackInherenceStack.addArrangedSubview(timeCountLabel)
        timeStackInherenceStack.addArrangedSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            contentBubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentBubbleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            itemImage.topAnchor.constraint(equalTo: contentBubbleView.topAnchor,constant: -55),
            itemImage.centerXAnchor.constraint(equalTo: contentBubbleView.centerXAnchor),
            
            itemTitleLabel.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 12),
            itemTitleLabel.leadingAnchor.constraint(equalTo: contentBubbleView.leadingAnchor, constant: 12),
            itemTitleLabel.trailingAnchor.constraint(equalTo: contentBubbleView.trailingAnchor, constant: -12),
          
            timeStack.bottomAnchor.constraint(equalTo: contentBubbleView.bottomAnchor, constant: -11),
            timeStack.leadingAnchor.constraint(equalTo: contentBubbleView.leadingAnchor, constant: 12),
            timeStack.trailingAnchor.constraint(equalTo: contentBubbleView.trailingAnchor, constant: -12),
           
            timeStackInherenceStack.trailingAnchor.constraint(equalTo: timeStack.trailingAnchor),
        ])
    }
    
    @objc private func favoriteTaped(_ sender: UIButton) {
        itemSaved = !itemSaved
        
        itemSaved == true ? sender.setImage(.bookmarkActive, for: .normal) : sender.setImage(.bookmarkInactive, for: .normal)
    }
}
