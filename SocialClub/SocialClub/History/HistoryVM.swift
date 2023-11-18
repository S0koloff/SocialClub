//
//  HistoryVM.swift
//  SocialClub
//
//  Created by Sokolov on 16.11.2023.
//

import UIKit


final class HistoryViewModel {
        
    private var viewedUsers: [UserViewModel] {
        return UserListViewModel.shared.viewedUsers
    }
    
    func countOfUsers() -> Int {
        return viewedUsers.count
    }
    
    func viewedUsers(at index: Int) -> UserViewModel {
        return viewedUsers[index]
    }
    
    func maleUsersCount() -> Int {
        return viewedUsers.filter { $0.user.gender == "male" }.count
    }
    
    func femaleUsersCount() -> Int {
        return viewedUsers.filter { $0.user.gender == "female" }.count
    }
    
    func maleUser(at index: Int) -> UserViewModel {
        let maleUsers = viewedUsers.filter { $0.user.gender == "male" }
        return maleUsers[index]
    }
    
    func femaleUser(at index: Int) -> UserViewModel {
        let femaleUsers = viewedUsers.filter { $0.user.gender == "female" }
        return femaleUsers[index]
    }
}
