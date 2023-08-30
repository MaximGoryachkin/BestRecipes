import UIKit

class TrendingNowCollectionViewCell: UICollectionViewCell {
    
    private var itemSaved : Bool = false
    
    private let pickture : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 180).isActive = true
        img.widthAnchor.constraint(equalToConstant: 240).isActive = true
        img.image = .plus
        img.clipsToBounds = true
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
    
    private lazy var starButton : UIButton = {
        let btn = UIButton()
        btn.setImage(.star, for: .normal)
        btn.setTitle("4,5", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .neutral30.withAlphaComponent(0.5)
        btn.tintColor = .neutral100
        btn.titleLabel?.font = .poppinsBoldLabel
        btn.heightAnchor.constraint(equalToConstant: 30.6).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 60).isActive = true
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
    
    private lazy var playButton : UIButton = {
        let btn = UIButton()
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 48).isActive = true
        btn.layer.cornerRadius = 24
        btn.setImage(.play, for: .normal)
        btn.backgroundColor = .neutral30.withAlphaComponent(0.5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(playTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let videoDurationBuble : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .neutral30.withAlphaComponent(0.5)
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
        lb.font = .poppinsBoldLabel
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "How to sharwama at home"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var dotsButton : UIButton = {
        let btn = UIButton()
        btn.setImage(.moreVertical, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        lb.font = .poppinsRegularLabel
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
        contentView.addSubview(pickture)
        contentView.addSubview(rateStack)
        rateStack.addArrangedSubview(starButton)
        rateStack.addArrangedSubview(favoriteButton)
        contentView.addSubview(playButton)
        contentView.addSubview(videoDurationBuble)
        videoDurationBuble.addSubview(duratuinLabel)
        contentView.addSubview(firstStackView)
        firstStackView.addArrangedSubview(titleLabel)
        firstStackView.addArrangedSubview(dotsButton)
        contentView.addSubview(authStack)
        authStack.addArrangedSubview(avatarImage)
        authStack.addArrangedSubview(authorNameLabel)
        
        NSLayoutConstraint.activate([
            pickture.topAnchor.constraint(equalTo: contentView.topAnchor),
            pickture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            rateStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            rateStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            rateStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            playButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 66),
            playButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            videoDurationBuble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 147),
            videoDurationBuble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
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
        itemSaved = !itemSaved
        
        itemSaved == true ? sender.setImage(.bookmarkActive, for: .normal) : sender.setImage(.bookmarkInactive, for: .normal)
    }
    
    @objc private func playTapped (_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
}
