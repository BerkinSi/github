//
//  SearchViewInteractor.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation
import GithubAPI

protocol RepoSearchViewInteractorInterface {
    func search(text: String?)
    func reset()
}

protocol RepoSearchViewInteractorOutput: BaseInteractorOutput {
    func handleSearchingRepos(result: Result<SearchReposContainerDTO?, Error>)
}

private extension RepoSearchViewInteractor {
    enum Constants {
        static let perPage = 10
    }
}

final class RepoSearchViewInteractor {
    weak var output: RepoSearchViewInteractorOutput?
    private var searchReposService: SearchReposServiceProtocol
    private var pageNumber: Int = 1
    
    init(searchReposService: SearchReposServiceProtocol) {
        self.searchReposService = searchReposService
    }
}

extension RepoSearchViewInteractor: RepoSearchViewInteractorInterface {
    func search(text: String?) {
        searchReposService.searchRepos(text: text, pageNumber: pageNumber, perPage: Constants.perPage) { [weak self] (result) in
            guard let self = self else { return }
            self.pageNumber += 1
            self.output?.handleSearchingRepos(result: result)
        }
    }
    
    func reset() {
        pageNumber = 1
    }
}
