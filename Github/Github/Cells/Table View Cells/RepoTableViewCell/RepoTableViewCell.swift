//
//  RepoTableViewCell.swift
//  Github
//
//  Created by Emrah Akgül on 26.01.2021.
//

import UIKit

final class RepoTableViewCell: UITableViewCell {

    @IBOutlet private var repositoryAccessImageView: UIImageView!
    @IBOutlet private var repoNameLabel: UILabel!
    @IBOutlet private var ownerNameLabel: UILabel!
    @IBOutlet private var programmingLanguageLabel: UILabel!
    @IBOutlet private var repoLabel: UILabel!
    @IBOutlet private var ownerLabel: UILabel!
    @IBOutlet private var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        repoLabel.text = NSLocalizedString("repo_name_label", comment: "")
        ownerLabel.text = NSLocalizedString("owner_name_label", comment: "")
        languageLabel.text = NSLocalizedString("programming_language_label", comment: "")
    }
    
    func setupUI(repoTableViewCellPresentation: RepoTableViewCellPresentation?) {
        if repoTableViewCellPresentation?.isPrivate ?? true {
            repositoryAccessImageView.image = UIImage(systemName: "lock")
        } else {
            repositoryAccessImageView.image = UIImage(systemName: "lock.open")
        }
        repoNameLabel.text = repoTableViewCellPresentation?.repoName ?? "-"
        ownerNameLabel.text = repoTableViewCellPresentation?.ownerName ?? "-"
        programmingLanguageLabel.text = repoTableViewCellPresentation?.programmingLanguage ?? "-"
    }
}
