//
//  ProfileViewControllerSpy.swift
//  ImageFeedTest
//
//  Created by Александр Акимов on 01.02.2024.
//

import ImageFeed
import Foundation

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ImageFeed.ProfileViewPresenterProtocol!
    
    
    var configureSubviewsCalled: Bool = false
    var configureConstraintsCalled: Bool = false
    var updateProfileDetailsCalled: Bool = false
    
    func configureSubviews() {
        configureSubviewsCalled = true
    }
    
    func configureConstraints() {
        configureConstraintsCalled = true
    }
    
    func updateProfileDetails(_ profile: ImageFeed.Profile) {
        updateProfileDetailsCalled = true
    }
    
    func updateAvatar() {
       
    }
    
    func configure(_ presenter: ProfileViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
    
}
