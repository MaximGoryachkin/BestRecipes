import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var backgroundImage : UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        img.image = UIImage(named: "homePage")
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold48
        lb.textAlignment = .center
        lb.textColor = .primary80
        lb.text = "Sign In"
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
    
    private lazy var registerbutton = CustomButton(style: .textPlusArrowRed, title: "Register")
    
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
        view.addSubview(loginViewContainer)
        view.addSubview(titleLabel)
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: loginViewContainer.topAnchor, constant: 30),
            
            loginViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
    
}


// MARK: - UITextField Delegates

extension AuthViewController: UITextFieldDelegate {
    
}
