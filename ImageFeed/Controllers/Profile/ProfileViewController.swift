//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Акимов on 23.11.2023.
//

import UIKit
import Kingfisher

public protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfileViewPresenterProtocol! { get set }
    func configureSubviews()
    func configureConstraints()
    func updateProfileDetails(_ profile: Profile)
    func updateAvatar()
    func configure(_ presenter: ProfileViewPresenterProtocol)
}

final class ProfileViewController: UIViewController & ProfileViewControllerProtocol {
    
    private let token = OAuth2TokenStorage.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    var presenter: ProfileViewPresenterProtocol!
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        let profileImage = UIImage(named: "mockPhotoProfile")
        imageView.image = profileImage
        imageView.backgroundColor = UIColor(named: "YP Black")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameLabel: UILabel = {
        let Colortext = UIColor(named: "YP White")
        let nameLabel = UILabel()
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = Colortext
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    let loginLabel: UILabel = {
        let color = UIColor(named: "YP Gray")
        let loginLabel = UILabel()
        loginLabel.text = "@ekaterina_nov"
        loginLabel.textColor = color
        loginLabel.font = UIFont.systemFont(ofSize: 13)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        return loginLabel
    }()
    let aboutLabel: UILabel = {
        let Colortext = UIColor(named: "YP White")
        let aboutLabel = UILabel()
        aboutLabel.text = "Hello world"
        aboutLabel.textColor = Colortext
        aboutLabel.font = UIFont.systemFont(ofSize: 13)
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        return aboutLabel
    }()
    let button: UIButton = {
        let button = UIButton()
        let imageButton = UIImage(named: "Exit")
        button.setImage(imageButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    let Colortext = UIColor(named: "YP White")
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.profileImage,
            let url = URL(string: profileImageURL)
        else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 30)
        imageView.kf.setImage(with: url, options: [
            .processor(processor),
            .cacheSerializer(FormatIndicatedCacheSerializer.png)
        ])
        imageView.clipsToBounds = true
        
    }
    
    func configureSubviews(){
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(loginLabel)
        view.addSubview(aboutLabel)
        view.addSubview(button)
        view.backgroundColor = UIColor(named: "YP Black")
    }
    
    func configureConstraints(){
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            loginLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            aboutLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            aboutLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8),
        ])
    }
    
    func updateProfileDetails(_ profile: Profile){
        nameLabel.text = profile.name
        loginLabel.text = profile.loginName
        aboutLabel.text = profile.bio
    }
    
    func configure(_ presenter: ProfileViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
    
}

extension ProfileViewController {
    @objc func buttonTapped() {
        let alert = presenter?.logoutButtonTapped()
        guard let alert = alert else { return }
        self.present(alert, animated: true)
    }
    
}

