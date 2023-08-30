import UIKit

class CreateIngredientsTableViewCell: UITableViewCell {
    
    private var isEddit : Bool = false
    
    private lazy var contentStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let ingredientName : UITextField = {
        let field = UITextField()
        field.heightAnchor.constraint(equalToConstant: 44).isActive = true
        field.widthAnchor.constraint(equalToConstant: 164).isActive = true
        field.placeholder = "Item name"
        field.font = .poppinsRegularLabel
        field.textColor = .neutral100
        field.layer.borderColor = UIColor.neutral20.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 12
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let weightName : UITextField = {
        let field = UITextField()
        field.heightAnchor.constraint(equalToConstant: 44).isActive = true
        field.widthAnchor.constraint(equalToConstant: 115).isActive = true
        field.placeholder = "Quantity"
        field.font = .poppinsRegularLabel
        field.textColor = .neutral100
        field.layer.borderColor = UIColor.neutral20.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 12
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var actionButton : UIButton = {
        let btn = UIButton()
        btn.setImage(.plusBorder, for: .normal)
        btn.addTarget(self, action: #selector(taped(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(ingredientName)
        contentStackView.addArrangedSubview(weightName)
        contentStackView.addArrangedSubview(actionButton)
        ingredientName.setLeftPaddingPoints(15)
        weightName.setLeftPaddingPoints(15)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    @objc private func taped(_ sender: UIButton) {
        isEddit = !isEddit
        
        isEddit == true ? sender.setImage(.minusBorder, for: .normal) : sender.setImage(.plusBorder, for: .normal)
    }

}
