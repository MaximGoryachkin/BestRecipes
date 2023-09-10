import UIKit

protocol DiscoverViewProtocol: AnyObject {
    func updateCollection(with recipes: [RecipeDataModel])
}

class DiscoverViewController: UIViewController {
    
    var presenter: DiscoverPresenter!
    var recipes = [RecipeDataModel]()
    
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
        
        presenter = DiscoverPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        presenter.updateRecipes()
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 27),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SavedRecipesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

}

// MARK: - CollectionView Delegate & DataSource

extension DiscoverViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if recipes.count != 0 {
            return recipes.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SavedRecipesCollectionViewCell
        
        if recipes.count != 0 {
            let currentCell = recipes[indexPath.row]
            cell.cellData = currentCell
            cell.loadRecipeImage(currentCell.recipeImage)
            cell.favoriteButton.isEnabled = true
            cell.delegate = self
        } else {
            let placeholder = RecipeDataModel(recipeId: 0, recipeImage: "https://static.vecteezy.com/system/resources/previews/000/302/923/original/vector-opposite-adjective-full-and-empty.jpg", recipeRating: "0.0", cookDuration: "0", recipeTitle: "No Favorits Recipes now", authorAvatar: UIImage(named: "Avatar")!, authorName: "Admin", isSavedToFavorite: false, coockingSteps: [], ingredients: [], categoryName: "")
            cell.cellData = placeholder
            cell.loadRecipeImage(placeholder.recipeImage)
            cell.favoriteButton.isEnabled = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
        if recipes.count != 0 {
            let seletedItemData = recipes[indexPath.row]
            self.navigationController?.pushViewController(DetailViewController(recipeInfoData: seletedItemData), animated: true)
        }
    }
    
}

// MARK: - Presenter Protocol

extension DiscoverViewController: DiscoverViewProtocol {
    func updateCollection(with recipes: [RecipeDataModel]) {
        DispatchQueue.main.async {
            self.recipes = recipes
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Collection Cell Protocols

extension DiscoverViewController: TrendingCellDelegate, CategoryCellDelegate {
    func updateTrendingData(with id: Int) {
        recipes = recipes.filter {
            $0.recipeId != id
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func updateCategoryData(with id: Int) {
        recipes = recipes.filter {
            $0.recipeId != id
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
