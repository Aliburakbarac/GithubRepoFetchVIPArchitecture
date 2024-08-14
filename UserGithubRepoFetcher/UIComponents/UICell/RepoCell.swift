//
//  RepoCell.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 15.08.2024.
//

import UIKit

class RepoCell: UITableViewCell {
    static let reuseIdentifier = "RepoCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        repoNameLabel.text = nil
        repoUrlLabel.text = nil
    }
    
    private func setupViews() {
        contentView.addSubview(repoNameLabel)
        contentView.addSubview(repoUrlLabel)
        
        NSLayoutConstraint.activate([
            repoNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            repoNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            repoNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            repoUrlLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 4),
            repoUrlLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            repoUrlLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            repoUrlLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with repo: GitHubRepo) {
        repoNameLabel.text = repo.name
        repoUrlLabel.text = repo.htmlURL
    }
}
