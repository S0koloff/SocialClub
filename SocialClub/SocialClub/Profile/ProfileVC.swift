//
//  ProfileVC.swift
//  SocialClub
//
//  Created by Sokolov on 17.11.2023.
//

import UIKit
import SnapKit

final class ProfileVC: UIViewController {
    
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.layer.borderWidth = 4
        avatarImage.layer.borderColor = Colors.white.cgColor
        avatarImage.layer.cornerRadius = 50
        avatarImage.clipsToBounds = true
        return avatarImage
    }()

    private lazy var topView: UIView = {
        let topView = UIView()
        return topView
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.textAlignment = .center
        return nameLabel
    }()

    private lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return genderLabel
    }()

    private lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailLabel.numberOfLines = 0
        return emailLabel
    }()

    private lazy var locationCityLabel: UILabel = {
        let locationCityLabel = UILabel()
        locationCityLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return locationCityLabel
    }()

    private lazy var locationCountryLabel: UILabel = {
        let locationCountryLabel = UILabel()
        locationCountryLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return locationCountryLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        
        setupView()
        setupConstraints()
        bindViewModel()
    }
    
    private func setupView() {
        view.addSubview(topView)
        view.addSubview(avatarImage)
        view.addSubview(nameLabel)
        view.addSubview(genderLabel)
        view.addSubview(emailLabel)
        view.addSubview(locationCityLabel)
        view.addSubview(locationCountryLabel)
    }

    private func setupConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.height.equalTo(150)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }

        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(view).inset(100)
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.centerX.equalTo(view)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(12)
            make.centerX.equalTo(view)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        locationCityLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        locationCountryLabel.snp.makeConstraints { make in
            make.top.equalTo(locationCityLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func bindViewModel() {
        avatarImage.image = viewModel.userPhoto
        nameLabel.text = viewModel.userName
        genderLabel.text = viewModel.userGender
        emailLabel.text = viewModel.userEmail
        locationCityLabel.text = viewModel.userLocationCity
        locationCountryLabel.text = viewModel.userLocationCountry
        topView.backgroundColor = viewModel.topViewColor
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            if UIDevice.current.orientation.isLandscape {
                self.genderLabel.snp.remakeConstraints { make in
                    make.top.equalTo(self.nameLabel.snp.bottom).offset(25)
                    make.left.equalTo(self.view.safeAreaLayoutGuide).inset(16)
                }

                self.emailLabel.snp.remakeConstraints { make in
                    make.top.equalTo(self.genderLabel.snp.bottom).offset(25)
                    make.left.equalTo(self.view.safeAreaLayoutGuide).inset(16)
                }

                self.locationCityLabel.snp.remakeConstraints { make in
                    make.top.equalTo(self.nameLabel.snp.bottom).offset(25)
                    make.right.equalTo(self.view.safeAreaLayoutGuide).inset(16)
                }

                self.locationCountryLabel.snp.remakeConstraints { make in
                    make.top.equalTo(self.locationCityLabel.snp.bottom).offset(25)
                    make.right.equalTo(self.view.safeAreaLayoutGuide).inset(16)
                }

            } else {
                self.genderLabel.snp.remakeConstraints { make in
                    make.top.equalTo(self.nameLabel.snp.bottom).offset(25)
                    make.leading.trailing.equalToSuperview().inset(16)
                }

                self.emailLabel.snp.makeConstraints { make in
                    make.top.equalTo(self.genderLabel.snp.bottom).offset(25)
                    make.leading.trailing.equalToSuperview().inset(16)
                }

                self.locationCityLabel.snp.remakeConstraints { make in
                    make.top.equalTo(self.emailLabel.snp.bottom).offset(25)
                    make.leading.trailing.equalToSuperview().inset(16)
                }

                self.locationCountryLabel.snp.makeConstraints { make in
                    make.top.equalTo(self.locationCityLabel.snp.bottom).offset(25)
                    make.leading.trailing.equalToSuperview().inset(16)
                }
            }

            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

