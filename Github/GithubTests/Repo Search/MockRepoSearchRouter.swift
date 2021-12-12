//
//  MockRepoSearchRouter.swift
//  GithubTests
//
//  Created by Emrah Akgül on 12.12.2021.
//

@testable import Github

class MockRepoSearchRouter: RepoSearchViewRouterInterface {

    var invokedNavigateToUserDetail = false
    var invokedNavigateToUserDetailCount = 0
    var invokedNavigateToUserDetailParameters: (ownerName: String?, Void)?
    var invokedNavigateToUserDetailParametersList = [(ownerName: String?, Void)]()

    func navigateToUserDetail(with ownerName: String?) {
        invokedNavigateToUserDetail = true
        invokedNavigateToUserDetailCount += 1
        invokedNavigateToUserDetailParameters = (ownerName, ())
        invokedNavigateToUserDetailParametersList.append((ownerName, ()))
    }

    var invokedNavigateToRepositoryDetail = false
    var invokedNavigateToRepositoryDetailCount = 0
    var invokedNavigateToRepositoryDetailParameters: (repositoryDetailPresentation: RepositoryDetailPresentation?, Void)?
    var invokedNavigateToRepositoryDetailParametersList = [(repositoryDetailPresentation: RepositoryDetailPresentation?, Void)]()

    func navigateToRepositoryDetail(repositoryDetailPresentation: RepositoryDetailPresentation?) {
        invokedNavigateToRepositoryDetail = true
        invokedNavigateToRepositoryDetailCount += 1
        invokedNavigateToRepositoryDetailParameters = (repositoryDetailPresentation, ())
        invokedNavigateToRepositoryDetailParametersList.append((repositoryDetailPresentation, ()))
    }
}
