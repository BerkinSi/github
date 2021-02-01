//
//  SearchViewRouter.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import UIKit
import GithubUI

protocol RepoSearchViewRouterInterface {
    func navigateToUserDetail(with ownerName: String?)
    func navigateToRepositoryDetail(repositoryDetailPresentation: RepositoryDetailPresentation?)
}

final class RepoSearchViewRouter {
    weak var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController: UINavigationController? = nil) -> RepoSearchViewController {
        let view = RepoSearchViewController.initFromNib()
        let router = RepoSearchViewRouter(with: navigationController)
        let interactor = RepoSearchViewInteractor(searchReposService: appDIContainer.searchReposService)
        
        let presenter = RepoSearchViewPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
}

extension RepoSearchViewRouter: RepoSearchViewRouterInterface {
    func navigateToRepositoryDetail(repositoryDetailPresentation: RepositoryDetailPresentation?) {
        let view = RepositoryDetailRouter.createModule(using: self.navigationController, repositoryDetailPresentation: repositoryDetailPresentation)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func navigateToUserDetail(with userName: String?) {
        let view = UserDetailRouter.createModule(using: self.navigationController, userName: userName)
        self.navigationController?.pushViewController(view, animated: true)
    }
}
