import UIKit

protocol TrendingViewProtocol : AnyObject {
    func addTenMoreTrendings(_ array : [RecipeDataModel]) 
}

class TrendingViewController: UIViewController {
    
    // MARK: - Data
    
    private var dataArray : [RecipeDataModel]
    private var presenter : TrendingViewPresenter!
    
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
    
    init(dataArray: [RecipeDataModel]) {
        self.dataArray = dataArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrendingNowCell
        let currentCell = dataArray[indexPath.row]
        cell.cellData = currentCell
        cell.loadRecipeImage(currentCell.recipeImage!)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endScrolling = collectionView.contentOffset.y + collectionView.frame.size.height
        if endScrolling >= collectionView.contentSize.height {
            presenter.loadMoreTrendings()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let celetedItemData = dataArray[indexPath.row]
        
        self.navigationController?.pushViewController(DetailViewController(recipeInfoData: celetedItemData), animated: true)
    }
}

// MARK: - TrendingViewProtocol

extension TrendingViewController : TrendingViewProtocol {
    
    func addTenMoreTrendings(_ array: [RecipeDataModel]) {
        self.dataArray += array
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}
