//
//  NetworkUserModel.swift
//  SocialClub
//
//  Created by Sokolov on 15.11.2023.
//

import Foundation

struct User: Decodable {
    let gender: String
    let name: UserName
    let location: Location
    let login: LoginInfo
    let picture: Picture
    let email: String
    
    struct Location: Decodable {
        let city: String
        let country: String
    }
    
    struct UserName: Decodable {
        let first: String
        let last: String
    }
    
    struct LoginInfo: Decodable {
        let uuid: String
    }
    
    struct Picture: Decodable {
        let thumbnail: String
    }
}

struct RandomUserResponse: Decodable {
    let results: [User]
}
