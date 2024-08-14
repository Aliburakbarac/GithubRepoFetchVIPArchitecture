//
//  GitHubInteractor.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import Foundation

protocol GitHubInteractorProtocol {
    func fetchPublicRepos(username: String)
}

final class GitHubInteractor: GitHubInteractorProtocol {
    var presenter: GitHubPresenterProtocol?
    private let worker: GitHubWorker

    init(worker: GitHubWorker) {
        self.worker = worker
    }

    func fetchPublicRepos(username: String) {
        Task {
            do {
                let repos = try await worker.fetchRepos(for: username)
                presenter?.presentFetchedRepos(repos: repos)
            } catch {
                presenter?.presentFetchError(error: error.localizedDescription)
            }
        }
    }
}

