//
//  UserListVC.swift
//  SocialClub
//
//  Created by Sokolov on 14.11.2023.
//

import UIKit
import SnapKit

final class UserListVC: UIViewController {
    
    private var viewModel = UserListViewModel.shared
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CommonTableViewCell.self, forCellReuseIdentifier: CommonTableViewCell.identifire)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupConstraints()
        setupCustomNavigation()
        setupTableView()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    private func setupCustomNavigation() {
        let rightButton = UIButton(type: .system)
        rightButton.setImage(Icons.userListNavigationRightButton?.withRenderingMode(.alwaysTemplate), for: .normal)
        rightButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        rightButton.tintColor = Colors.lightBlue
        rightButton.imageView?.contentMode = .scaleAspectFit
        rightButton.addTarget(self, action: #selector(self.refreshButtonAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    private func setupTableView() {
        tableView.alpha = 0
        
        activityIndicator.startAnimating()
        
        viewModel.fetchUsers { [weak self] error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
                return
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self?.tableView.reloadData()
                    UIView.animate(withDuration: 0.5, animations: {
                        self?.activityIndicator.stopAnimating()
                        self?.tableView.alpha = 1
                    }, completion: nil)
                }
            }
        }
    }
    
    @objc func refreshButtonAction() {
        setupTableView()
    }
}

extension UserListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfUsers()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonTableViewCell.identifire, for: indexPath) as! CommonTableViewCell
        cell.selectionStyle = .none
        cell.setupUser(user: viewModel.user(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = viewModel.user(at: indexPath.row)
        viewModel.markAsViewed(user: selectedUser)
        let profileViewModel = ProfileViewModel(user: selectedUser)
        let vc = ProfileVC(viewModel: profileViewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
