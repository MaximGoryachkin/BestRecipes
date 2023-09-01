import UIKit

protocol HomeViewProtocol: AnyObject {
    func setTrendingsData(_ array : [RecipeDataModel])
    
    func setImage(_ url: String)
}

class HomeViewController: UIViewController {
    
    // MARK: - Data
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 560)
    }
    
    var presenter: HomeViewPresenter!
    
    private var trendingsData : [RecipeDataModel] = []
    
    // MARK: - UI Elements
    
    private lazy var scrollView : UIScrollView = {
        let s = UIScrollView()
        s.contentSize = contentSize
        s.frame = view.bounds
        return s
    }()
    
    private lazy var contentView : UIView = {
        let content = UIView()
        content.frame.size = contentSize
        return content
    }()
    
    private lazy var contentStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.font = .poppinsBold24
        lb.numberOfLines = 0
        lb.text = "Get amazing recipes for cooking"
        return lb
    }()
    
    private let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search recipes"
        bar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        bar.searchBarStyle = .minimal
        bar.searchTextField.layer.borderColor = UIColor.neutral20.cgColor
        bar.searchTextField.layer.borderWidth = 2
        bar.searchTextField.layer.cornerRadius = 8
        bar.searchTextField.leftView?.tintColor = .neutral100
        bar.searchTextField.font = .poppinsRegularLabel
        bar.searchTextPositionAdjustment = UIOffset(horizontal: 5.0, vertical: 0.0);
        bar.setPositionAdjustment(UIOffset(horizontal: 10, vertical: 0), for: UISearchBar.Icon.search)
        bar.setImage(.search, for: .search, state: .normal)
        return bar
    }()
    
    private lazy var trendingMainStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var trendingTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold20
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Trending now 🔥"
        return lb
    }()
    
    private lazy var trendingSeeAllButton : UIButton = {
        let bt = UIButton()
        bt.setTitle("See all", for: .normal)
        bt.setTitleColor(.primary50, for: .normal)
        bt.setImage(.arrowRight, for: .normal)
        bt.titleLabel?.font = .poppinsBoldLabel
        bt.semanticContentAttribute = .forceRightToLeft
        bt.addTarget(self, action: #selector(trendingSeeAllTaped(_:)), for: .touchUpInside)
        return bt
    }()
   
    private let trendingCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 280, height: 254)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 260).isActive = true
        c.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var popularTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold20
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Popular category"
        return lb
    }()
    
    //
    private let categoryesNamesCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 83, height: 34)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 50).isActive = true
        c.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private let categoryesItemsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 231)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 245).isActive = true
        c.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var recentTitlesStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var recentTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold20
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Recent recipe"
        return lb
    }()
    
    private lazy var recentSeeAllButton : UIButton = {
        let bt = UIButton()
        bt.setTitle("See all", for: .normal)
        bt.setTitleColor(.primary50, for: .normal)
        bt.setImage(.arrowRight, for: .normal)
        bt.titleLabel?.font = .poppinsBoldLabel
        bt.semanticContentAttribute = .forceRightToLeft
        bt.addTarget(self, action: #selector(recentSeeAllTaped(_:)), for: .touchUpInside)
        return bt
    }()
    
    private let recentRecipeCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 124, height: 190)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 205).isActive = true
        c.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var creatorsTitlesStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var creatorsTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold20
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Popular creators"
        return lb
    }()
    
    private lazy var creatorsSeeAllButton : UIButton = {
        let bt = UIButton()
        bt.setTitle("See all", for: .normal)
        bt.setTitleColor(.primary50, for: .normal)
        bt.setImage(.arrowRight, for: .normal)
        bt.titleLabel?.font = .poppinsBoldLabel
        bt.semanticContentAttribute = .forceRightToLeft
        bt.addTarget(self, action: #selector(creatorsSeeAllTaped(_:)), for: .touchUpInside)
        return bt
    }()
    
    private let creatorsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 110, height: 136)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 142).isActive = true
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
        setupSearchBar()
        hideKeyboardWhenTappedAround()
        setupCollections()
        
        presenter = HomePresenter(view: self)
       // presenter.showImage()
//        presenter.loadTrendindsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadTrendindsData()

    }
    // MARK: - Buttons Methods
    
    @objc private func trendingSeeAllTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
    @objc private func recentSeeAllTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
    @objc private func creatorsSeeAllTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
    // MARK: - ConfigureUI

    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(searchBar)
        contentStackView.addArrangedSubview(trendingMainStack)
        trendingMainStack.addArrangedSubview(trendingTitleLabel)
        trendingMainStack.addArrangedSubview(trendingSeeAllButton)
        contentStackView.addArrangedSubview(trendingCollection)
        contentStackView.addArrangedSubview(popularTitleLabel)
        contentStackView.addArrangedSubview(categoryesNamesCollection)
        contentStackView.addArrangedSubview(categoryesItemsCollection)
        contentStackView.addArrangedSubview(recentTitlesStack)
        recentTitlesStack.addArrangedSubview(recentTitleLabel)
        recentTitlesStack.addArrangedSubview(recentSeeAllButton)
        contentStackView.addArrangedSubview(recentRecipeCollection)
        contentStackView.addArrangedSubview(creatorsTitlesStack)
        creatorsTitlesStack.addArrangedSubview(creatorsTitleLabel)
        creatorsTitlesStack.addArrangedSubview(creatorsSeeAllButton)
        contentStackView.addArrangedSubview(creatorsCollection)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            trendingMainStack.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            trendingMainStack.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            popularTitleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            recentTitlesStack.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            recentTitlesStack.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            creatorsTitlesStack.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            creatorsTitlesStack.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
        ])
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.updateHeight(height: 48)
    }
    
    private func setupCollections() {
        trendingCollection.delegate = self
        trendingCollection.dataSource = self
        trendingCollection.register(TrendingNowCollectionViewCell.self, forCellWithReuseIdentifier: "TrendingCell")
        
        categoryesNamesCollection.delegate = self
        categoryesNamesCollection.dataSource = self
        categoryesNamesCollection.register(CategoryesNamesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryNamesCell")
        
        categoryesItemsCollection.delegate = self
        categoryesItemsCollection.dataSource = self
        categoryesItemsCollection.register(CategoryesItemsCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryItemsCell")
        
        recentRecipeCollection.delegate = self
        recentRecipeCollection.dataSource = self
        recentRecipeCollection.register(RecentRecipeCollectionViewCell.self, forCellWithReuseIdentifier: "RecentCell")
        
        creatorsCollection.delegate = self
        creatorsCollection.dataSource = self
        creatorsCollection.register(CreatorsCollectionViewCell.self, forCellWithReuseIdentifier: "CreatorsCell")
    }
    
    
    
}

// MARK: - SearchBar Delegates

extension HomeViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
}

// MARK: - CollectionView Delegate & DataSource

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trendingCollection {
            return trendingsData.count
        } else if collectionView == categoryesNamesCollection {
            return 10
        } else if collectionView == categoryesItemsCollection {
            return 10
        } else if collectionView == recentRecipeCollection {
            return 10
        } else if collectionView == creatorsCollection {
            return 10
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == trendingCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as! TrendingNowCollectionViewCell
            
            let currentCell = trendingsData[indexPath.row]
            cell.cellData = currentCell
            cell.loadRecipeImage(cell.recipeStringUrl)
            return cell
            
        } else if collectionView == categoryesNamesCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryNamesCell", for: indexPath) as! CategoryesNamesCollectionViewCell
            
            return cell
            
        } else if collectionView == categoryesItemsCollection {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryItemsCell", for: indexPath) as! CategoryesItemsCollectionViewCell
            
            return cell
        } else if collectionView == recentRecipeCollection {
             
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCell", for: indexPath) as! RecentRecipeCollectionViewCell
            
            return cell
        } else if collectionView == creatorsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreatorsCell", for: indexPath) as! CreatorsCollectionViewCell
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryesNamesCollection {
            let currentCell = collectionView.cellForItem(at: indexPath) as! CategoryesNamesCollectionViewCell
            currentCell.didSelectedRow()
        }
    }
}


extension HomeViewController: HomeViewProtocol {
    
    func setTrendingsData(_ array : [RecipeDataModel]) {
        DispatchQueue.main.async {
                self.trendingsData = array
                self.trendingCollection.reloadData()
        }
    }
    
    
    func setImage(_ url: String) {
//        guard let url = URL(string: url) else { return }
//
//        // если картинка в кэше есть, то он их покажет
//        if let data = presenter.getDataFromCache(from: url) {
//            DispatchQueue.main.async {
//                self.image.image = UIImage(data: data)
//            }
//        }
//        // если нет, то возьмет из интернета и сохранит в кэш
//        ImageManager.shared.fetchImage(from: url) { data, response in
//            DispatchQueue.main.async {
//                self.image.image = UIImage(data: data)
//                self.presenter.saveDataToCache(with: data, and: response)
//            }
//        }
    }
    

}
