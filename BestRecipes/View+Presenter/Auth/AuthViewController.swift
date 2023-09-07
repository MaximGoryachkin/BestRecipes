import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Data
    
    var charIndex = 0
    let mainTitleText = "Best Recipes"

    
    // MARK: - UI Elements
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
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
    
    private lazy var backgroundImage : UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        img.image = UIImage(named: "homePage")
        img.clipsToBounds = true
        return img
    }()
    
    private var mainLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBoldHeading
        lb.textAlignment = .center
        lb.shadowColor = .green
        lb.textColor = .primary50
        lb.shadowOffset = CGSize(width: 3.0, height: 3.0)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold48
        lb.textAlignment = .center
        lb.textColor = .primary50
        lb.text = "Sign In"
        lb.shadowColor = .green
        lb.shadowOffset = CGSize(width: 2.0, height: 2.0)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    // Login Section ----------------------------------------------------------
    
    private let loginViewContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 45
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        view.heightAnchor.constraint(equalToConstant: 490).isActive = true
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginEmailField : UITextField = {
         let field = UITextField()
         field.heightAnchor.constraint(equalToConstant: 44).isActive = true
        field.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
         field.placeholder = "Email"
         field.font = .poppinsRegularLabel
         field.textColor = .neutral100
         field.layer.borderColor = UIColor.neutral20.cgColor
         field.layer.borderWidth = 1
         field.layer.cornerRadius = 12
         field.returnKeyType = .done
         field.translatesAutoresizingMaskIntoConstraints = false
         return field
     }()
    
    private let loginPasswordField : UITextField = {
        let field = UITextField()
        field.heightAnchor.constraint(equalToConstant: 44).isActive = true
       field.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        field.placeholder = "Password"
        field.font = .poppinsRegularLabel
        field.textColor = .neutral100
        field.layer.borderColor = UIColor.neutral20.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 12
        field.returnKeyType = .done
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var enterButton = CustomButton(style: .textPlusArrowGray, title: "LogIn")
    
    private lazy var actionsButtonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var recoverPasswordButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Forgot password?", for: .normal)
        btn.titleLabel?.font = .poppinsRegular16
        btn.setTitleColor(.neutral30, for: .normal)
        btn.addTarget(self, action: #selector(pasRecoverTaped(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var registrationButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Сreate an account", for: .normal)
        btn.titleLabel?.font = .poppinsRegular16
        btn.setTitleColor(.neutral30, for: .normal)
        btn.addTarget(self, action: #selector(registerTaped(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // Registration Section --------------------------------------------------
    
    private let registerUserNameField : UITextField = {
         let field = UITextField()
         field.heightAnchor.constraint(equalToConstant: 44).isActive = true
        field.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
         field.placeholder = "User Name"
         field.font = .poppinsRegularLabel
         field.textColor = .neutral100
         field.layer.borderColor = UIColor.neutral20.cgColor
         field.layer.borderWidth = 1
         field.layer.cornerRadius = 12
         field.returnKeyType = .done
         field.translatesAutoresizingMaskIntoConstraints = false
         return field
     }()
    
    private let registerEmailField : UITextField = {
         let field = UITextField()
         field.heightAnchor.constraint(equalToConstant: 44).isActive = true
        field.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
         field.placeholder = "Email"
         field.font = .poppinsRegularLabel
         field.textColor = .neutral100
         field.layer.borderColor = UIColor.neutral20.cgColor
         field.layer.borderWidth = 1
         field.layer.cornerRadius = 12
         field.returnKeyType = .done
         field.translatesAutoresizingMaskIntoConstraints = false
         return field
     }()
    
    private let registerPasswordField : UITextField = {
        let field = UITextField()
        field.heightAnchor.constraint(equalToConstant: 44).isActive = true
       field.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        field.placeholder = "Password"
        field.font = .poppinsRegularLabel
        field.textColor = .neutral100
        field.layer.borderColor = UIColor.neutral20.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 12
        field.returnKeyType = .done
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var avatarStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let userAvatarBuble : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = UIImage(systemName: "person.fill.questionmark")?.withTintColor(.neutral70)
        view.heightAnchor.constraint(equalToConstant: 66).isActive = true
        view.widthAnchor.constraint(equalToConstant: 77).isActive = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.neutral20.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadAvatarButton = CustomButton(style: .circleTextRed, title: "Choose avatar")
    
    private lazy var registerbutton = CustomButton(style: .textPlusArrowGray, title: "Register")
    
    private lazy var gotAccountButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Already got an account?", for: .normal)
        btn.titleLabel?.font = .poppinsRegular16
        btn.setTitleColor(.neutral30, for: .normal)
        btn.addTarget(self, action: #selector(gotAccountTaped(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - LifeCycle MEthods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        addSubviews()
        addLoginData()
        setupConstraints()
        setupButtons()
        setupLoginFields()
        addLoginData()
        registerForKeyBoardNotifications()
    }
    
    deinit {
        removeKeyBoardNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mainLabel.text = ""
        
        for letter in mainTitleText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * Double(charIndex), repeats: false) { timer in
                    self.mainLabel.text?.append(letter)
            }
        charIndex += 1
        }
    }
    

    // MARK: - Buttons Methods
    
    
    // Login View Buttons
    
    @objc private func enterTaped(_ sender: UIButton) {
        
    }
    
    @objc private func pasRecoverTaped(_ sender: UIButton) {
        
    }
    
    @objc private func registerTaped(_ sender: UIButton) {
        removeLoginData()
        addRegisterData()
    }
    
    
    // Registration section
    
    @objc private func loadAvatarTaped(_ sender: UIButton) {
        
    }
    
    @objc private func signUpTaped(_ sender: UIButton) {
        
    }
    
    @objc private func gotAccountTaped(_ sender: UIButton) {
        removeRegisterData()
        addLoginData()
    }
    
    
    
    // MARK: - Configure UI

    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(mainLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(loginViewContainer)
        loginViewContainer.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: loginViewContainer.topAnchor, constant: -35),
            loginViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            loginViewContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func addLoginData() {
        loginViewContainer.addSubview(loginEmailField)
        loginViewContainer.addSubview(loginPasswordField)
        loginViewContainer.addSubview(enterButton)
        loginViewContainer.addSubview(actionsButtonsStack)
        actionsButtonsStack.addArrangedSubview(recoverPasswordButton)
        actionsButtonsStack.addArrangedSubview(registrationButton)
        
        NSLayoutConstraint.activate([
            loginEmailField.topAnchor.constraint(equalTo: loginViewContainer.topAnchor, constant: 60),
            loginEmailField.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            loginPasswordField.topAnchor.constraint(equalTo: loginEmailField.bottomAnchor, constant: 40),
            loginPasswordField.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            enterButton.topAnchor.constraint(equalTo: loginPasswordField.bottomAnchor, constant: 40),
            enterButton.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            actionsButtonsStack.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 20),
            actionsButtonsStack.leadingAnchor.constraint(equalTo: loginViewContainer.leadingAnchor, constant: 20),
            actionsButtonsStack.trailingAnchor.constraint(equalTo: loginViewContainer.trailingAnchor, constant: -20),
        ])
    }
    
    private func removeLoginData() {
        loginEmailField.removeFromSuperview()
        loginPasswordField.removeFromSuperview()
        enterButton.removeFromSuperview()
        actionsButtonsStack.removeFromSuperview()
        actionsButtonsStack.removeFromSuperview()
        titleLabel.text = "Sign Up"
        
        NSLayoutConstraint.deactivate([
            loginEmailField.topAnchor.constraint(equalTo: loginViewContainer.topAnchor, constant: 60),
            loginEmailField.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            loginPasswordField.topAnchor.constraint(equalTo: loginEmailField.bottomAnchor, constant: 40),
            loginPasswordField.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            enterButton.topAnchor.constraint(equalTo: loginPasswordField.bottomAnchor, constant: 40),
            enterButton.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            actionsButtonsStack.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 20),
            actionsButtonsStack.leadingAnchor.constraint(equalTo: loginViewContainer.leadingAnchor, constant: 20),
            actionsButtonsStack.trailingAnchor.constraint(equalTo: loginViewContainer.trailingAnchor, constant: -20),
        ])
    }
    
    private func addRegisterData() {
        loginViewContainer.addSubview(registerUserNameField)
        loginViewContainer.addSubview(registerEmailField)
        loginViewContainer.addSubview(registerPasswordField)
        
        loginViewContainer.addSubview(avatarStack)
        avatarStack.addArrangedSubview(userAvatarBuble)
        avatarStack.addArrangedSubview(loadAvatarButton)
        loginViewContainer.addSubview(registerbutton)
        loginViewContainer.addSubview(gotAccountButton)
        
        NSLayoutConstraint.activate([
            registerUserNameField.topAnchor.constraint(equalTo: loginViewContainer.topAnchor, constant: 60),
            registerUserNameField.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            registerEmailField.topAnchor.constraint(equalTo: registerUserNameField.bottomAnchor, constant: 20),
            registerEmailField.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            registerPasswordField.topAnchor.constraint(equalTo: registerEmailField.bottomAnchor, constant: 20),
            registerPasswordField.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            avatarStack.topAnchor.constraint(equalTo: registerPasswordField.bottomAnchor, constant: 20),
            avatarStack.leadingAnchor.constraint(equalTo: loginViewContainer.leadingAnchor, constant: 30),
            avatarStack.trailingAnchor.constraint(equalTo: loginViewContainer.trailingAnchor, constant: -20),
            
            registerbutton.topAnchor.constraint(equalTo: avatarStack.bottomAnchor, constant: 20),
            registerbutton.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            gotAccountButton.topAnchor.constraint(equalTo: registerbutton.bottomAnchor, constant: 15),
            gotAccountButton.leadingAnchor.constraint(equalTo: loginViewContainer.leadingAnchor, constant: 20),
        ])
    }
    
    private func removeRegisterData() {
        registerUserNameField.removeFromSuperview()
        registerEmailField.removeFromSuperview()
        registerPasswordField.removeFromSuperview()
        avatarStack.removeFromSuperview()
        userAvatarBuble.removeFromSuperview()
        loadAvatarButton.removeFromSuperview()
        registerbutton.removeFromSuperview()
        gotAccountButton.removeFromSuperview()
        titleLabel.text = "Sign In"
        
        NSLayoutConstraint.deactivate([
            registerUserNameField.topAnchor.constraint(equalTo: loginViewContainer.topAnchor, constant: 60),
            registerUserNameField.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            registerEmailField.topAnchor.constraint(equalTo: registerUserNameField.bottomAnchor, constant: 20),
            registerEmailField.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            registerPasswordField.topAnchor.constraint(equalTo: registerEmailField.bottomAnchor, constant: 20),
            registerPasswordField.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            avatarStack.topAnchor.constraint(equalTo: registerPasswordField.bottomAnchor, constant: 20),
            avatarStack.leadingAnchor.constraint(equalTo: loginViewContainer.leadingAnchor, constant: 30),
            avatarStack.trailingAnchor.constraint(equalTo: loginViewContainer.trailingAnchor, constant: -20),
            
            registerbutton.topAnchor.constraint(equalTo: avatarStack.bottomAnchor, constant: 20),
            registerbutton.centerXAnchor.constraint(equalTo: loginViewContainer.centerXAnchor),
            
            gotAccountButton.topAnchor.constraint(equalTo: registerbutton.bottomAnchor, constant: 15),
            gotAccountButton.leadingAnchor.constraint(equalTo: loginViewContainer.leadingAnchor, constant: 20),
        ])
    }
    
    private func setupButtons() {
        enterButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        enterButton.addTarget(self, action: #selector(enterTaped(_:)), for: .touchUpInside)
        
        loadAvatarButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        loadAvatarButton.addTarget(self, action: #selector(loadAvatarTaped(_:)), for: .touchUpInside)
        
        registerbutton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        registerbutton.addTarget(self, action: #selector(signUpTaped(_:)), for: .touchUpInside)
    }
    
    private func setupLoginFields() {
        loginEmailField.delegate = self
        loginPasswordField.delegate = self
        loginEmailField.setLeftPaddingPoints(15)
        loginPasswordField.setLeftPaddingPoints(15)
        
        registerUserNameField.delegate = self
        registerEmailField.delegate = self
        registerPasswordField.delegate = self
        registerUserNameField.setLeftPaddingPoints(15)
        registerEmailField.setLeftPaddingPoints(15)
        registerPasswordField.setLeftPaddingPoints(15)
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
        if loginEmailField.isFirstResponder {
            scrollView.contentOffset = CGPoint(x: 0, y: -35)
        } else if loginPasswordField.isFirstResponder {
            scrollView.contentOffset = CGPoint(x: 0, y: 50)
        } else if registerUserNameField.isFirstResponder {
            scrollView.contentOffset = CGPoint(x: 0, y: -40)
        } else if registerEmailField.isFirstResponder {
            scrollView.contentOffset = CGPoint(x: 0, y: 30)
        } else if registerPasswordField.isFirstResponder {
            scrollView.contentOffset = CGPoint(x: 0, y: 90)
        }
    }
    
    @objc private func kbWillHide() {
            scrollView.contentOffset = CGPoint.zero
    }
    
}


// MARK: - UITextField Delegates

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        textField.endEditing(true)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if loginEmailField.text != "" && loginPasswordField.text != "" {
            self.enterButton.isEnabled = true
            self.enterButton.backgroundColor = .primary50
            self.enterButton.setTitleColor(.white, for: .normal)
        } else {
            self.enterButton.isEnabled = false
            self.enterButton.backgroundColor = .neutral20
            self.enterButton.setTitleColor(.neutral40, for: .normal)
        }
        
        if registerEmailField.text != "" && registerUserNameField.text != "" && registerPasswordField.text != "" {
            registerbutton.backgroundColor = .primary50
            registerbutton.isEnabled = true
            registerbutton.setTitleColor(.white, for: .normal)
        } else {
            registerbutton.backgroundColor = .neutral20
            registerbutton.isEnabled = false
            registerbutton.setTitleColor(.neutral40, for: .normal)
        }
        
        return true
    }
}
