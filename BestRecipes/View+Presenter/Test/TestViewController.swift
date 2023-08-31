//
//  ViewController.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 27.08.2023.
//

import UIKit

protocol TestViewProtocol: AnyObject {
    func setImage(_ url: String)
}

class TestViewController: UIViewController {
    var image = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    var button = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 50))
    
    var presenter: TestViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primary20
        view.addSubview(image)
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitle("tap me", for: .normal)
        image.image = .add
        
        presenter = TestPresenter(view: self)
        presenter.showImage()
        
        
    }
    
    @objc func didTapButton() {
        presenter.showNewImage()
    }
    
}

extension TestViewController: TestViewProtocol {
    func setImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        // если картинка в кэше есть, то он их покажет
        if let data = presenter.getDataFromCache(from: url) {
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data)
            }
        }
        // если нет, то возьмет из интернета и сохранит в кэш
        ImageManager.shared.fetchImage(from: url) { data, response in
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data)
                self.presenter.saveDataToCache(with: data, and: response)
            }
        }
    }
}
