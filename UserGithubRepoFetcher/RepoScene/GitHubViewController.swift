//
//  ViewController.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 14.08.2024.
//

import UIKit
import SafariServices

protocol GitHubViewProtocol: AnyObject {
    func displayRepos(repos: [GitHubRepo])
    func displayError(error: String)
}

final class GitHubViewController: UIViewController, GitHubViewProtocol {
    
    private let interactor: GitHubInteractorProtocol
    private let router: GitHubRouter
    private var repos: [GitHubRepo] = []
    
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
        interactor.fetchPublicRepos(username: "aliburakbarac")
    }

    func displayRepos(repos: [GitHubRepo]) {
        self.repos = repos
        tableView.reloadData()
    }

    func displayError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension GitHubViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Safe indexing fakat extension yazılıp kısaltılabilir.
        
        guard indexPath.row < repos.count else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseIdentifier, for: indexPath) as! RepoCell
        cell.configure(with: repos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Safe indexing fakat extension yazılıp kısaltılabilir.

        guard indexPath.row < repos.count, let url = URL(string: repos[indexPath.row].htmlURL) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
