import UIKit

class CreateRecipeViewController: UIViewController {
    
    // MARK: - Data
    
    private var countOfSettingsCells : Int = 2
    
    private var heightForSettingTV : CGFloat {
        let result = 72 * countOfSettingsCells
        return CGFloat(result)
    }
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 100)
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
    
    private let recipeNameTextField : UITextField = {
        let field = UITextField()
        field.heightAnchor.constraint(equalToConstant: 44).isActive = true
        field.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        field.layer.cornerRadius = 8
        field.layer.borderColor = UIColor.primary50.cgColor
        field.layer.borderWidth = 1
        field.textAlignment = .left
        field.font = .poppinsRegularLabel
        field.textColor = .neutral100
        field.placeholder = "Enter Recipe Name"
        field.returnKeyType = .done
        field.setLeftPaddingPoints(15)
        field.clearButtonMode = .whileEditing
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
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
        tb.heightAnchor.constraint(equalToConstant: 165).isActive = true
        tb.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    private lazy var addNewIngrButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Add new Ingredient", for: .normal)
        btn.setTitleColor(.neutral100, for: .normal)
        btn.titleLabel?.font = .poppinsBold16
        btn.setImage(.plus, for: .normal)
        btn.addTarget(self, action: #selector(addIngredientTaped(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var createButton = CustomButton(style: .squareTextRed , title: "Create recipe")
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        addSubviews()
        setupConstraints()
        setupPicker()
        setupTextFields()
        setupTableViews()
        setupButton()
        registerForKeyBoardNotifications()
    }
    
    deinit {
        removeKeyBoardNotification()
    }
    
    // MARK: - Buttons Methods
    
    @objc private func additTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.present(self.photoPikerView, animated: true)
        }
    }
    
    @objc private func addIngredientTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
    @objc private func createTapped() {
        
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(imageBubleView)
        imageBubleView.addSubview(recipeImage)
        imageBubleView.addSubview(additButton)
        contentStackView.addArrangedSubview(recipeNameTextField)
        contentStackView.addArrangedSubview(settingTableView)
        contentStackView.addArrangedSubview(ingredientsTitleLabel)
        contentStackView.addArrangedSubview(ingredientsTableView)
        contentStackView.addArrangedSubview(addNewIngrButton)
        contentStackView.addArrangedSubview(createButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            recipeImage.topAnchor.constraint(equalTo: imageBubleView.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: imageBubleView.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: imageBubleView.trailingAnchor),
            recipeImage.bottomAnchor.constraint(equalTo: imageBubleView.bottomAnchor),
            
            additButton.topAnchor.constraint(equalTo: imageBubleView.topAnchor, constant: 8),
            additButton.trailingAnchor.constraint(equalTo: imageBubleView.trailingAnchor, constant: -8),
            
            settingTableView.heightAnchor.constraint(equalToConstant: heightForSettingTV),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            addNewIngrButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
        ])
    }
    
    private func setupPicker() {
        photoPikerView.delegate = self
        photoPikerView.sourceType = .photoLibrary
    }
    
    private func setupTextFields() {
        recipeNameTextField.delegate = self
    }
    
    private func setupTableViews() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(CreateIngredientsTableViewCell.self, forCellReuseIdentifier: "ingredients")
    }
    
    private func setupButton () {
        createButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        createButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
    }
    
    private func registerForKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyBoardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbWillShow(_ notification: Notification) {
        if recipeNameTextField.isEditing {
        } else {
            let userInfo = notification.userInfo
            let keyBoardFrameSize = ( userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            scrollView.contentOffset = CGPoint(x: 0, y: keyBoardFrameSize.height)
        }

    }
    
    @objc private func kbWillHide() {
        if recipeNameTextField.isEditing {
        } else {
            scrollView.contentOffset = CGPoint.zero
        }
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

extension CreateRecipeViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
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
