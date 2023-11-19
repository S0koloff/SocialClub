//
//  UserListVM.swift
//  SocialClub
//
//  Created by Sokolov on 15.11.2023.
//

import UIKit

class UserListViewModel {
    
    static let shared = UserListViewModel()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(clearViewedUsers), name: .clearHistory, object: nil)
        }
    
    private let networkService = NetworkService.shared
    
    private var userViewModels = [UserViewModel]()
    
    var viewedUsers = [UserViewModel]()
    
    func fetchUsers(completion: @escaping (Error?) -> Void) {
        if userViewModels.count > 0 {
            userViewModels.removeAll()
        }
        networkService.getUser { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userResults):
                userResults.forEach { user in
                    let userViewModel = UserViewModel(user: user)
                    self.userViewModels.append(userViewModel)
                
                    if let photoURL = URL(string: user.picture.thumbnail) {
                        self.networkService.getImage(for: photoURL.absoluteString) { [weak self] imageResult in
                            guard let self = self else { return }
                            
                            switch imageResult {
                            case .success(let image):
                                if let index = self.userViewModels.firstIndex(where: { $0.user.login.uuid == user.login.uuid }) {
                                    self.userViewModels[index].photo = image
                                }
                            case .failure(let error):
                                print("Failed to fetch image: \(error)")
                            }
                        }
                    }
                }
                
                completion(nil)
                
            case .failure(let error):
                print(error)
                completion(error)
            }
        }
    }
    
    func countOfUsers() -> Int {
        return userViewModels.count
    }
    
    func user(at index: Int) -> UserViewModel {
        return userViewModels[index]
    }
    
    func markAsViewed(user: UserViewModel) {
        if !viewedUsers.contains(where: {$0.user.login.uuid == user.user.login.uuid}) {
            viewedUsers.append(user)
            NotificationCenter.default.post(name: .refreshUsersHistory, object: nil)
        }
    }
    
    func viewedUsers(at index: Int) -> UserViewModel {
        return viewedUsers[index]
    }
    
    @objc func clearViewedUsers() {
        viewedUsers.removeAll()
    }
    
}
