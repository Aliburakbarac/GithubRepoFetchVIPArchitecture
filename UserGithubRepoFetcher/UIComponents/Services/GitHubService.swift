//
//  GitHubService.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 10.09.2024.
//

import Foundation

protocol GitHubServiceProtocol {
    func fetchRepos(for username: String) async throws -> [GitHubRepo]
}

final class GitHubService: GitHubServiceProtocol {
    func fetchRepos(for username: String) async throws -> [GitHubRepo] {
        let urlString = "https://api.github.com/users/\(username)/repos"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data , _) = try await URLSession.shared.data(from: url)
        let repos = try JSONDecoder().decode([GitHubRepo].self, from: data)
        return repos
    }
}
