//
//  RepositoryDetailInteractor.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation
import GithubAPI

protocol RepositoryDetailInteractorInterface {
}

protocol RepositoryDetailInteractorOutput: BaseInteractorOutput {
}

final class RepositoryDetailInteractor {

    weak var output: RepositoryDetailInteractorOutput?
}

extension RepositoryDetailInteractor: RepositoryDetailInteractorInterface {
}
