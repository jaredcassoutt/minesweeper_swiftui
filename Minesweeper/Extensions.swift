//
//  Extensions.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/8/24.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
