//
//  ProfileViewPresenter.swift
//  ImageFeed
//
//  Created by Александр Акимов on 31.01.2024.
//

import UIKit

public protocol ProfileViewPresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func viewDidLoad()
    func logoutButtonTapped() -> UIAlertController
}

final class ProfilePresenter: ProfileViewPresenterProtocol {
    weak var view: ProfileViewControllerProtocol?
    private let token = OAuth2TokenStorage.shared
    var profile: Profile? = ProfileService.profile
    func viewDidLoad() {
        guard let profile = profile else { return }
        view?.configureSubviews()
        view?.configureConstraints()
        view?.updateProfileDetails(profile)
        
        NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.view?.updateAvatar()
        }
    }
    
    func logoutButtonTapped() -> UIAlertController {
        let alert = UIAlertController(title: "Пока, пока!", message: "Уверены, что хотите выйти?", preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            self?.token.clean()
            guard let window = UIApplication.shared.windows.first else { return }
            window.rootViewController = SplashViewController()
            window.makeKeyAndVisible()
        }
        
        let deleteAction = UIAlertAction(title: "Нет", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(deleteAction)
        return alert
    }
    
    
}
