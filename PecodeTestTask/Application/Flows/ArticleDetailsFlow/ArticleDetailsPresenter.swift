//
//  ArticleDetailsPresenter.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 01.10.2022.
//

import Foundation

// MARK: - ArticleDetailsPresenterProtocol
protocol ArticleDetailsPresenterProtocol: AnyObject {
    func viewLoaded()
}
// MARK: - ArticleDetailsPresenter
final class ArticleDetailsPresenter {
    
    // MARK: - Private properties
    private weak var view: ArticleDetailsViewProtocol?
    private var url: URL?
    
    // MARK: - Lifecycle
    init(view: ArticleDetailsViewProtocol, url: String) {
        self.view = view
        self.url = URL(string: url)
    }
}

// MARK: - ArticleDetailsPresenterProtocol implementation
extension ArticleDetailsPresenter: ArticleDetailsPresenterProtocol {
    func viewLoaded() {
        guard let url else { return }
        view?.show(url: url)
    }
}
