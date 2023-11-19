//
//  UserModel.swift
//  SocialClub
//
//  Created by Sokolov on 16.11.2023.
//

import UIKit

struct UserViewModel {
    let user: User
    var photo: UIImage?
    
    init(user: User) {
        self.user = user
    }
}
