import UIKit

class CategoryesNamesCollectionViewCell: UICollectionViewCell {
    
    private let mainTitle : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular16
        lb.textColor = .primary20
        lb.textAlignment = .left
        lb.text = "Breakfast"
        lb.numberOfLines = 1
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
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        contentView.addSubview(mainTitle)
        
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func changesForSelected() {
        contentView.backgroundColor = .primary50
        mainTitle.textColor = .white
    }
}
