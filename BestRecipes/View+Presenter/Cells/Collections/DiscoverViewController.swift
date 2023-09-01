import UIKit

protocol DiscoverViewProtocol: AnyObject {
    func updateCollection(with recipes: [Recipe])
}

class DiscoverViewController: UIViewController {
    
    private var recipes = [Recipe]()
    
    // MARK: - UI Elements
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold24
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Saved recipes"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 34, height: 258)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setupCollection()
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 19),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingNowCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

}

// MARK: - CollectionView Delegate & DataSource

extension DiscoverViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrendingNowCollectionViewCell
        return cell
    }
    
    
}
