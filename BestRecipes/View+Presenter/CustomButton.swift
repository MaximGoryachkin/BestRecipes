import UIKit

final class CustomButton : UIButton {
    
    enum Buttonstyle {
        case arrowRed
        case arrowDarkRed
        case arrowGray
        
        case textPlusArrowRed
        case textPlusArrowDarkRed
        case textPlusArrowGray
        
        case squareTextRed
        case squareTextDarkRed
        case squareTextGray
        
        case circleTextRed
        case skip
    }
    
    private let style : Buttonstyle?
    private let title : String?
    
    init(style: Buttonstyle?, title: String?) {
        self.style = style
        self.title = title
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(didTaped(_:)), for: .touchUpInside)
        tintColor = .black
        let grayimage = UIImage.arrowRight?.withTintColor(.neutral40)
        
        if style == .arrowRed || style == .arrowDarkRed || style == .arrowGray {
            heightAnchor.constraint(equalToConstant: 56).isActive = true
            widthAnchor.constraint(equalToConstant: 56).isActive = true
            setImage(UIImage.arrowRight, for: .normal)
            layer.cornerRadius = 8
            if style == .arrowRed {
                backgroundColor = .primary50
            } else if style == .arrowDarkRed {
                backgroundColor = .primary80
            } else {
                backgroundColor = .neutral20
                setImage(grayimage, for: .normal)
                isEnabled = false
            }
        } else if style == .textPlusArrowRed || style == .textPlusArrowDarkRed || style == .textPlusArrowGray {
            heightAnchor.constraint(equalToConstant: 56).isActive = true
            layer.cornerRadius = 8
            setTitle(title, for: .normal)
            setTitleColor(.white, for: .normal)
            setImage(UIImage.arrowRight, for: .normal)
            semanticContentAttribute = .forceRightToLeft
            titleLabel?.font = .poppinsBold24
            if style == .textPlusArrowRed {
                backgroundColor = .primary50
            } else if style == .textPlusArrowDarkRed {
                backgroundColor = .primary80
            } else {
                backgroundColor = .neutral20
                setTitleColor(.neutral40, for: .normal)
                setTitleColor(.neutral40, for: .normal)
                setImage(grayimage, for: .normal)
                isEnabled = false
            }
        } else if style == .squareTextRed || style == .squareTextDarkRed || style == .squareTextGray {
            heightAnchor.constraint(equalToConstant: 56).isActive = true
            layer.cornerRadius = 8
            setTitle(title, for: .normal)
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .poppinsBold24
            if style == .squareTextRed {
                backgroundColor = .primary50
            } else if style == .squareTextDarkRed {
                backgroundColor = .primary80
            } else {
                backgroundColor = .neutral20
                setTitleColor(.neutral40, for: .normal)
                isEnabled = false
            }
        } else if style == .circleTextRed {
            heightAnchor.constraint(equalToConstant: 44).isActive = true
            layer.cornerRadius = 22
            setTitle(title, for: .normal)
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .poppinsBold24
            backgroundColor = .primary50
        } else {
            setTitle(title, for: .normal)
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .poppinsBold16
        }
    }
    
    @objc private func didTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
}
