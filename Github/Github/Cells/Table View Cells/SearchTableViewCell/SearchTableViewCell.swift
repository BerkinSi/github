//
//  SearchTableViewCell.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Kingfisher
import UIKit

protocol SearchTableViewCellDelegate: AnyObject {

    func didTapAvatar(at index: Int)
}

final class SearchTableViewCell: UITableViewCell {

    private var index: Int!
    private weak var delegate: SearchTableViewCellDelegate?

    // MARK: IBOutlets

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var avatarButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(
        cellPresentation: SearchTableViewCellPresentation?,
        index: Int,
        delegate: SearchTableViewCellDelegate?
    ) {
        self.delegate = delegate
        self.index = index
        self.titleLabel.text = cellPresentation?.repoName
        self.detailLabel.text = cellPresentation?.ownerName
        if let url = URL(string: cellPresentation?.imageUrl ?? "") {
            self.avatarImageView.kf.setImage(with: url)
        } else {
            self.avatarImageView.image = nil
        }
    }
    
    @IBAction private func didTapAvatarButton() {
        delegate?.didTapAvatar(at: index)
    }
}
