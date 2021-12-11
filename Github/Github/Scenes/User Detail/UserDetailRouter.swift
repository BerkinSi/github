//
//  UserDetailRouter.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import UIKit
import GithubUI

protocol UserDetailRouterInterface {}

final class UserDetailRouter {
    
    weak var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController: UINavigationController? = nil, userName: String?) -> UserDetailViewController {
        let view = UserDetailViewController.initFromNib()
        
        let router = UserDetailRouter(with: navigationController)
        let interactor = UserDetailInteractor(userProfileService: appDIContainer.userProfileService, userReposService: appDIContainer.userReposService)
        let presenter = UserDetailPresenter(view: view, router: router, interactor: interactor, userName: userName)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
}

extension UserDetailRouter: UserDetailRouterInterface {}
