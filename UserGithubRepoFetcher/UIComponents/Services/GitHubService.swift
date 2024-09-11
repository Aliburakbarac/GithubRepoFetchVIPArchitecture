//
//  GitHubService.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 10.09.2024.
//

import Foundation

protocol GitHubServiceProtocol {
    func fetchRepos(for request: GitHubRepoViewModels.Request) async throws -> [GitHubRepoViewModels.Repos]
}

final class GitHubService: GitHubServiceProtocol {
    func fetchRepos(for request: GitHubRepoViewModels.Request) async throws -> [GitHubRepoViewModels.Repos] {
        guard let url = request.url else {
            throw GitHubRouterError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw GitHubRouterError.unableToOpenURL
        }
        
        let repoResponses = try JSONDecoder().decode([GitHubRepoViewModels.Response.Repo].self, from: data)
        return repoResponses.map { GitHubRepoViewModels.Repos(name: $0.name, htmlURL: $0.htmlURL) }
    }
}
