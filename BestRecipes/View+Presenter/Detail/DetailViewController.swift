import UIKit

protocol DetailViewProtocol: AnyObject {
    func updateRecipeInfo(_ data: RecipeDataModel)
    func retreveRecipeData(_ data: RecipeDataModel)
}

class DetailViewController: UIViewController {
    
    // MARK: - Data
    
    private var recipeInfoData : RecipeDataModel
    private var presenter : DetailViewPresenter!
    
    
    private var contentSize : CGSize {
            CGSize(width: view.frame.width, height: 500 + heightForIngredientsTV + heightForInstructionTV + 50)
    }
    
    // Value of this property we will change to count of cells at this TableView
    private var countOfCellIngredients : Int = 5
    
    private var heightForIngredientsTV : CGFloat {
        let result = recipeInfoData.ingredients.count * 92
        return CGFloat(result)
    }
    
    // Value of this property we will change to count of cells at this TableView
    private var countOfCellInstructionTV : Int = 5
    
    private var heightForInstructionTV : CGFloat {
        let result = recipeInfoData.coockingSteps.count * 73
        return CGFloat(result)
    }
    
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
        lb.text = "How to make Tasty Fish (point & Kill)"
        return lb
    }()
    
    private lazy var imageStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        stack.alignment = .leading
        return stack
    }()
    
    private let reciptImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage.moreHorizontal
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.heightAnchor.constraint(equalToConstant: 200).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var ratingStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 7
        stack.alignment = .center
        return stack
    }()
    
    private lazy var ratingbutton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.star?.imageResized(to: CGSize(width: 16, height: 16)), for: .normal)
        btn.setTitle("4.5", for: .normal)
        btn.setTitleColor(.neutral100, for: .normal)
        btn.titleLabel?.font = .poppinsBoldLabel
        btn.tintColor = .neutral100
        return btn
    }()
    
    private lazy var reviewsLabel : UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.neutral50
        lb.font = .poppinsRegularLabel
        lb.textAlignment = .center
        lb.text = "(300 Reviews)"
        return lb
    }()
    
    private lazy var instructionsLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold20
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Instructions"
        return lb
    }()
    
    private let instructionTableView : UITableView = {
        let tb = UITableView()
        tb.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        tb.separatorStyle = .none
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    private let ingredientsLabelsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var ingredientsMainLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold20
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Ingredients"
        return lb
    }()
    
    private lazy var itemsCountStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    private lazy var itemCountLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegularLabel
        lb.textColor = .neutral50
        lb.textAlignment = .center
        lb.text = "5"
        return lb
    }()
    
    private lazy var itemTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegularLabel
        lb.textColor = .neutral50
        lb.textAlignment = .center
        lb.text = "items"
        return lb
    }()
    
    private let ingredientsTableView : UITableView = {
        let tb = UITableView()
        tb.separatorStyle = .none
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    // MARK: - LifeCycle Methods
    
    init(recipeInfoData : RecipeDataModel) {
        self.recipeInfoData = recipeInfoData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setupTableViews()
        presenter = DetailPresenter(view: DetailViewController(recipeInfoData: recipeInfoData).self)
        presenter.getRecipeData(recipeInfoData)
        presenter.sendRecipeData()
        setupUIData()
        setupNavBar(on: self)
        figureReviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        saveToRecents(recipeInfoData)
    }
    
    // MARK: - ConfigureUI
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(imageStack)
        imageStack.addArrangedSubview(reciptImage)
        imageStack.addArrangedSubview(ratingStack)
        ratingStack.addArrangedSubview(ratingbutton)
        ratingStack.addArrangedSubview(reviewsLabel)
        contentStackView.addArrangedSubview(instructionsLabel)
        contentStackView.addArrangedSubview(instructionTableView)
        contentStackView.addArrangedSubview(ingredientsLabelsStack)
        ingredientsLabelsStack.addArrangedSubview(ingredientsMainLabel)
        ingredientsLabelsStack.addArrangedSubview(itemsCountStack)
        itemsCountStack.addArrangedSubview(itemCountLabel)
        itemsCountStack.addArrangedSubview(itemTitleLabel)
        contentStackView.addArrangedSubview(ingredientsTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            titleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 19),
            titleLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -19),
            reciptImage.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            reciptImage.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            ingredientsLabelsStack.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            ingredientsLabelsStack.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            instructionTableView.heightAnchor.constraint(equalToConstant: CGFloat(recipeInfoData.coockingSteps.count * 73)),
            ingredientsTableView.heightAnchor.constraint(equalToConstant: CGFloat(recipeInfoData.ingredients.count * 92)),
            ingredientsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ingredientsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupTableViews() {
        instructionTableView.delegate = self
        instructionTableView.dataSource = self
        instructionTableView.register(InstructionTableViewCell.self, forCellReuseIdentifier: "instructionCell")
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: "ingredientsCell")
    }
    
    private func setupUIData() {
        titleLabel.text = recipeInfoData.recipeTitle
        ratingbutton.setTitle(recipeInfoData.recipeRating, for: .normal)
        loadRecipeImage(recipeInfoData.recipeImage!)
        itemCountLabel.text = String(recipeInfoData.ingredients.count)
    }
    
    private func saveToRecents(_ recipe: RecipeDataModel) {
        let filtredArray = RecentRecipes.watchedRecipes.filter {$0.recipeTitle == recipe.recipeTitle}
        
        if filtredArray.count > 0 {
            print("recipe already whateched before")
        } else {
            RecentRecipes.watchedRecipes.append(recipe)
        }
    }
    
    private func figureReviews() {
        if recipeInfoData.recipeRating?.first == "5" {
            self.reviewsLabel.text = "(\(Int.random(in: 4000...10000)) Reviews)"
        } else if recipeInfoData.recipeRating?.first == "4" {
            self.reviewsLabel.text = "(\(Int.random(in: 2000...3999)) Reviews)"
        } else {
            self.reviewsLabel.text = "(\(Int.random(in: 1...1999)) Reviews)"
        }
    }
}

// MARK: - TableView Delegate & DataSource

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == instructionTableView {
            return recipeInfoData.coockingSteps.count
        } else {
            return recipeInfoData.ingredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == instructionTableView {
            let cell = instructionTableView.dequeueReusableCell(withIdentifier: "instructionCell", for: indexPath) as! InstructionTableViewCell

            let currentCell = recipeInfoData.coockingSteps[indexPath.row]
            let currentNumber = indexPath.row + 1
            
            cell.discriptionLabel.text = currentCell
            cell.countLabel.text = "\(currentNumber)."
            
            if indexPath.row == recipeInfoData.coockingSteps.count - 1 {
                cell.redText()
            }
            
            return cell
        } else {
            let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as! IngredientsTableViewCell
            
            let currentIngredient = recipeInfoData.ingredients[indexPath.row]
            cell.ingredientNameLabel.text = currentIngredient.name
            let stringAmount = String(format: "%.3g", currentIngredient.amount)
            cell.weightLabel.text = stringAmount + " " + currentIngredient.unit
            cell.loadImagwFromURL(pictureName: currentIngredient.image)
            return cell
        }
    }
    
   private func loadRecipeImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        if let data = NetworkManager.shared.getDataFromCache(from: url) {
            self.reciptImage.image = UIImage(data: data)
        } else {
            ImageManager.shared.fetchImage(from: url) { data, response in
                DispatchQueue.main.async {
                    self.reciptImage.image = UIImage(data: data)
                    NetworkManager.shared.saveDataToCache(with: data, and: response)
                }
            }
        }
    }
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    
    func retreveRecipeData(_ data: RecipeDataModel) {
        self.recipeInfoData = data
    }
    
    
    func updateRecipeInfo(_ data: RecipeDataModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = data.recipeTitle
        }
    }
    
}
