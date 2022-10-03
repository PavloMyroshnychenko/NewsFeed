//
//  NewsTableViewCell.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import UIKit
import Kingfisher

// MARK: - NewsTableViewCellDelegate
protocol NewsTableViewCellDelegate: AnyObject {
    func favouriteButtonDidTap(cell: UITableViewCell)
}

// MARK: - NewsTableViewCell
final class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Public properties
    weak var delegate: NewsTableViewCellDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var sourceLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var favouriteButton: UIButton!
    
    // MARK: - Publick method
    func configureWith(article: ArticleDetails, isFavourite: Bool) {
        newsImage.kf.setImage(with: URL(string: article.urlToImage ?? ""))
        sourceLabel.text = article.source?.name
        titleLabel.text = article.title
        descriptionLabel.text = article.articleDescription
        authorLabel.text = article.author
        favouriteButton.setImage(UIImage(systemName: isFavourite ? "star.fill" : "star"),
                                 for: .normal)
    }
    
    // MARK: - IBActions
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        delegate?.favouriteButtonDidTap(cell: self)
    }
}
