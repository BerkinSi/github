//
//  RepositoryDetailRouter.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import GithubUI
import UIKit

protocol RepositoryDetailRouterInterface {

    func navigateToUserDetail(with userName: String?)
}

final class RepositoryDetailRouter {

    weak var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(
        using navigationController: UINavigationController? = nil,
        repositoryDetailPresentation: RepositoryDetailPresentation?
    ) -> RepositoryDetailViewController {
        let view = RepositoryDetailViewController.initFromNib()
        let router = RepositoryDetailRouter(with: navigationController)
        let interactor = RepositoryDetailInteractor()
        let presenter = RepositoryDetailPresenter(
            view: view,
            router: router,
            interactor: interactor,
            repositoryDetailPresentation: repositoryDetailPresentation
        )
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension RepositoryDetailRouter: RepositoryDetailRouterInterface {
    
    func navigateToUserDetail(with userName: String?) {
        let view = UserDetailRouter.createModule(using: self.navigationController, userName: userName)
        self.navigationController?.pushViewController(view, animated: true)
    }
}
