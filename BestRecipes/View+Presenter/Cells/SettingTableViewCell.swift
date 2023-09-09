import UIKit

class SettingTableViewCell: UITableViewCell {
    
    var cellData : CreateRecipeSettingDataModel? {
        didSet {
            self.iconImage.image = UIImage(named: cellData!.iconImageName)
            self.titleLabel.text = cellData?.titleText
        }
    }
    
    private let bubbleView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .neutral10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconBubleView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 36).isActive = true
        view.widthAnchor.constraint(equalToConstant: 36).isActive = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconImage : UIImageView = {
        let img = UIImageView()
        img.image = .profile
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBold16
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.text = "Serves"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var valueLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegularLabel
        lb.textColor = .neutral50
        lb.textAlignment = .left
        lb.text = "03"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var actionButton : UIButton = {
        let btn = UIButton()
        btn.setImage(.arrowRight, for: .normal)
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
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(iconBubleView)
        iconBubleView.addSubview(iconImage)
        bubbleView.addSubview(titleLabel)
        bubbleView.addSubview(valueLabel)
        bubbleView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            iconBubleView.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor),
            iconBubleView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 16),
            
            iconImage.centerXAnchor.constraint(equalTo: iconBubleView.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: iconBubleView.centerYAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconBubleView.trailingAnchor, constant: 16),
            
            valueLabel.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -12),
            
            actionButton.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func taped(_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }

}
