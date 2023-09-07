import UIKit

class RecentRecipeCollectionViewCell: UICollectionViewCell {
    
    var cellData : RecipeDataModel? {
        didSet{
            self.imageString = (cellData?.recipeImage!)!
            self.authorLabel.text = "By \(cellData?.authorName ?? "unknow")"
            self.receptNameLabel.text = cellData?.recipeTitle
        }
    }
    
    var imageString : String = ""
    
    private let receptImage : UIImageView = {
        let img = UIImageView()
        img.image = .play
        img.heightAnchor.constraint(equalToConstant: 124).isActive = true
        img.widthAnchor.constraint(equalToConstant: 124).isActive = true
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 12
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var receptNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBoldLabel
        lb.textAlignment = .left
        lb.text = "Kelewele Ghanian Recipe"
        lb.numberOfLines = 2
        lb.textColor = .neutral100
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var authorLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBoldTiny
        lb.textAlignment = .left
        lb.text = "By Zeelicious Foods"
        lb.textColor = .neutral50
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
        contentView.addSubview(receptImage)
        contentView.addSubview(receptNameLabel)
        contentView.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            receptImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            receptImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            receptNameLabel.topAnchor.constraint(equalTo: receptImage.bottomAnchor, constant: 8),
            receptNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            receptNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            receptNameLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -5),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func loadRecipeImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        if let data = NetworkManager.shared.getDataFromCache(from: url) {
            self.receptImage.image = UIImage(data: data)
        } else {
            ImageManager.shared.fetchImage(from: url) { data, response in
                DispatchQueue.main.async {
                    self.receptImage.image = UIImage(data: data)
                    NetworkManager.shared.saveDataToCache(with: data, and: response)
                }
            }
        }
    }
}
