//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Акимов on 23.11.2023.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    private var profileImageServiceObserver: NSObjectProtocol?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        let profileImage = UIImage(named: "mockPhotoProfile")
        imageView.image = profileImage
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
        return button
    }()
    let Colortext = UIColor(named: "YP White")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
        if let profile = ProfileService.profile {
            updateProfileDetails(profile)
        }
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.updateAvatar()
            }
        updateAvatar()
    }
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.profileImage,
            let url = URL(string: profileImageURL)
        else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.setImage(with: url, options: [.processor(processor)]) {result in
            switch result {
            case .success(let value):
                self.imageView.image = value.image
                
            case .failure(_):
                print("failure")
            }
        }
    }
    
    private func configureSubviews(){
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(loginLabel)
        view.addSubview(aboutLabel)
        view.addSubview(button)
        view.backgroundColor = UIColor(named: "YP Black")
    }
    
    private func configureConstraints(){
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
    
    private func updateProfileDetails(_ profile: Profile){
        nameLabel.text = profile.name
        loginLabel.text = profile.loginName
        aboutLabel.text = profile.bio
    }
    
}
