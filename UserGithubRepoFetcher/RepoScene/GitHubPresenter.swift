//
//  GitHubPresenter.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import Foundation

protocol GitHubPresenterProtocol: AnyObject {
    func presentFetchedRepos(repos: [GitHubRepo])
    func presentFetchError(error: String)
}

final class GitHubPresenter: GitHubPresenterProtocol {
    weak var viewController: GitHubViewProtocol?

    func presentFetchedRepos(repos: [GitHubRepo]) {
        viewController?.displayRepos(repos: repos)
    }

    func presentFetchError(error: String) {
        viewController?.displayError(error: error)
    }
}

