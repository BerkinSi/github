//
//  SearchViewController.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import GithubUI
import UIKit

protocol SearchViewInterface: TableViewInterface, BaseViewInterface {

    func prepareNoData()
    func prepareSearchBar()
}

final class RepoSearchViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var noDataLabel: UILabel!
    
    private var searchHelper: SearchHelper!
    
    var presenter: SearchViewPresenterInterface!
    
    // MARK: Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: SearchViewInterface methods

extension RepoSearchViewController: SearchViewInterface {

    func prepareSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Please type to search"
        prepareSearchHelper()
    }
    
    func preparePageTitle() {
        self.navigationItem.title = "Search"
    }
    
    func prepareNoData() {
        noDataLabel.text = "There is no data."
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
        
        registerCells()
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
        noDataLabel.isHidden = presenter.numberOfItems != 0
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchTableViewCell.self, for: indexPath)
        
        let presentation = self.presenter.cellPresentation(index: indexPath.row)
        cell.setupUI(cellPresentation: presentation, index: indexPath.row, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
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

    func registerCells() {
        tableView.register(cellType: SearchTableViewCell.self)
    }
    
    func prepareSearchHelper() {
        searchHelper = SearchHelper(
            interval: 0.4
        ) { [weak self] text in
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
