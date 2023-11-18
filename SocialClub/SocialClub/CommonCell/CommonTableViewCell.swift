//
//  UsesListTableViewCell.swift
//  SocialClub
//
//  Created by Sokolov on 15.11.2023.
//

import UIKit
import SnapKit

final class CommonTableViewCell: UITableViewCell {
    
    static let identifire = "CommonTableViewCell"
    
    private lazy var backgroundCellView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = Colors.backgroundCellGray
        backgroundView.layer.cornerRadius = 10
        return backgroundView
    }()
    
    private lazy var avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.contentMode = .scaleAspectFill
        return avatarImage
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(backgroundCellView)
        backgroundCellView.addSubview(avatarImage)
        backgroundCellView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        
        backgroundCellView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(5)
            make.left.equalTo(contentView).offset(12)
            make.right.equalTo(contentView).inset(12)
            make.bottom.equalTo(contentView).inset(5)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.left.equalTo(backgroundCellView).inset(12)
            make.centerY.equalTo(backgroundCellView)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImage.snp.right).offset(12)
            make.centerY.equalTo(contentView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        avatarImage.clipsToBounds = true
    }
    
    func setupUser(user: UserViewModel) {
        nameLabel.text = "\(user.user.name.first) \(user.user.name.last)"
        avatarImage.image = user.photo
    }
    
}
