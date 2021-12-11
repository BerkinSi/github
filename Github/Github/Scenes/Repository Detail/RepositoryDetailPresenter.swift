//
//  RepositoryDetailPresenter.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

protocol RepositoryDetailPresenterInterface: BasePresenterInterface {

    func getRepositoryDetailPresentation() -> RepositoryDetailPresentation?
    func selectAvatarImage()
}

final class RepositoryDetailPresenter {

    private weak var view: RepositoryDetailInterface?
    private let router: RepositoryDetailRouterInterface?
    private let interactor: RepositoryDetailInteractorInterface?
    private let repositoryDetailPresentation: RepositoryDetailPresentation?
    
    init(
        view: RepositoryDetailInterface?,
        router: RepositoryDetailRouterInterface?,
        interactor: RepositoryDetailInteractorInterface?,
        repositoryDetailPresentation: RepositoryDetailPresentation?
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.repositoryDetailPresentation = repositoryDetailPresentation
    }
}

extension RepositoryDetailPresenter: RepositoryDetailPresenterInterface {
    
    func selectAvatarImage() {
        router?.navigateToUserDetail(with: repositoryDetailPresentation?.userName ?? "")
    }
    
    func getRepositoryDetailPresentation() -> RepositoryDetailPresentation? {
        return self.repositoryDetailPresentation
    }
    
    func viewDidLoad() {
        view?.preparePageTitle()
        view?.prepareViews()
    }
}

extension RepositoryDetailPresenter: RepositoryDetailInteractorInterface {
}

extension RepositoryDetailPresenter: RepositoryDetailInteractorOutput {
}
