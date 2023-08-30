import UIKit

class TrendingViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold24
        lb.textColor = .neutral100
        lb.textAlignment = .center
        lb.text = "Trending now"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 34, height: 212)
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
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingNowCell.self, forCellWithReuseIdentifier: "cell")
    }

}

// MARK: - CollectionView Delegate & DataSource

extension TrendingViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrendingNowCell
        return cell
    }
    
    
}
