//
//  UserDetailPresenter.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation
import GithubAPI
import GithubUI

protocol UserDetailPresenterInterface: TableViewPresenterInterface, BasePresenterInterface {

    func repoCellPresentation(at index: Int) -> RepoTableViewCellPresentation?
    func getUserProfileCellPresentation() -> UserProfileTableViewCellPresentation?
    func getRepos()
}

final class UserDetailPresenter {

    private weak var view: UserDetailInterface?
    private let router: UserDetailRouterInterface?
    private let interactor: UserDetailInteractorInterface?
    private let userName: String?
    
    private var userProfileCellPresentation: UserProfileTableViewCellPresentation?
    private var repoCellPresentations: [RepoTableViewCellPresentation]?

    init(
        view: UserDetailInterface?,
        router: UserDetailRouterInterface?,
        interactor: UserDetailInteractorInterface?,
        userName: String?
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.userName = userName
    }
}

extension UserDetailPresenter: UserDetailPresenterInterface {

    func getRepos() {
        interactor?.getRepos(username: userName)
    }
    
    func getUserProfileCellPresentation() -> UserProfileTableViewCellPresentation? {
        return self.userProfileCellPresentation
    }
    
    func repoCellPresentation(at index: Int) -> RepoTableViewCellPresentation? {
        return repoCellPresentations?[index - 1]
    }
    
    var numberOfItems: Int {
        if userProfileCellPresentation == nil {
            return .zero
        }
        return (repoCellPresentations?.count ?? 0) + 1
    }
    
    func viewDidLoad() {
        view?.prepareTableView()
        view?.preparePageTitle()
        interactor?.getUserProfile(username: userName)
    }
}

extension UserDetailPresenter: UserDetailInteractorOutput {
    
    func setLoading(shouldLoad: Bool) {
        if shouldLoad {
            LoaderView.shared.startLoading()
        } else {
            LoaderView.shared.stopLoading()
        }
    }
    
    func handleGettingRepos(result: Result<[RepoItemDTO]?, Error>) {
        switch result {
        case .success(let repoItems):
            guard let items = repoItems else { return }
            let itemPresentations = items.map { RepoTableViewCellPresentation(repoItemDTO: $0) }
            if self.repoCellPresentations == nil {
                self.repoCellPresentations = itemPresentations
            } else {
                self.repoCellPresentations?.append(contentsOf: itemPresentations)
            }
            self.view?.reloadTableView()
        case .failure(let error):
            self.view?.showError()
            print(error)
        }
    }
    
    func handleGettingUserProfile(result: Result<UserDTO?, Error>) {
        switch result {
        case .success(let userDTO):
            self.userProfileCellPresentation = UserProfileTableViewCellPresentation(userDTO: userDTO)
            self.interactor?.getRepos(username: self.userName)
        case .failure(let error):
            self.view?.showError()
            print(error)
        }
    }
}
