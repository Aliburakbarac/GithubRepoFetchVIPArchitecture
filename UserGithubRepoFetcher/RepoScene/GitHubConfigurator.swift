//
//  GitHubConfigurator.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import Foundation
import UIKit

final class GitHubConfigurator {
    
    static func configureModule() -> UIViewController {
        let presenter = GitHubPresenter()
        let service = GitHubService()
        let worker = GitHubWorker(service: service)
        let interactor = GitHubInteractor(worker: worker, presenter: presenter)
        let router = GitHubRouter()
        let controller = GitHubViewController(interactor: interactor, router: router)
            
        presenter.viewController = controller
            
        return controller
    }
}

