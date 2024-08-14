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
    
    var interactor: GitHubInteractorProtocol?
    var repos: [GitHubRepo] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor?.fetchPublicRepos(username: "aliburakbarac")
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func displayRepos(repos: [GitHubRepo]) {
        self.repos = repos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// UITableViewDataSource
extension GitHubViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseIdentifier, for: indexPath) as! RepoCell
        cell.configure(with: repos[indexPath.row])
        return cell
    }
    
    //Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repos[indexPath.row]
        if let url = URL(string: repo.htmlURL) {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
}

