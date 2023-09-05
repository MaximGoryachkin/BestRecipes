import UIKit

class SearchResultsAlert {
    
    struct Constants {
        static let backgroundAlphaTo : CGFloat = 0.6
    }
    
    private let backgroundView : UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .neutral100
        bgView.alpha = 0
        return bgView
    }()
    
    private let alertView : UIView = {
        let alert = UIView()
        alert.backgroundColor = .neutral0
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        
        return alert
    }()
    
    private var myTargetView : UIView?
    
    func showAlert(searchRequestText: String, on viewController: UIViewController) {
        
        guard let targertView = viewController.view else {return}
        
        myTargetView = targertView
        
        let titleLabel : UILabel = {
            let lb = UILabel()
            lb.font = .poppinsBold16
            lb.textColor = .neutral100
            lb.textAlignment = .center
            lb.numberOfLines = 0
            lb.text = "Here's what we find on search request: '\(searchRequestText).'"
            lb.translatesAutoresizingMaskIntoConstraints = false
            return lb
        }()
        
        let cancelButton : UIButton = {
            let btn = UIButton()
            btn.setImage(UIImage(systemName: "xmark"), for: .normal)
            btn.tintColor = .red
            btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
            btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
            btn.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        let titleStack : UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .top
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        let resultsTableView : UITableView = {
            let tb = UITableView()
            tb.separatorStyle = .none
            tb.backgroundColor = .clear
            tb.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: "SerchResultsCell")
            tb.translatesAutoresizingMaskIntoConstraints = false
            tb.delegate = viewController as? any UITableViewDelegate
            tb.dataSource = viewController as? any UITableViewDataSource
            return tb
        }()
        
        backgroundView.frame = targertView.bounds
        targertView.addSubview(backgroundView)
        targertView.addSubview(alertView)
        alertView.addSubview(titleStack)
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(cancelButton)
        alertView.frame = CGRect(x: 40, y: -(targertView.frame.size.height / 2), width: targertView.frame.size.width - 80, height: targertView.frame.size.height / 2)
        alertView.addSubview(resultsTableView)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.alertView.center = targertView.center
                })
            }
        })
        
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: alertView.topAnchor,constant: 10),
            titleStack.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            titleStack.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            
            resultsTableView.topAnchor.constraint(equalTo: titleStack.bottomAnchor, constant: 10),
            resultsTableView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor)
        ])
    }
    
    @objc func dismissAlert() {
        
        guard let targertView = myTargetView else {return}
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.frame = CGRect(x: 40, y: targertView.frame.size.height, width: targertView.frame.size.width - 80, height: targertView.frame.size.height / 2)
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                })
            }
        })
    }
}
