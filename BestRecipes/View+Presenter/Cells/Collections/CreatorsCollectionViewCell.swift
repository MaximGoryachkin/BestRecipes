import UIKit

class CreatorsCollectionViewCell: UICollectionViewCell {
    
    private let avatarImg : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 110).isActive = true
        img.widthAnchor.constraint(equalToConstant: 110).isActive = true
        img.clipsToBounds = true
        img.layer.cornerRadius = 55
        img.image = .add
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var authorNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        lb.textColor = .neutral100
        lb.textAlignment = .center
        lb.text = "Kathryn Murphy"
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
        contentView.addSubview(avatarImg)
        contentView.addSubview(authorNameLabel)
        
        NSLayoutConstraint.activate([
            avatarImg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            authorNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            authorNameLabel.topAnchor.constraint(equalTo: avatarImg.bottomAnchor, constant: 8),
        ])
    }
    
}
