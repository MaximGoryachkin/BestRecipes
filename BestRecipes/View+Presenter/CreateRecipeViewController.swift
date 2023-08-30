import UIKit

class CreateRecipeViewController: UIViewController {
    
    // MARK: - Data
    
    private var countOfSettingsCells : Int = 2
    
    private var heightForSettingTV : CGFloat {
        let result = 72 * countOfSettingsCells
        return CGFloat(result)
    }
    
    // MARK: - UI Elements
    
    private lazy var contentStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold24
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Create recipe"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let imageBubleView : UIView = {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recipeImage : UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = UIImage.plus
        img.layer.cornerRadius = 12
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var additButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 16
        btn.setImage(.edit, for: .normal)
        btn.addTarget(self, action: #selector(additTaped(_ :)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let photoPikerView : UIImagePickerController = {
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        return piker
    }()
    
    private let recipeNameTextView : UITextView = {
        let text = UITextView()
        text.heightAnchor.constraint(equalToConstant: 44).isActive = true
        text.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        text.layer.cornerRadius = 8
        text.layer.borderColor = UIColor.primary50.cgColor
        text.layer.borderWidth = 1
        text.textAlignment = .center
        text.font = .poppinsRegularLabel
        text.textColor = .neutral100
        text.text = "Enter Recipe Name"
        text.returnKeyType = .done
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let settingTableView : UITableView = {
        let tb = UITableView()
        tb.separatorStyle = .none
        tb.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    private lazy var ingredientsTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold20
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Ingredients"
        return lb
    }()
    
    private let ingredientsTableView : UITableView = {
        let tb = UITableView()
        tb.separatorStyle = .none
        tb.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tb.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        addSubviews()
        setupConstraints()
        setupPicker()
        setupTextView()
        setupTableViews()
        
    }
    
    // MARK: - Buttons Methods
    
    @objc private func additTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.present(self.photoPikerView, animated: true)
        }
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(imageBubleView)
        imageBubleView.addSubview(recipeImage)
        imageBubleView.addSubview(additButton)
        contentStackView.addArrangedSubview(recipeNameTextView)
        contentStackView.addArrangedSubview(settingTableView)
        contentStackView.addArrangedSubview(ingredientsTitleLabel)
        contentStackView.addArrangedSubview(ingredientsTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            recipeImage.topAnchor.constraint(equalTo: imageBubleView.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: imageBubleView.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: imageBubleView.trailingAnchor),
            recipeImage.bottomAnchor.constraint(equalTo: imageBubleView.bottomAnchor),
            
            additButton.topAnchor.constraint(equalTo: imageBubleView.topAnchor, constant: 8),
            additButton.trailingAnchor.constraint(equalTo: imageBubleView.trailingAnchor, constant: -8),
            
            settingTableView.heightAnchor.constraint(equalToConstant: heightForSettingTV),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
        ])
    }
    
    private func setupPicker() {
        photoPikerView.delegate = self
        photoPikerView.sourceType = .photoLibrary
    }
    
    private func setupTextView() {
        recipeNameTextView.delegate = self
    }
    
    private func setupTableViews() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(CreateIngredientsTableViewCell.self, forCellReuseIdentifier: "ingredients")
    }
}

// MARK: - PickerView Delegate

extension CreateRecipeViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let choosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.recipeImage.image = choosenImage
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextView Delegate

extension CreateRecipeViewController : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
}

 // MARK: - UITableView Delegate & DataSource

extension CreateRecipeViewController : UITableViewDelegate & UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == settingTableView {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == settingTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell",for: indexPath) as! SettingTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredients", for: indexPath) as! CreateIngredientsTableViewCell
            
            return cell
        }
    }
}
