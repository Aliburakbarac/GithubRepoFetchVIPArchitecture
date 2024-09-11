//
//  GitHubPresenter.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import Foundation

protocol GitHubPresenterProtocol: AnyObject {
    func presentFetchedRepos(repos: [GitHubRepo])
    func presentFetchError(error: GitHubRouterError)
}

final class GitHubPresenter: GitHubPresenterProtocol {
    
    weak var viewController: GitHubViewProtocol?

    func presentFetchedRepos(repos: [GitHubRepo]) {
        DispatchQueue.main.async {
            self.viewController?.displayRepos(repos: repos)
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

