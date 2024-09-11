//
//  ViewController.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import UIKit
import SafariServices

protocol GitHubViewProtocol: AnyObject {
    func displayRepos(_ viewModels: [GitHubRepoViewModels.Repos])
    func displayError(errorTitle: String, errorMessage: String)
}

final class GitHubViewController: UIViewController, GitHubViewProtocol {
    
    private let interactor: GitHubInteractorProtocol
    private let router: GitHubRouter
    private var repos: [GitHubRepoViewModels.Repos] = []
    
    // MARK: - Initializers
    init(interactor: GitHubInteractorProtocol, router: GitHubRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        layout()
        fetchRepos()
    }

    private func layout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchRepos() {
        interactor.fetchPublicRepos(request: GitHubRepoViewModels.Request(username: "aliburakbarac"))
    }

    func displayRepos(_ viewModels: [GitHubRepoViewModels.Repos]) {
        self.repos = viewModels
        tableView.reloadData()
    }

    func displayError(errorTitle: String, errorMessage: String) {
        router.presentError(errorTitle: errorTitle, errorMessage: errorMessage)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension GitHubViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let repo = repos[safeIndex: indexPath.row] else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseIdentifier, for: indexPath) as? RepoCell else {
            return UITableViewCell()
        }
        cell.configure(with: repo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repo = repos[safeIndex: indexPath.row], let url = URL(string: repo.htmlURL) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
