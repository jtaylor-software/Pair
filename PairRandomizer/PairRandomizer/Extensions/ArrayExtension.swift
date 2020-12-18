//
//  ArrayExtension.swift
//  PairRandomizer
//
//  Created by Jeremy Taylor on 12/18/20.
//

import Foundation

extension Array {
    mutating func random() {
        for _ in 0..<10 { sort { (_,_) in arc4random() < arc4random() } }
    }
}
