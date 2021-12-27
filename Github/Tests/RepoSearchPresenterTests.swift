//
//  RepoSearchPresenterTests.swift
//  GithubTests
//
//  Created by Emrah Akgül on 12.12.2021.
//

import XCTest
import GithubAPI
@testable import Github
import Accelerate

let searchResponse: SearchReposContainerDTO = SearchReposContainerDTO(
    totalCount: 2, items:
        [
            RepoItemDTO(
                id: 1,
                name: "",
                fullName: "",
                owner: RepoOwnerDTO(id: 1, login: "", avatarURL: ""),
                forksCount: 2,
                defaultBranchName: "asd",
                programmingLanguage: "asdasd",
                isPrivate: false
            ),
            RepoItemDTO(
                id: 2,
                name: "",
                fullName: "",
                owner: RepoOwnerDTO(id: 1, login: "", avatarURL: ""),
                forksCount: 2,
                defaultBranchName: "",
                programmingLanguage: "",
                isPrivate: false
            )
        ]
)

final class RepoSearchViewPresenterTests: XCTestCase {

    enum RepoSearchError: Error {

        case dummyError
    }

    private var view: MockRepoSearchView!
    private var interactor: MockRepoSearchInteractor!
    private var router: MockRepoSearchRouter!
    private var sut: RepoSearchViewPresenter!

    override func setUp() {
        super.setUp()
        view = .init()
        router = .init()
        interactor = .init()
        sut = .init(view: view, router: router, interactor: interactor)
    }

    func test_viewDidLoad_InvokesViewMethods() {
        XCTAssertEqual(view.invokedPrepareTableViewCount, 0)
        XCTAssertEqual(view.invokedPrepareNoDataCount, 0)
        XCTAssertEqual(view.invokedPreparePageTitleCount, 0)
        XCTAssertEqual(view.invokedPrepareSearchBarCount, 0)

        sut.viewDidLoad()

        XCTAssertEqual(view.invokedPrepareTableViewCount, 1)
        XCTAssertEqual(view.invokedPrepareNoDataCount, 1)
        XCTAssertEqual(view.invokedPreparePageTitleCount, 1)
        XCTAssertEqual(view.invokedPrepareSearchBarCount, 1)
    }

    func test_searchRepos_InvokesInteractorMethod() {
        XCTAssertFalse(interactor.invokedSearch)

        sut.searchRepos(with: "tempText")

        XCTAssertEqual(interactor.invokedSearchParameters?.text, "tempText")
    }

    func test_givenRepos_whenSelectedRepo_thenInvokesRepositoryDetail() {
        // Given
        sut.handleSearchingRepos(result: .success(searchResponse))
        // When
        sut.selectRepo(at: 0)
        XCTAssertTrue(router.invokedNavigateToRepositoryDetail)
    }

    func test_givenRepos_whenSelectedAvatar_thenInvokesUserDetail() {
        // Given
        sut.handleSearchingRepos(result: .success(searchResponse))
        // When
        sut.selectAvatar(at: 0)
        XCTAssertTrue(router.invokedNavigateToUserDetail)
    }

    func test_givenRepos_whenDeleted_thenInvokesInteractorReset() {
        // Given
        sut.handleSearchingRepos(result: .success(searchResponse))
        // When
        sut.removeRepos()
        XCTAssertTrue(interactor.invokedReset)
    }

    func test_whenPaginationHappened_thenNumberOfItemsIncreased() {
        // When
        sut.handleSearchingRepos(result: .success(searchResponse))
        sut.handleSearchingRepos(result: .success(searchResponse))
        let numberOfItems = (searchResponse.items?.count ?? .zero) * 2
        XCTAssertEqual(sut.numberOfItems, numberOfItems)
    }

    func test_whenRepoRetrievalFailed_thenErrorHappens() {

        sut.handleSearchingRepos(result: .failure(RepoSearchError.dummyError))
        XCTAssertTrue(view.invokedShowError)
    }

    func test_numberOfItems_CellPresentationCountIsNil_ReturnZero() {
        XCTAssertEqual(sut.numberOfItems, 0)
    }

    func test_numberOfItems_CellPresentationCountIsNotNil_ReturnPresentationCount() {
        sut.handleSearchingRepos(result: .success(searchResponse))
        XCTAssertEqual(sut.numberOfItems, searchResponse.items?.count)
    }
}
