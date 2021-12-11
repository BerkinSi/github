//
//  RepositoryDetailViewController.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import UIKit

protocol RepositoryDetailInterface: BaseViewInterface {

    func prepareViews()
}

final class RepositoryDetailViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var avatarButton: UIButton!
    @IBOutlet private weak var repoNameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var forkCountLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var repo: UILabel!
    @IBOutlet private weak var username: UILabel!
    @IBOutlet private weak var forkCount: UILabel!
    @IBOutlet private weak var language: UILabel!

    var presenter: RepositoryDetailPresenterInterface!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction private func avatarButtonTapped() {
        presenter.selectAvatarImage()
    }
}

extension RepositoryDetailViewController: RepositoryDetailInterface {
    
    func preparePageTitle() {
        self.title = NSLocalizedString("repository_detail_page_title", comment: "")
    }

    func prepareViews() {
        repo.text = NSLocalizedString("repo_name_label", comment: "")
        username.text = NSLocalizedString("username_label", comment: "")
        forkCount.text = NSLocalizedString("fork_count", comment: "")
        language.text = NSLocalizedString("programming_language_label", comment: "")

        let presentation = presenter.getRepositoryDetailPresentation()
        if let url = URL(string: (presentation?.imageUrl ?? "")) {
            avatarImageView.kf.setImage(with: url)
        } else {
            avatarImageView.image = nil
        }
        
        repoNameLabel.text = presentation?.repoName ?? "-"
        usernameLabel.text = presentation?.userName ?? "-"
        let forksCount = (presentation?.forksCount ?? 0)
        forkCountLabel.text = String(format:"%.f", forksCount)
        languageLabel.text = presentation?.programmingLanguage ?? "-"
    }
}
