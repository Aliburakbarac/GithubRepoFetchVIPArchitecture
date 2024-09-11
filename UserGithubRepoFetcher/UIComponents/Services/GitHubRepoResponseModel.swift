//
//  GitHubRepoResponseModel.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 11.09.2024.
//

import Foundation

struct GitHubRepoResponse: Codable {
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
