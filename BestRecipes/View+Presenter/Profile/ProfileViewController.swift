//
//  ProfileViewController.swift
//  BestRecipes
//
//  Created by Ilyas Tyumenev on 05.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let imagePicker = UIImagePickerController()
    
    private let myProfileView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let myProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "My profile"
        label.textColor = .neutral100
        label.font = .poppinsBold24
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Icons/More"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let myRecipesView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Avatar")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let myRecipesLabel: UILabel = {
        let label = UILabel()
        label.text = "My recipes"
        label.textColor = .neutral100
        label.font = .poppinsBold24
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 34, height: 212)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setupCollection()
        imagePicker.delegate = self
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        myProfileView.addSubview(myProfileLabel)
        myProfileView.addSubview(moreButton)
        view.addSubview(myProfileView)
        myRecipesView.addSubview(profileImage)
        myRecipesView.addSubview(profileButton)
        myRecipesView.addSubview(myRecipesLabel)
        view.addSubview(myRecipesView)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myProfileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myProfileView.heightAnchor.constraint(equalToConstant: 69),
            
            myProfileLabel.topAnchor.constraint(equalTo: myProfileView.topAnchor, constant: 20),
            myProfileLabel.leadingAnchor.constraint(equalTo: myProfileView.leadingAnchor, constant: 21),
            myProfileLabel.heightAnchor.constraint(equalToConstant: 29),
            myProfileLabel.widthAnchor.constraint(equalToConstant: 122),

            moreButton.centerYAnchor.constraint(equalTo: myProfileLabel.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: myProfileView.trailingAnchor, constant: -20),
            moreButton.heightAnchor.constraint(equalToConstant: 24),
            moreButton.widthAnchor.constraint(equalToConstant: 24),

            myRecipesView.topAnchor.constraint(equalTo: myProfileView.bottomAnchor),
            myRecipesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myRecipesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myRecipesView.heightAnchor.constraint(equalToConstant: 229),

            profileImage.topAnchor.constraint(equalTo: myRecipesView.topAnchor, constant: 12),
            profileImage.leadingAnchor.constraint(equalTo: myRecipesView.leadingAnchor, constant: 20.5),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
            profileButton.topAnchor.constraint(equalTo: myRecipesView.topAnchor, constant: 12),
            profileButton.leadingAnchor.constraint(equalTo: myRecipesView.leadingAnchor, constant: 20.5),
            profileButton.heightAnchor.constraint(equalToConstant: 100),
            profileButton.widthAnchor.constraint(equalToConstant: 100),

            myRecipesLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 69),
            myRecipesLabel.leadingAnchor.constraint(equalTo: myRecipesView.leadingAnchor, constant: 36),
            myRecipesLabel.heightAnchor.constraint(equalToConstant: 29),
            
            collectionView.topAnchor.constraint(equalTo: myRecipesView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingNowCell.self, forCellWithReuseIdentifier: "cell")
    }
}


// MARK: - CollectionView Delegate & DataSource

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrendingNowCell
        return cell
    }
}


// MARK: - Target actiona
extension ProfileViewController {
    
    @objc func moreButtonPressed(_ button: UIButton) {
        print("More button pressed")
    }
    
    @objc func profileButtonPressed(_ button: UIButton) {
        print("Profile button pressed")
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: -  UIImagePickerControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
