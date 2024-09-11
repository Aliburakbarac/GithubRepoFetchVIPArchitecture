//
//  RepoCellView.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 11.09.2024.
//

import UIKit

class RepoCellView: UIView {
    
    private let repoNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repoUrlLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func layout() {
        addSubview(repoNameLabel)
        addSubview(repoUrlLabel)
        
        NSLayoutConstraint.activate([
            repoNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            repoNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            repoNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            repoUrlLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 4),
            repoUrlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            repoUrlLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            repoUrlLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with repo: GitHubRepo) {
        repoNameLabel.text = repo.name
        repoUrlLabel.text = repo.htmlURL
    }
}
