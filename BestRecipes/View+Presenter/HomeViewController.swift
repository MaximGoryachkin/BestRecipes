import UIKit

class HomeViewController: UIViewController {
    // MARK: - Data
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 400)
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
        lb.text = "Get amazing recipes for cooking"
        return lb
    }()
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()

    }
    
    // MARK: - ConfigureUI

    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupConstraints() {
        
    }
    
    
    
}


// MARK: - TableView Delegate & DataSource
