//
//  TabBarController.swift.swift
//  ImageFeed
//
//  Created by Александр Акимов on 18.01.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    var identifier: String?
    var profilePresenter: ProfileViewPresenterProtocol!
    var imagesListPresenter: ImageListPresenterProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePresenter = ProfilePresenter()
        imagesListPresenter = ImagesListPresenter()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil
        )
        profileViewController.configure(profilePresenter)
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}
