//
//  RepoCell.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 15.08.2024.
//

import UIKit

class RepoCell: UITableViewCell {
    static let reuseIdentifier = "RepoCell"
    
    private let repoCellView: RepoCellView = {
      let view = RepoCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func layout() {
        contentView.addSubview(repoCellView)
        
        NSLayoutConstraint.activate([
            repoCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            repoCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            repoCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            repoCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with repo: GitHubRepoViewModels.Repos) {
        repoCellView.configure(with: repo)
    }
}

