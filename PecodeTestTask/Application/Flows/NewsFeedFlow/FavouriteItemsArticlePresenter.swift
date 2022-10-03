//
//  FavouriteItemsArticlePresenter.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 01.10.2022.
//

import Foundation
import RealmSwift

// MARK: - FavouriteItemsArticlePresenter
final class FavouriteItemsArticlePresenter {
    
    // MARK: - Public properties
    var newsArray: [ArticleDetails] = []
    
    // MARK: - Private properties
    private weak var view: NewsFeedViewProtocol?
    
    // MARK: - Lifecycle
    init(view: NewsFeedViewProtocol) {
        self.view = view
    }
}

// MARK: - FavouriteItemsArticlePresenter implementation
extension FavouriteItemsArticlePresenter: NewsFeedPresenterProtocol {
    var selectedCategory: Categories {
        return .none
    }
    
    func selected(category: Categories) { }
    func searchTextDidChange(_ text: String) { }
    func willDisplayCell(at indexPath: IndexPath) { }
    func refreshTriggered() { }
    func favouriteButtonDidTap(at indexPath: IndexPath) { }
    func viewLoaded() {
        let realm = try! Realm()
        newsArray = realm.objects(ArticleDetails.self).map { $0 }
        view?.reloadData(shouldDisplayLoadingCell: false)
    }
    
    func isFavouriteArticle(_ article: ArticleDetails) -> Bool {
        return true
    }
}
