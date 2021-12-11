//
//  UserDetailViewController.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import UIKit

protocol UserDetailInterface: TableViewInterface, BaseViewInterface { }

final class UserDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: UserDetailPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension UserDetailViewController: UserDetailInterface {

    func reloadTableView() {
        tableView.reloadData()
    }
    
    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

        tableView.register(cellType: UserProfileTableViewCell.self)
        tableView.register(cellType: RepoTableViewCell.self)
    }
    
    func preparePageTitle() {
        self.title = NSLocalizedString("user_detail_page_title", comment: "")
    }
}

// MARK: UITableViewDataSource Methods

extension UserDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == .zero {
            let cell = tableView.dequeueReusableCell(with: UserProfileTableViewCell.self, for: indexPath)
            let profilePresentation = presenter.getUserProfileCellPresentation()
            cell.setupUI(userProfileTableViewCellPresentation: profilePresentation)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(with: RepoTableViewCell.self, for: indexPath)
            let repoPresentation = presenter.repoCellPresentation(at: indexPath.row)
            cell.setupUI(repoTableViewCellPresentation: repoPresentation)
            return cell
        }
    }
}

// MARK: UITableViewDelegate Methods

extension UserDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: UITableViewDataSourcePrefetching Methods

extension UserDetailViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let lastIndex = indexPaths.last?.item, lastIndex == presenter.numberOfItems - 1 else { return }
        presenter.getRepos()
    }
}
