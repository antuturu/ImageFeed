//
//  ImagesListPresenterSpy.swift
//  ImageFeedTest
//
//  Created by Александр Акимов on 05.02.2024.
//

import ImageFeed
import UIKit

final class ImagesListPresenterSpy: ImageListPresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var view: ImagesListControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func imageListCellDidTapLike(_ cell: ImageFeed.ImagesListCell) {
        
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?, photos: [ImageFeed.Photo]) {
        
    }
    
    func configCell(for cell: ImageFeed.ImagesListCell, with indexPath: IndexPath, photos: [ImageFeed.Photo]) {
        
    }
}
