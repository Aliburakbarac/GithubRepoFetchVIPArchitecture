//
//  GitHubWorker.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import Foundation

final class GitHubWorker {
    private let dataStore: GitHubDataStore

    init(dataStore: GitHubDataStore) {
        self.dataStore = dataStore
    }

    func fetchRepos(for username: String) async throws -> [GitHubRepo] {
        let urlString = "https://api.github.com/users/\(username)/repos"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let repos = try JSONDecoder().decode([GitHubRepo].self, from: data)
        await dataStore.saveRepos(newRepos: repos)
        return await dataStore.getRepos()
    }
}

