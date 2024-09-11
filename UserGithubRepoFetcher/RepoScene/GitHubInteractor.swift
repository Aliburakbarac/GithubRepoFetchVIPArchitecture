//
//  GitHubInteractor.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import Foundation

protocol GitHubInteractorProtocol {
    func fetchPublicRepos(request: GitHubRepoViewModels.Request)
}

final class GitHubInteractor: GitHubInteractorProtocol {
    private let worker: GitHubWorker
    var presenter: GitHubPresenterProtocol?

    init(worker: GitHubWorker, presenter: GitHubPresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
    }

    func fetchPublicRepos(request: GitHubRepoViewModels.Request) {
        Task {
            do {
                let response = try await self.worker.fetchRepos(for: request.username)
                presenter?.presentFetchedRepos(response: response)
            } catch {
                switch error {
                case let gitHubError as GitHubRouterError:
                    presenter?.presentFetchError(error: gitHubError)
                default:
                    presenter?.presentFetchError(error: .invalidURL)
                }
            }
        }
    }
}

