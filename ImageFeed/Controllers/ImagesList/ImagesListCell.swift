//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Александр Акимов on 14.11.2023.
//

import UIKit

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}

final public class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    weak var delegate: ImagesListCellDelegate?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        delegate?.imageListCellDidTapLike(self)
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        imageCell.kf.cancelDownloadTask()
    }
    
    public func setIsLiked(isLiked: Bool) {
        let like = isLiked ? UIImage(named: "likeButtonOn"): UIImage(named: "likeButtonOff")
        likeButton.setImage(like, for: .normal)
    }
}
