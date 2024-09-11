//
//  GitHubRouter.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import UIKit

enum GitHubRouterError: Error {
    case invalidURL
    case unableToOpenURL
}

final class GitHubRouter {
    weak var viewController: UIViewController?
    
    
    func presentError(errorTitle: String, errorMessage: String) {
           let alert = UIAlertController(
               title: NSLocalizedString(errorTitle, comment: ""),
               message: NSLocalizedString(errorMessage, comment: ""),
               preferredStyle: .alert
           )
           alert.addAction(UIAlertAction(title: NSLocalizedString(LocalizationKey.okButtonTitle, comment: ""), style: .default, handler: nil))
           viewController?.present(alert, animated: true, completion: nil)
       }
}

