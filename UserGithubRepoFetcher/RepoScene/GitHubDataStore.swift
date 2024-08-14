//
//  GithubDataStore.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import Foundation

actor GitHubDataStore {
    private var repos: [GitHubRepo] = []

    func saveRepos(newRepos: [GitHubRepo]) {
        repos.append(contentsOf: newRepos)
    }

    func getRepos() async -> [GitHubRepo] {
           return repos
    }
}
