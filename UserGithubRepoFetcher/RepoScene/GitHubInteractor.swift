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
    private let worker: GitHubWorker
    var presenter: GitHubPresenterProtocol?

    init(worker: GitHubWorker, presenter: GitHubPresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
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


