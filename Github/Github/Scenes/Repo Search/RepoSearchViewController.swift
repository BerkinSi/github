//
//  SearchViewController.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import UIKit
import GithubUI

protocol RepoSearchViewInterface: TableViewInterface, BaseViewInterface {

    func prepareNoData()
    func prepareSearchBar()
}

// MARK: Constants

private extension RepoSearchViewController {

    enum Constants {

        static let tableViewHeight: CGFloat = 128
        static let throttlingTime: Double = 0.4
    }
}

final class RepoSearchViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noDataLabel: UILabel!
    
    private var searchHelper: SearchHelper!
    
    var presenter: RepoSearchViewPresenterInterface!
    
    // MARK: Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: SearchViewInterface methods

extension RepoSearchViewController: RepoSearchViewInterface {

    func prepareSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = NSLocalizedString("type_to_search", comment: "")
        prepareSearchHelper()
    }
    
    func preparePageTitle() {
        self.navigationItem.title = NSLocalizedString("Search", comment: "")
    }
    
    func prepareNoData() {
        noDataLabel.text = NSLocalizedString("search_no_data", comment: "")
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.register(cellType: SearchTableViewCell.self)
    }
}

// MARK: UIScrollViewDelegate methods

extension RepoSearchViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(false)
    }
}

// MARK: UISearchBarDelegate methods

extension RepoSearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchHelper.handleTyping(text: searchText)
    }
}


// MARK: UITableViewDataSource & UITableViewDelegate & UITableViewDataSourcePrefetching methods

extension RepoSearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noDataLabel.isHidden = presenter.numberOfItems != .zero
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(with: SearchTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        
        let presentation = self.presenter.cellPresentation(index: indexPath.row)
        cell.setupUI(cellPresentation: presentation, index: indexPath.row, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewHeight
    }
}

extension RepoSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.selectRepo(at: indexPath.row)
    }
}

extension RepoSearchViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let lastIndex = indexPaths.last?.item,
              lastIndex == presenter.numberOfItems - 1 else { return }
        presenter.searchRepos(with: searchBar.searchTextField.text ?? "")
    }
}

// MARK: Private Methods

private extension RepoSearchViewController {

    func prepareSearchHelper() {
        searchHelper = SearchHelper(interval: Constants.throttlingTime) { [weak self] (text) in
            guard let self = self else { return }
            self.presenter.removeRepos()
            self.presenter.searchRepos(with: text)
        }
    }
}

// MARK: SearchTableViewCellDelegate methods

extension RepoSearchViewController: SearchTableViewCellDelegate {

    func didTapAvatar(at index: Int) {
        presenter.selectAvatar(at: index)
    }
}
