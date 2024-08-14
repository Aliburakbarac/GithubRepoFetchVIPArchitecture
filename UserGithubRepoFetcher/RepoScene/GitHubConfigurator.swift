//
//  GitHubConfigurator.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import Foundation

final class GitHubConfigurator {
    
    static func configureModule(for viewController: GitHubViewController) {
        let dataStore = GitHubDataStore()
        let worker = GitHubWorker(dataStore: dataStore)
        let interactor = GitHubInteractor(worker: worker)
        let presenter = GitHubPresenter()
        let router = GitHubRouter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
}

