//
//  GitHubRepoRequest.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 11.09.2024.
//

import Foundation

struct GitHubRepoRequest {
    let username: String
    
    var url: URL? {
        let urlString = "https://api.github.com/users/\(username)/repos"
        return URL(string: urlString)
    }
}
