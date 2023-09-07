import UIKit.UIViewController

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupNavBar(on vc: UIViewController) {
        let backButton : UIButton = {
            let btn = UIButton()
            btn.setImage(UIImage(named: "Icons/Arrow-Left"), for: .normal)
            btn.addTarget(self, action: #selector(barbackTaped), for: .touchUpInside)
            return btn
        }()
        
        let threeDotsButton : UIButton = {
            let btn = UIButton()
            btn.setImage(UIImage(named: "Icons/More"), for: .normal)
            btn.addTarget(self, action: #selector(barMoreTaped), for: .touchUpInside)
            return btn
        }()
        
        vc.navigationItem.setHidesBackButton(true, animated: true)
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: threeDotsButton)
    }
    
    @objc func barbackTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func barMoreTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
}
