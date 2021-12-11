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

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var avatarButton: UIButton!
    @IBOutlet private var repoNameLabel: UILabel!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var forkCountLabel: UILabel!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var repo: UILabel!
    @IBOutlet private var username: UILabel!
    @IBOutlet private var forkCount: UILabel!
    @IBOutlet private var language: UILabel!

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
