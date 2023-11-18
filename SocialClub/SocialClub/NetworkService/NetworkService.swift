//
//  NetworkService.swift
//  SocialClub
//
//  Created by Sokolov on 15.11.2023.
//

import Alamofire
import UIKit

class NetworkService {
    
    static let shared = NetworkService(); private init() { }
    
    func getUser(completion: @escaping (Result<[User], Error>) -> ()) {
        AF.request("https://randomuser.me/api/?results=20")
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        completion(.failure(error))
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let userResults = try decoder.decode(RandomUserResponse.self, from: data)
                    completion(.success(userResults.results))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    func getImage(for imageUrlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = URL(string: imageUrlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NetworkError.invalidImageData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


