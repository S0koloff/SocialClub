//
//  ProfileVM.swift
//  SocialClub
//
//  Created by Sokolov on 17.11.2023.
//

import UIKit

final class ProfileViewModel {
    
    let user: UserViewModel
    
    init(user: UserViewModel) {
        self.user = user
    }
    
    var userPhoto: UIImage? {
        return user.photo
    }
    
    var userName: String {
        return "\(user.user.name.first) \(user.user.name.last)"
    }
    
    var userGender: String {
        return "Gender: \(user.user.gender)"
    }
    
    var userEmail: String {
        return "Email: \(user.user.email)"
    }
    
    var userLocationCity: String {
        return "City: \(user.user.location.city)"
    }
    
    var userLocationCountry: String {
        return "Country: \(user.user.location.country)"
    }
    
    var topViewColor: UIColor {
        return UIColor.randomColor()
    }
}
