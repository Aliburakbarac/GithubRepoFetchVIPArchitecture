//
//  GitHubPresenter.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import Foundation

protocol GitHubPresenterProtocol: AnyObject {
    func presentFetchedRepos(response: GitHubRepoViewModels.Response)
    func presentFetchError(error: GitHubRouterError)
}

final class GitHubPresenter: GitHubPresenterProtocol {
    
    weak var viewController: GitHubViewProtocol?

    func presentFetchedRepos(response: GitHubRepoViewModels.Response) {
        DispatchQueue.main.async {
            let repos = response.repos.map { GitHubRepoViewModels.Repos(name: $0.name, htmlURL: $0.htmlURL) }
            self.viewController?.displayRepos(repos)
        }
    }

    func presentFetchError(error: GitHubRouterError) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let errorTitle = LocalizationKey.fetchErrorTitle
            let errorMessage: String
            
            switch error {
            case .invalidURL:
                errorMessage = LocalizationKey.invalidURLErrorMessage
            case .unableToOpenURL:
                errorMessage = LocalizationKey.unableToOpenURLErrorMessage
            }

            self.viewController?.displayError(errorTitle: errorTitle, errorMessage: errorMessage)
        }
    }
}
