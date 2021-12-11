//
//  SearchViewPresenter.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation
import GithubAPI

protocol RepoSearchViewPresenterInterface: TableViewPresenterInterface, BasePresenterInterface {
    
    func searchRepos(with text: String?)
    func removeRepos()
    func cellPresentation(index: Int) -> SearchTableViewCellPresentation?
    func selectAvatar(at: Int)
    func selectRepo(at index: Int)
}

final class RepoSearchViewPresenter {

    private weak var view: RepoSearchViewInterface?
    private let router: RepoSearchViewRouterInterface?
    private let interactor: RepoSearchViewInteractorInterface?
    private var cellPresentations: [SearchTableViewCellPresentation]?
    private var repos: [RepoItemDTO]?
    
    init(view: RepoSearchViewInterface?, router: RepoSearchViewRouterInterface?, interactor: RepoSearchViewInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension RepoSearchViewPresenter : RepoSearchViewPresenterInterface {
    
    func selectRepo(at index:Int) {
        if let repo = repos?[index] {
            let repositoryDetailPresentation = RepositoryDetailPresentation(repo: repo)
            self.router?.navigateToRepositoryDetail(repositoryDetailPresentation: repositoryDetailPresentation)
        }
    }
    
    func selectAvatar(at index: Int) {
        guard let cellPresentation = cellPresentation(index: index) else { return }
        self.router?.navigateToUserDetail(with: cellPresentation.ownerName)
    }
    
    func cellPresentation(index: Int) -> SearchTableViewCellPresentation? {
        cellPresentations?[index]
    }
    
    func removeRepos() {
        cellPresentations?.removeAll()
        interactor?.reset()
        view?.reloadTableView()
    }
    
    func searchRepos(with text: String?) {
        interactor?.search(text: text)
    }
    
    func viewDidLoad() {
        view?.prepareTableView()
        view?.prepareNoData()
        view?.preparePageTitle()
        view?.prepareSearchBar()
    }
    
    var numberOfItems: Int {
        let count = cellPresentations?.count ?? 0
        return count
    }
}

extension RepoSearchViewPresenter: RepoSearchViewInteractorOutput {

    func handleSearchingRepos(result: Result<SearchReposContainerDTO?, Error>) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch result {
            case .success(let searchReposContainerDTO):
                self.handleCellPresentations(searchReposContainerDTO: searchReposContainerDTO)
                self.view?.reloadTableView()
            case .failure(let error):
                self.view?.showError()
                print(error)
            }
        }
    }
}

private extension RepoSearchViewPresenter {
    
    func handleCellPresentations(searchReposContainerDTO: SearchReposContainerDTO?) {
        guard let reposContainerDTO = searchReposContainerDTO else { return }
        guard let repoItems = reposContainerDTO.items else {return }
        
        let itemPresentations = repoItems.map{SearchTableViewCellPresentation(repoItemDTO: $0)}
        if cellPresentations == nil {
            cellPresentations = itemPresentations
        }
        else {
            cellPresentations?.append(contentsOf: itemPresentations)
        }
        
        if repos == nil {
            repos = repoItems
        }
        else {
            repos?.append(contentsOf: repoItems)
        }
    }
}
