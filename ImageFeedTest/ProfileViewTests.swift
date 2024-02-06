//
//  ProfileViewTests.swift
//  ImageFeedTest
//
//  Created by Александр Акимов on 31.01.2024.
//

@testable import ImageFeed
import XCTest

final class ProfileViewTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.configure(presenter)
        
        viewController.viewDidLoad()
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testPresenterCalls() {
        let presenter = ProfilePresenter()
        let viewController = ProfileViewControllerSpy()
        viewController.configure(presenter)
        presenter.view = viewController
        let profileResult = ProfileResult(username: "NRNR", firstName: "rffe", lastName: "ref", bio: "efef")
        presenter.profile = Profile(profileResult: profileResult)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(viewController.configureSubviewsCalled)
        XCTAssertTrue(viewController.configureConstraintsCalled)
        XCTAssertTrue(viewController.updateProfileDetailsCalled)
    }
}

