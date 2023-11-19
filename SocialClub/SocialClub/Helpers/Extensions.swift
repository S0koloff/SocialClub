//
//  extensions.swift
//  SocialClub
//
//  Created by Sokolov on 17.11.2023.
//

import UIKit

extension Notification.Name {
    static let refreshUsersHistory = Notification.Name("refreshUsersHistory")
    static let clearHistory = Notification.Name("clearHistory")
}

extension UIColor {
    static func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
