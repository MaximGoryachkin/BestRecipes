import UIKit

class LaunchViewController: UIViewController {
    
    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.text = "Best Recipes"
        element.font = .systemFont(ofSize: 40)
        element.textColor = .black
        element.textAlignment = .center
        element.shadowColor = .quaternaryLabel
        element.shadowOffset.width = 1
        element.shadowOffset.height = -1
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var logoImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "logo")
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let element = UIActivityIndicatorView()
        element.style = .large
        element.color = .black
        element.startAnimating()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingDone()
    }

}

extension LaunchViewController {
    private func setViews() {
        view.backgroundColor = .systemYellow
        view.addSubview(nameLabel)
        view.addSubview(logoImageView)
        view.addSubview(indicator)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -20),
            
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func loadingDone() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vcToPresent = OnboardingHomeViewController()
            vcToPresent.modalPresentationStyle = .fullScreen
            self.present(vcToPresent, animated: true)
        }
    }
}
