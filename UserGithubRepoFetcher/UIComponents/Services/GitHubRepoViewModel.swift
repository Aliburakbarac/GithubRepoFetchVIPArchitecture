//
//  GitHubRepoViewModel.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 11.09.2024.
//

import Foundation

enum GitHubRepoViewModels {
    struct Request {
        let username: String
        
        var url: URL? {
            let urlString = "https://api.github.com/users/\(username)/repos"
            return URL(string: urlString)
        }
    }
    
    struct Response: Decodable {
        let repos: [Repo]
        
        struct Repo: Decodable {
            let id: Int
            let name: String
            let fullName: String
            let description: String?
            let htmlURL: String

            enum CodingKeys: String, CodingKey {
                case id
                case name
                case fullName = "full_name"
                case description
                case htmlURL = "html_url"
            }
        }
    }
    
    struct Repos {
        let name: String
        let htmlURL: String
    }
}
