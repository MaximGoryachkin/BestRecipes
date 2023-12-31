import UIKit

class InstructionTableViewCell: UITableViewCell {

    private lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .top
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var countLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular16
        lb.textColor = .neutral100
        lb.textAlignment = .center
        lb.widthAnchor.constraint(equalToConstant: 25).isActive = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
     lazy var discriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular16
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCell() {
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(contentStack)
        contentStack.addArrangedSubview(countLabel)
        contentStack.addArrangedSubview(discriptionLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            contentStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 5),
            contentStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func redText() {
        self.countLabel.removeFromSuperview()
        self.discriptionLabel.textColor = .error100
    }
}
