//
//  TemplateViewPresenter.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Foundation
import RealmSwift

// MARK: - NewsFeedPresenterProtocol
protocol NewsFeedPresenterProtocol: AnyObject {
    var newsArray: [ArticleDetails] { get }
    var selectedCategory: Categories { get }
    
    func viewLoaded()
    func refreshTriggered()
    func isFavouriteArticle(_ article: ArticleDetails) -> Bool
    func favouriteButtonDidTap(at indexPath: IndexPath)
    func willDisplayCell(at indexPath: IndexPath)
    func searchTextDidChange(_ text: String)
    func selected(category: Categories)
}

// MARK: - NewsFeedPresenter
final class NewsFeedPresenter {
    
    // MARK: - Private properties
    private weak var view: NewsFeedViewProtocol?
    private var network = PecodeTestTask.shared.network
    private var pageNumber = 1
    private var numberOfPages = 0
    private var searchText = ""
    private(set) var selectedCategory: Categories = .none
    private let pageSize = 20
    
    // MARK: - Public properties
    var newsArray: [ArticleDetails] = []
    
    // MARK: - Lifecycle
    init(view: NewsFeedViewProtocol) {
        self.view = view
    }
    
    // MARK: - Private methods
    private func getNewsFeed(searchText: String = "") {
        network.getNewsFeed(page: pageNumber,
                            searchText: searchText,
                            category: selectedCategory.rawValue).done { [weak self] response in
            guard let self else { return }
            
            if self.pageNumber > 1 {
                self.newsArray.append(contentsOf: response.articles)
            } else {
                self.newsArray = response.articles
            }
            
            self.sortArticles()
            self.view?.reloadData(shouldDisplayLoadingCell: self.newsArray.count < response.totalResults)
            self.view?.hideRefreshControl()
            self.numberOfPages = response.totalResults / self.pageSize
        }.catch { [weak self] error in
            self?.view?.hideRefreshControl()
            print(error)
        }
    }
    
    private func isObjectExisted(article: ArticleDetails) -> Bool {
        let realm = try! Realm()
        let existingObject = realm.object(ofType: ArticleDetails.self, forPrimaryKey: article.url)
        return article.url == existingObject?.url
    }
    
    private func sortArticles() {
        self.newsArray.sort { lhs, rhs in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let lhsDate = dateFormatter.date(from: lhs.publishedAt ?? "") ?? Date()
            let rhsDate = dateFormatter.date(from: rhs.publishedAt ?? "") ?? Date()
            return lhsDate > rhsDate
        }
    }
}

// MARK: - NewsFeedPresenterProtocol implementation
extension NewsFeedPresenter: NewsFeedPresenterProtocol {
    func selected(category: Categories) {
        self.selectedCategory = category
        self.view?.cleanSearchBar()
        self.getNewsFeed()
    }
    
    func isFavouriteArticle(_ article: ArticleDetails) -> Bool {
        return isObjectExisted(article: article)
    }
    
    func searchTextDidChange(_ text: String) {
        self.searchText = text
        self.pageNumber = 1
        self.newsArray = []
        self.getNewsFeed(searchText: self.searchText)
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        if indexPath.row == (pageSize * pageNumber - 1) {
            pageNumber += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.getNewsFeed()
            }
        }
    }
    
    func refreshTriggered() {
        getNewsFeed()
    }
    
    func viewLoaded() {
        getNewsFeed()
    }
    
    func favouriteButtonDidTap(at indexPath: IndexPath) {
        let realm = try! Realm()
        let object = newsArray[indexPath.row]
        if isObjectExisted(article: object) {
            let existedObject = realm.object(ofType: ArticleDetails.self, forPrimaryKey: object.url)
            try! realm.write {
                realm.delete(existedObject!)
            }
        } else {
            try! realm.write {
                let objectCopy = ArticleDetails(value: object)
                realm.add(objectCopy)
            }
        }
        view?.reloadData()
    }
}
