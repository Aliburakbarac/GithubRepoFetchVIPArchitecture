//
//  Array+Extensions.swift
//  UserGithubRepoFetcher
//
//  Created by Ali Burak Baraç on 11.09.2024.
//

import Foundation

extension Array {
    subscript(safeIndex index: Index) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}
