//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Александр Акимов on 23.12.2023.
//

import UIKit
import ProgressHUD
import SwiftKeychainWrapper

final class SplashViewController: UIViewController {
    static var codeError: Error?
    
    private let ShowAuthScreenSegueIdentifier = "showAuthView"
    private let profileService = ProfileService()
    private let oauth2Service = OAuth2Service()
    private let oauth2TokenStorage = OAuth2TokenStorage()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        let profileImage = UIImage(named: "vector_logo")
        imageView.image = profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let token = oauth2TokenStorage.token {
            fetchProfile(token: token)
            switchToTabBarController()
        } else {
            showAuthenticationScreen()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

extension SplashViewController {
    private func showAuthenticationScreen() {
        guard let authViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController else {
            print("wvrw")
            return
            
        }
            authViewController.delegate = self
            authViewController.modalPresentationStyle = .fullScreen
            present(authViewController, animated: true, completion: nil)
    }
}

// MARK: - AuthViewControllerDelegate

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        UIBlockingProgressHUD.show()
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            self.fetchOAuthToken(code)
        }
    }
    
    private func fetchOAuthToken(_ code: String) {
        let oauth2Service = OAuth2Service()
        let token = OAuth2TokenStorage()
        oauth2Service.fetchAuthToken(code: code) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let bearerToken):
                token.token = bearerToken
                self.fetchProfile(token: bearerToken)
            case .failure(let error):
                SplashViewController.codeError = error
                print("Error fetching Bearer Token: \(error)")
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    private func fetchProfile(token: String){
        profileService.fetchProfile(token) {[weak self] result in
            switch result {
            case .success(let profileResults):
                ProfileImageService.shared.fetchProfileImageURL(username: profileResults.username) { _ in }
                UIBlockingProgressHUD.dismiss()
                self?.switchToTabBarController()
            case .failure(let error):
                SplashViewController.codeError = error
                print("Error fetching Profile: \(error)")
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
}

extension SplashViewController {
    private func configureSubviews(){
        view.addSubview(imageView)
        view.backgroundColor = UIColor(named: "YP Black")
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}



