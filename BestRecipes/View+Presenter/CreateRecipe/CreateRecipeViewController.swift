import UIKit

struct CustomRecipes : Codable {
    let userName : String
    let recipeImageLocalPath : String
    let recipeTitle : String
    var ingredients : [CustomIngredients]?
    let cookDuration : Int
}

struct CustomIngredients : Codable {
    let ingredientName :  String
    let ingredientQuantity : String
}

class CreateRecipeViewController: UIViewController {
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var recipeImageLocalPath : String = ""
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(UserDefaults.standard.string(forKey: "userName")!).plist")
    var customRecipes : [CustomRecipes] = []
    
    private func createUserRecipes() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(customRecipes)
            try data.write(to: dataFilePath!)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    let curentUserName = UserDefaults.standard.string(forKey: "userName")!
    let currentUserAvatarPath = UserDefaults.standard.string(forKey: "avatarLocalPath")!
    
    private func loadUserRecipes() {
        if  let data = try? Data(contentsOf: dataFilePath!) {
             let decoder = PropertyListDecoder()
            do {
                self.customRecipes = try decoder.decode([CustomRecipes].self, from: data)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
        
    // MARK: - Data
    
    private var countOfSettingsCells : Int = 2
    
    private var heightForSettingTV : CGFloat {
        let result = 72 * countOfSettingsCells
        return CGFloat(result)
    }
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 100)
    }
    
    // Collections Data
    var ingredientsArray : [(name: String, quantity: String)] = [
        (name: "Item name", quantity: "Quantity" )
    ]
    
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
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recipeImage : UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = UIImage(systemName: "folder.badge.questionmark")
        img.layer.cornerRadius = 12
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var editButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 16
        btn.setImage(.edit, for: .normal)
        btn.addTarget(self, action: #selector(additTaped(_ :)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let photoPickerView : UIImagePickerController = {
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        return piker
    }()
    
    private let recipeNameTextField : UITextField = {
        let field = UITextField()
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
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    private let ingredientsTitleLabel : UILabel = {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserRecipes()
    }
    
    // MARK: - Buttons Methods
    
    @objc private func additTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.present(self.photoPickerView, animated: true)
        }
    }
    
    @objc private func addIngredientTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.ingredientsArray.append((name: "Item name", quantity: "Quantity" ))
            let indexPath = NSIndexPath(row: self.ingredientsArray.count - 1, section: 0)
            self.ingredientsTableView.reloadData()
            self.ingredientsTableView.scrollToRow(at: indexPath as IndexPath, at: .middle, animated: true)
        }
    }
    
    @objc private func createTapped() {
        if checkForEmptyValues() {
            let alert = UIAlertController(title: "Create Own Recipe", message: "Your recipe succsesfuly addit!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Close", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
            
            var ingredients : [CustomIngredients] = []
            
            for ingredient in ingredientsArray {
                ingredients.append(CustomIngredients(ingredientName: ingredient.name, ingredientQuantity: ingredient.quantity))
            }
            
            customRecipes.append(CustomRecipes(userName: curentUserName,
                                               recipeImageLocalPath: recipeImageLocalPath,
                                               recipeTitle: recipeNameTextField.text!,
                                               ingredients:ingredients,
                                               cookDuration: 25))
            createUserRecipes()
            
        } else {
            let alert = UIAlertController(title: "Create Own Recipe", message: "Creating Recipe Failed! To create and save Your recipe, all fields should be filled, also recipe image must be selected!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Try aghain", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(imageBubleView)
        imageBubleView.addSubview(recipeImage)
        imageBubleView.addSubview(editButton)
        contentStackView.addArrangedSubview(recipeNameTextField)
        contentStackView.addArrangedSubview(settingTableView)
        contentStackView.addArrangedSubview(ingredientsTitleLabel)
        contentStackView.addArrangedSubview(ingredientsTableView)
        contentStackView.addArrangedSubview(addNewIngrButton)
        contentStackView.addArrangedSubview(createButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 52),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            titleLabel.heightAnchor.constraint(equalToConstant: 29),
            
            imageBubleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageBubleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageBubleView.heightAnchor.constraint(equalToConstant: 200),
            
            recipeImage.topAnchor.constraint(equalTo: imageBubleView.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: imageBubleView.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: imageBubleView.trailingAnchor),
            recipeImage.bottomAnchor.constraint(equalTo: imageBubleView.bottomAnchor),
            
            editButton.topAnchor.constraint(equalTo: imageBubleView.topAnchor, constant: 8),
            editButton.trailingAnchor.constraint(equalTo: imageBubleView.trailingAnchor, constant: -8),
            editButton.heightAnchor.constraint(equalToConstant: 32),
            editButton.widthAnchor.constraint(equalToConstant: 32),
            
            recipeNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            recipeNameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            settingTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            settingTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            settingTableView.heightAnchor.constraint(equalToConstant: heightForSettingTV),
            
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            ingredientsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            ingredientsTitleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            ingredientsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ingredientsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ingredientsTableView.heightAnchor.constraint(equalToConstant: 165),
            
            addNewIngrButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addNewIngrButton.heightAnchor.constraint(equalToConstant: 24),
            
            createButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            createButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            createButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -13)
        ])
    }
    
    private func setupPicker() {
        photoPickerView.delegate = self
        photoPickerView.sourceType = .photoLibrary
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
        self.recipeImageLocalPath = save(image: choosenImage)!
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
            return CreateRecipeSettingDataModel.prebuildData.count
        } else {
            return ingredientsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == settingTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell",for: indexPath) as! SettingTableViewCell
            let currentCell = CreateRecipeSettingDataModel.prebuildData[indexPath.row]
            cell.cellData = currentCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredients", for: indexPath) as! CreateIngredientsTableViewCell
            cell.ingredientName.delegate = self
            cell.weightName.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Recipe Creating Logic

extension CreateRecipeViewController {
    
    private func checkForEmptyValues() -> Bool {
        
        if self.recipeImage.image != UIImage(systemName: "folder.badge.questionmark"), self.recipeNameTextField.text != "" {
            return true
        } else {
            return false
        }
    }
}

extension CreateRecipeViewController {
    
    private func save(image: UIImage) -> String? {
        let fileName = "FileName"
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
           try? imageData.write(to: fileURL, options: .atomic)
           return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }
}
