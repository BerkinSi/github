//
//  UserDataTableViewCell.swift
//  Github
//
//  Created by Emrah Akgül on 26.01.2021.
//

import Kingfisher
import UIKit

final class UserProfileTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var email: UILabel!
    @IBOutlet private weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(userProfileTableViewCellPresentation: UserProfileTableViewCellPresentation?) {
        userLabel.text = NSLocalizedString("username_label", comment: "")
        email.text = NSLocalizedString("email", comment: "")
        name.text = NSLocalizedString("name", comment: "")
        
        if let url = URL(string: userProfileTableViewCellPresentation?.imageUrl ?? "") {
            avatarImageView.kf.setImage(with: url)
        } else {
            avatarImageView.image = nil
        }
        userNameLabel.text = userProfileTableViewCellPresentation?.username ?? "-"
        emailLabel.text = userProfileTableViewCellPresentation?.email ?? "-"
        nameLabel.text = userProfileTableViewCellPresentation?.name ?? "-"
    }
}
