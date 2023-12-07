//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Акимов on 23.11.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let loginLabel = UILabel()
    let aboutLabel = UILabel()
    let Colortext = UIColor(named: "YP White")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageConfigure()
        buttonExitConfigure()
        nameLabelConfigure()
        loginLabelConfigure()
        aboutLabelConfigure()
    }
    
    
    func profileImageConfigure (){
        let profileImage = UIImage(named: "mockPhotoProfile")
        imageView.image = profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func buttonExitConfigure(){
        let button = UIButton()
        let imageButton = UIImage(named: "Exit")
        button.setImage(imageButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
    
    func nameLabelConfigure(){
        let Colortext = UIColor(named: "YP White")
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = Colortext
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        
    }
    
    func loginLabelConfigure(){
        let color = UIColor(named: "YP Gray")
        loginLabel.text = "@ekaterina_nov"
        loginLabel.textColor = color
        loginLabel.font = UIFont.systemFont(ofSize: 13)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        loginLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        
    }
    
    func aboutLabelConfigure(){
        
        aboutLabel.text = "Hello world"
        aboutLabel.textColor = Colortext
        aboutLabel.font = UIFont.systemFont(ofSize: 13)
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutLabel)
        aboutLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        aboutLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8).isActive = true
        
    }
}
