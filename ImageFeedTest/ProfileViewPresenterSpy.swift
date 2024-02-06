//
//  ProfileViewPresenterSpy.swift
//  ImageFeedTest
//
//  Created by Александр Акимов on 31.01.2024.
//

import ImageFeed
import UIKit

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var view: ProfileViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func logoutButtonTapped() -> UIAlertController {
        let alert = UIAlertController()
        return alert
    }
}
