//
//  ImageListPresenter.swift
//  ImageFeed
//
//  Created by Александр Акимов on 31.01.2024.
//
import UIKit
import Kingfisher

public protocol ImageListPresenterProtocol {
    var view: ImagesListControllerProtocol? { get set }
    func viewDidLoad()
    func prepare(for segue: UIStoryboardSegue, sender: Any?, photos: [Photo])
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath, photos: [Photo])
}

final class ImagesListPresenter: ImageListPresenterProtocol {
    var view: ImagesListControllerProtocol?
    
    private let dateFormatter = DateFormatters.shared.dateFormatter
    private let showSingleImageSegueIdentifier = "ShowSingleImage"
    private let imagesListService = ImagesListService.shared
    
    func viewDidLoad() {
        imagesListService.fetchPhotosNextPage()
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?, photos: [Photo]) {
        if segue.identifier == showSingleImageSegueIdentifier {
            let viewController = segue.destination as? SingleImageViewController
            let indexPath = sender as? IndexPath
            guard let indexPath = indexPath, let viewController = viewController else {
                return
            }
            let photo = photos[indexPath.row]
            let image = URL(string: photo.largeImageURL)
            viewController.image = image
        } else {
            prepare(for: segue, sender: sender, photos: photos)
        }
    }
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath, photos: [Photo]) {
        let imageUrl = URL(string: photos[indexPath.row].thumbImageURL)
        let placeholder = UIImage(named: "placeHolder")
        cell.imageCell.kf.setImage(with: imageUrl, placeholder: placeholder) { [weak self] _ in
            guard let self = self else { return }
            view?.tableView.reloadRows(at: [indexPath], with: .automatic)
            cell.imageCell.kf.indicatorType = .none
        }
        
        let like = photos[indexPath.row].isLiked ? UIImage(named: "likeButtonOn"): UIImage(named: "likeButtonOff")
        
        if let date = photos[indexPath.row].createdAt {
            cell.dateLabel.text = dateFormatter.string(from: date as Date).replacingOccurrences(of: "r.", with: "")
        }
        cell.likeButton.setImage(like, for: .normal)
        
        view?.pictureGradient(tablesView: cell.imageCell, heightForRowAt: indexPath)
    }
}
