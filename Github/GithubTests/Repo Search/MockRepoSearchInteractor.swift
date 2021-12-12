//
//  MockRepoSearchInteractor.swift
//  GithubTests
//
//  Created by Emrah Akgül on 12.12.2021.
//

@testable import Github

class MockRepoSearchInteractor: RepoSearchViewInteractorInterface {

    var invokedSearch = false
    var invokedSearchCount = 0
    var invokedSearchParameters: (text: String?, Void)?
    var invokedSearchParametersList = [(text: String?, Void)]()

    func search(text: String?) {
        invokedSearch = true
        invokedSearchCount += 1
        invokedSearchParameters = (text, ())
        invokedSearchParametersList.append((text, ()))
    }

    var invokedReset = false
    var invokedResetCount = 0

    func reset() {
        invokedReset = true
        invokedResetCount += 1
    }
}
