//
//  ImagesListControllerSpy.swift
//  ImageFeedTest
//
//  Created by Александр Акимов on 05.02.2024.
//

import ImageFeed
import UIKit

final class ImagesListControllerSpy: ImagesListControllerProtocol {
    var presenter: ImageFeed.ImageListPresenterProtocol?
    var tableView: UITableView!
    var prepareCall: Bool = false
    var gradientCall: Bool = false
    var updateTableCall: Bool = false
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        prepareCall = true
    }
    
    func pictureGradient(tablesView: UIImageView, heightForRowAt indexPath: IndexPath) {
        gradientCall = true
    }
    
    func updateTableViewAnimated() {
        updateTableCall = true
    }
    
    
}
