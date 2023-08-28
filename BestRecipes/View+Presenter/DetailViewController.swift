import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Data
    
    private var contentSize : CGSize {
            CGSize(width: view.frame.width, height: 500 + heightForIngredientsTV + heightForInstructionTV)
    }
    
    // Value of this property we will change to count of cells at this TableView
    private var countOfCellIngredients : Int = 5
    
    private var heightForIngredientsTV : CGFloat {
        let result = countOfCellIngredients * 92
        return CGFloat(result)
    }
    
    // Value of this property we will change to count of cells at this TableView
    private var countOfCellInstructionTV : Int = 5
    
    private var heightForInstructionTV : CGFloat {
        let result = countOfCellInstructionTV * 73
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
        img.widthAnchor.constraint(equalToConstant: 343).isActive = true
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
        btn.setImage(UIImage.star, for: .normal)
        btn.setTitle("4.5", for: .normal)
        btn.setTitleColor(.neutral100, for: .normal)
        btn.titleLabel?.font = .poppinsBold16
        btn.tintColor = .neutral100
        return btn
    }()
    
    private lazy var reviewsLabel : UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.neutral50
        lb.font = .poppinsRegular16
        lb.textAlignment = .center
        lb.text = "(300 Reviews)"
        return lb
    }()
    
    private lazy var instructionsLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold24
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Instructions"
        return lb
    }()
    
    private let instructionTableView : UITableView = {
        let tb = UITableView()
        tb.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        tb.separatorStyle = .none
        tb.isScrollEnabled = false
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
        lb.font = .poppinsBold24
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
        lb.font = .poppinsRegular16
        lb.textColor = .neutral50
        lb.textAlignment = .center
        lb.text = "5"
        return lb
    }()
    
    private lazy var itemTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular16
        lb.textColor = .neutral50
        lb.textAlignment = .center
        lb.text = "items"
        return lb
    }()
    
    private let ingredientsTableView : UITableView = {
        let tb = UITableView()
        tb.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        tb.separatorStyle = .none
        tb.isScrollEnabled = false
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setupTableViews()
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
            instructionsLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            ingredientsLabelsStack.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            ingredientsLabelsStack.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            instructionTableView.heightAnchor.constraint(equalToConstant: heightForInstructionTV),
            ingredientsTableView.heightAnchor.constraint(equalToConstant: heightForIngredientsTV),
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
}

// MARK: - TableView Delegate & DataSource

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == instructionTableView {
            return 5
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == instructionTableView {
            let cell = instructionTableView.dequeueReusableCell(withIdentifier: "instructionCell", for: indexPath) as! InstructionTableViewCell
            switch indexPath.row {
            case 0:
                cell.countLabel.text = "1."
                cell.discriptionLabel.text = "Place eggs in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel, and chop."
            case 1:
                cell.countLabel.text = "\(indexPath.row + 1)."
                cell.discriptionLabel.text = "Place chopped eggs in a bowl."
            case 2:
                cell.countLabel.text = "\(indexPath.row + 1)."
                cell.discriptionLabel.text = "Add chopped tomatoes, corns, lettuce, and any other vegitable of your choice."
            case 3:
                cell.countLabel.text = "\(indexPath.row + 1)."
                cell.discriptionLabel.text = "Stir in mayonnaise, green onion, and mustard. Season with paprika, salt, and pepper."
            default:
                cell.countLabel.text = nil
                cell.discriptionLabel.text = "Stir and serve on your favorite bread or crackers."
                cell.redText()
            }
            return cell
        } else {
            let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as! IngredientsTableViewCell
            print(cell.contentView.bounds.height)
            return cell
        }
    }
}

