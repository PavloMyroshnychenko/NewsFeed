//
//  ArticleDetailsViewController.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 01.10.2022.
//

import UIKit
import WebKit

// MARK: - ArticleDetailsViewProtocol
protocol ArticleDetailsViewProtocol: AnyObject {
    func show(url: URL)
}

// MARK: - ArticleDetailsViewController
final class ArticleDetailsViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet var articleWebView: WKWebView!
    
    // MARK: - Public properties
    var presenter: ArticleDetailsPresenterProtocol!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
}

// MARK: - ArticleDetailsViewProtocol implementation
extension ArticleDetailsViewController: ArticleDetailsViewProtocol {
    func show(url: URL) {
        let request = URLRequest(url: url)
        articleWebView.load(request)
    }
}
