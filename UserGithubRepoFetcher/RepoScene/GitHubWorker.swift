//
//  GitHubWorker.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import Foundation

final class GitHubWorker {
    private let service: GitHubService

    init(service: GitHubService) {
        self.service = service
    }

    func fetchRepos(for username: String) async throws -> [GitHubRepo] {
        let request = GitHubRepoRequest(username: username)
        let repos = try await service.fetchRepos(for: request)
        return repos
    }
}

