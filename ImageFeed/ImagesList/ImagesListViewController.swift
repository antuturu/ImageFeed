//
//  ViewController.swift
//  ImageFeed
//
//  Created by Александр Акимов on 02.11.2023.
//

import UIKit

class ImagesListViewController: UIViewController {
    private let ShowSingleImageSegueIdentifier = "ShowSingleImage"
    
    @IBOutlet private var tableView: UITableView!
    
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowSingleImageSegueIdentifier {
            let viewController = segue.destination as! SingleImageViewController
            let indexPath = sender as! IndexPath
            let image = UIImage(named: photosName[indexPath.row])
            viewController.image = image
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let picture = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        
        let like = indexPath.row % 2 == 0 ? UIImage(named: "likeButtonOn"): UIImage(named: "likeButtonOff")
        
        cell.dateLabel.text = dateFormatter.string(from: Date())
        cell.likeButton.setImage(like, for: .normal)
        cell.imageCell.image = picture
        
        pictureGradient(tablesView: cell.imageCell, heightForRowAt: indexPath)
    }
    
    private func pictureGradient (tablesView: UIImageView, heightForRowAt indexPath: IndexPath){
        let cellHeight = tableView(tableView, heightForRowAt: indexPath)
        let lightBlue = UIColor.clear
        let blue = UIColor.black
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: cellHeight - 40, width: tablesView.bounds.width, height: 40)
        gradient.colors = [lightBlue.cgColor, blue.cgColor]
        gradient.locations = [0.0, 1.0]
        tablesView.layer.sublayers?.removeLast()
        tablesView.layer.addSublayer(gradient)
        
    }
    
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        
        return imageListCell
    }
    
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ShowSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        
        return cellHeight
    }
    
}
