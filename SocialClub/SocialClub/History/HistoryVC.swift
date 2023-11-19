//
//  HistoryVC.swift
//  SocialClub
//
//  Created by Sokolov on 14.11.2023.
//

import UIKit
import SnapKit

final class HistoryVC: UIViewController {
    
    private var viewModel = HistoryViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CommonTableViewCell.self, forCellReuseIdentifier: CommonTableViewCell.identifire)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupConstraints()
        setupCustomNavigation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshTableView), name: .refreshUsersHistory, object: nil)
    }
    
    private func setupView() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    private func setupCustomNavigation() {
        let rightButton = UIButton(type: .system)
        rightButton.setImage(Icons.historyNavigationRightButton?.withRenderingMode(.alwaysTemplate), for: .normal)
        rightButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        rightButton.tintColor = Colors.lightBlue
        rightButton.imageView?.contentMode = .scaleAspectFit
        rightButton.addTarget(self, action: #selector(self.clearHistory), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    private func clearHistoryAlert() {
        let alertController = UIAlertController(title: "✓", message: nil, preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
        
        alertController.view.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            alertController.view.alpha = 1
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alertController.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @objc func refreshTableView() {
        tableView.reloadData()
    }
    
    @objc func clearHistory() {
        NotificationCenter.default.post(name: .clearHistory, object: nil)
        tableView.reloadData()
        clearHistoryAlert()
    }
}

extension HistoryVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.maleUsersCount()
        } else {
            return viewModel.femaleUsersCount()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonTableViewCell.identifire, for: indexPath) as! CommonTableViewCell
        
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            let user = viewModel.maleUser(at: indexPath.row)
            cell.setupUser(user: user)
            return cell
        } else {
            let user = viewModel.femaleUser(at: indexPath.row)
            cell.setupUser(user: user)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return "Male"
            } else {
                return "Female"
            }
        }
}
