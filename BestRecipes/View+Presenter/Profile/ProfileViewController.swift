//
//  ProfileViewController.swift
//  BestRecipes
//
//  Created by Ilyas Tyumenev on 05.09.2023.
//


/*
 Получение данных пользователя
 UserDefaults.standart
 ключи и типы данных
 
 "userName" - String
 "userPassword" - String
 "userEmail" - String
 "avatarLocalPath" - String
 */
 


import UIKit

class ProfileViewController: UIViewController {
    
    let dataFilePathForRecipes = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(UserDefaults.standard.string(forKey: "userName")!).plist")
    
    var recipesArray : [CustomRecipes] = []
    
    private func loadUserRecipes() {
        if  let data = try? Data(contentsOf: dataFilePathForRecipes!) {
             let decoder = PropertyListDecoder()
            do {
                self.recipesArray = try decoder.decode([CustomRecipes].self, from: data)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Data
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Users.plist")
    
    var usersArray = [UsersDataModel]()
        
    // MARK: - UI
    
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
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var userNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBoldLabel
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var userEmailLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsBoldLabel
        lb.textColor = .neutral100
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
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
        loadExistingUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        safeLoadANdUpdateAvatar()
        loadUserRecipes()
        self.collectionView.reloadData()
        self.userNameLabel.text = "UserName: \(UserDefaults.standard.string(forKey: "userName")!)"
        self.userEmailLabel.text = "Email: \(UserDefaults.standard.string(forKey: "userEmail")!)"
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
        view.addSubview(userNameLabel)
        view.addSubview(userEmailLabel)
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
            
            userNameLabel.topAnchor.constraint(equalTo: myRecipesView.topAnchor, constant: 35),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 25),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            userEmailLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 25),
            userEmailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            myRecipesLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 69),
            myRecipesLabel.leadingAnchor.constraint(equalTo: myRecipesView.leadingAnchor, constant: 36),
            myRecipesLabel.heightAnchor.constraint(equalToConstant: 29),
            
            collectionView.topAnchor.constraint(equalTo: myRecipesView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyRecipesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}


// MARK: - CollectionView Delegate & DataSource

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyRecipesCollectionViewCell
        
        let currentCell = recipesArray[indexPath.row]
        
        cell.cellData = currentCell
        cell.loadRecipeImage(fileName: currentCell.recipeImageLocalPath)
        return cell
    }
}


// MARK: - Target actiona
extension ProfileViewController {
    
    @objc func moreButtonPressed(_ button: UIButton) {
        let rootVC = AuthViewController()
        rootVC.modalPresentationStyle = .fullScreen
        self.present(rootVC, animated: true)
    }
    
    @objc func profileButtonPressed(_ button: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: -  UIImagePickerControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        
        updateUserAvatar(avatarString: saveNewUserAvatar(image: image)!)
        
        profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

extension ProfileViewController {
    
    private func loadExistingUsers() {
        if  let data = try? Data(contentsOf: dataFilePath!) {
             let decoder = PropertyListDecoder()
            do {
                self.usersArray = try decoder.decode([UsersDataModel].self, from: data)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadUserAvatarImage(fileName: String) -> UIImage? {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
    private func saveNewUserAvatar (image: UIImage) -> String? {
        let fileName = "FileName"
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
           try? imageData.write(to: fileURL, options: .atomic)
           return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }
    
    private func updateUserAvatar(avatarString: String) {
        
        let currentUserEmail = UserDefaults.standard.string(forKey: "userEmail")
        let currentUserName = UserDefaults.standard.string(forKey: "userName")
        let currentUserPass = UserDefaults.standard.string(forKey: "userPassword")
                
        var usersWithoutCurrent = usersArray.filter {$0.email != currentUserEmail!}
        
        let userWithChangedAvatar = UsersDataModel(userName: currentUserName!, email: currentUserEmail!, password: currentUserPass!,userAvatarLocalPath: avatarString)
        
        usersWithoutCurrent.append(userWithChangedAvatar)
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(usersWithoutCurrent)
            try data.write(to: dataFilePath!)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private func safeLoadANdUpdateAvatar() {
        let imageName = UserDefaults.standard.string(forKey: "avatarLocalPath")
        if imageName! != "" {
            self.profileImage.image = loadUserAvatarImage(fileName: imageName!)
        } else {
            self.profileImage.image = UIImage(named: "Avatar")
        }
    }
}
