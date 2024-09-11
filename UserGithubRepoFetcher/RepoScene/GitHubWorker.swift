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

    func fetchRepos(for username: String) async throws -> GitHubRepoViewModels.Response {
        let request = GitHubRepoViewModels.Request(username: username)
        let repos = try await service.fetchRepos(for: request)
        return GitHubRepoViewModels.Response(repos: repos.map { GitHubRepoViewModels.Response.Repo(id: 0, name: $0.name, fullName: "", description: nil, htmlURL: $0.htmlURL) })
    }
}
