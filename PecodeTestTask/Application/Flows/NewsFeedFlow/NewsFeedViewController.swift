//
//  NewsFeedViewController.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import UIKit

// MARK: - NewsFeedViewProtocol
protocol NewsFeedViewProtocol: AnyObject {
    var presenter: NewsFeedPresenterProtocol! { get set }
    func reloadData(shouldDisplayLoadingCell: Bool)
    func reloadData()
    func hideRefreshControl()
    func cleanSearchBar()
}

// MARK: - NewsFeedViewController
final class NewsFeedViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private var newsTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: - Private properties
    private let refreshControl = UIRefreshControl()
    private var shouldDisplayLoadingCell = false
    
    // MARK: - Public properties
    var presenter: NewsFeedPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.viewLoaded()
        searchBar.delegate = self
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.registerCell(NewsTableViewCell.self)
        newsTableView.registerCell(LoadingTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        newsTableView.addSubview(refreshControl)
    }
    
    private func showCategoriesFilter() {
        let alertController = UIAlertController(title: "Choose category",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        for category in Categories.allCases {
            var title = category != .none ? category.rawValue.capitalized : "None"
            title = category == presenter.selectedCategory ? "✔︎ " + title : title
            let alertAction = UIAlertAction(title: title,
                                            style: .default) { _ in
                self.presenter.selected(category: category)
            }
            alertController.addAction(alertAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        presenter.refreshTriggered()
    }
    
    // MARK: - IBActions
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        let viewController = NewsFeedViewController.instantiateFromStoryboard()
        let presenter = FavouriteItemsArticlePresenter(view: viewController)
        viewController.presenter = presenter
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        showCategoriesFilter()
    }
}

// MARK: - NewsFeedViewProtocol implementation
extension NewsFeedViewController: NewsFeedViewProtocol {
    func cleanSearchBar() {
        searchBar.text = ""
    }
    
    func reloadData() {
        newsTableView.reloadData()
    }
    
    func hideRefreshControl() {
        refreshControl.endRefreshing()
    }
    
    func reloadData(shouldDisplayLoadingCell: Bool) {
        self.shouldDisplayLoadingCell = shouldDisplayLoadingCell
        newsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource implementation
extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = presenter.newsArray.count
        if shouldDisplayLoadingCell {
            numberOfRows += 1
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == presenter.newsArray.count {
            let cell =  tableView.dequeueCell(LoadingTableViewCell.self, indexPath: indexPath)
            return cell
        }
        
        let cell =  tableView.dequeueCell(NewsTableViewCell.self, indexPath: indexPath)
        cell.delegate = self
        cell.configureWith(article: presenter.newsArray[indexPath.row],
                           isFavourite: presenter.isFavouriteArticle(presenter.newsArray[indexPath.row]))
        return cell
    }
}

// MARK: - UITableViewDelegate implementation
extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = ArticleDetailsViewController.instantiateFromStoryboard()
        let url = presenter.newsArray[indexPath.row].url
        let presenter = ArticleDetailsPresenter(view: viewController, url: url ?? "")
        viewController.presenter = presenter
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.willDisplayCell(at: indexPath)
    }
}

// MARK: - NewsTableViewCellDelegate implementation
extension NewsFeedViewController: NewsTableViewCellDelegate {
    func favouriteButtonDidTap(cell: UITableViewCell) {
        guard let indexPath = newsTableView.indexPath(for: cell) else { return }
        presenter.favouriteButtonDidTap(at: indexPath)
    }
}

// MARK: - UISearchBarDelegate implementation
extension NewsFeedViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchTextDidChange(searchText)
    }
}
