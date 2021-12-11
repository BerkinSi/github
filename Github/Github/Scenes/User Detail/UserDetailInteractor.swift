//
//  UserDetailInteractor.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation
import GithubAPI

protocol UserDetailInteractorInterface {

    func getRepos(username: String?)
    func getUserProfile(username: String?)
}

protocol UserDetailInteractorOutput: BaseInteractorOutput {

    func handleGettingUserProfile(result: Result<UserDTO?, Error>)
    func handleGettingRepos(result: Result<[RepoItemDTO]?, Error>)
}

private extension UserDetailInteractor {

    enum Constants {

        static let perPage = 10
    }
}

final class UserDetailInteractor {

    weak var output: UserDetailInteractorOutput?
    private var userProfileService: UserProfileServiceProtocol
    private var userReposService: UserReposServiceProtocol
    private var pageNumber: Int = 1
    
    init(userProfileService: UserProfileServiceProtocol, userReposService: UserReposServiceProtocol ) {
        self.userProfileService = userProfileService
        self.userReposService = userReposService
    }
}

extension UserDetailInteractor: UserDetailInteractorInterface {
    
    func getUserProfile(username: String?) {
        self.output?.setLoading(shouldLoad: true)
        userProfileService.getUserProfile(userName: username) { [weak self] (result) in
            guard let self = self else { return }
            self.output?.setLoading(shouldLoad: false)
            self.output?.handleGettingUserProfile(result: result)
        }
    }
    
    func getRepos(username: String?) {
        self.output?.setLoading(shouldLoad: true)
        userReposService.getRepos(owner: username, pageNumber: pageNumber, perPage: Constants.perPage) { [weak self] (result) in
            guard let self = self else { return }
            self.output?.setLoading(shouldLoad: false)
            self.pageNumber += 1
            self.output?.handleGettingRepos(result: result)
        }
    }
}
