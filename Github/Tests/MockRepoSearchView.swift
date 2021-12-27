//
//  MockRepoSearchView.swift
//  GithubTests
//
//  Created by Emrah Akgül on 12.12.2021.
//

@testable import Github

class MockRepoSearchView: RepoSearchViewInterface {

    var invokedPrepareNoData = false
    var invokedPrepareNoDataCount = 0

    func prepareNoData() {
        invokedPrepareNoData = true
        invokedPrepareNoDataCount += 1
    }

    var invokedPrepareSearchBar = false
    var invokedPrepareSearchBarCount = 0

    func prepareSearchBar() {
        invokedPrepareSearchBar = true
        invokedPrepareSearchBarCount += 1
    }

    var invokedReloadTableView = false
    var invokedReloadTableViewCount = 0

    func reloadTableView() {
        invokedReloadTableView = true
        invokedReloadTableViewCount += 1
    }

    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0

    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }

    var invokedPreparePageTitle = false
    var invokedPreparePageTitleCount = 0

    func preparePageTitle() {
        invokedPreparePageTitle = true
        invokedPreparePageTitleCount += 1
    }

    var invokedShowError = false
    var invokedShowErrorCount = 0

    func showError() {
        invokedShowError = true
        invokedShowErrorCount += 1
    }
}
