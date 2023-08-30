//
//  ViewController.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 27.08.2023.
//

import UIKit

protocol TestViewProtocol: AnyObject {
    func setLabel(_ text: String)
}

class TestViewController: UIViewController {
    var label = UILabel(frame: CGRect(x: 100, y: 100, width: 300, height: 100))
    var button = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
    
    var presenter: TestViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primary20
        view.addSubview(label)
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitle("tap me", for: .normal)
        label.text = ""
        label.font = .systemFont(ofSize: 20)
        
        Task {
            do {
                if let recipes = try await NetworkManager.shared.fetchArrayData(from: DataManager.shared.randomRecipe) {
                    presenter = TestPresenter(view: self, recipe: recipes.recipes[0])
                    presenter.showTitle()
                }
            } catch {
                print(error)
            }
        }
        
    }
    
    @objc func didTapButton() {
        presenter.showNewTitle()
    }
    
}

extension TestViewController: TestViewProtocol {
    func setLabel(_ text: String) {
        DispatchQueue.main.async {
            self.label.text = text
        }
    }
}
