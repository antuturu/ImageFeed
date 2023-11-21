//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Александр Акимов on 14.11.2023.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var imageCell: UIImageView!
}
