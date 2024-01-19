//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Александр Акимов on 17.01.2024.
//

import UIKit

final class AlertPresenter {
    static func presentAlert(with model: AlertModel, from viewController: UIViewController) {
        let alertController = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in }
        
        alertController.view.accessibilityIdentifier = "Alert"
        
        alertController.addAction(action)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}

