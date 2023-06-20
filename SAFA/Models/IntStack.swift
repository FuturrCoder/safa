//
//  IntStack.swift
//  SAFA
//
//  Created by Mirai DTN on 6/19/23.
//

import Foundation

struct IntStack: Codable, Collection {
    typealias Index = Int
    typealias Element = Int
    
    var storage: [Int]
    var isEmpty: Bool { storage.isEmpty }
    var count: Int { storage.count }
    var first: Int? { storage.last }
    var startIndex: Int { 0 }
    var endIndex: Int { count }
    
    subscript(position: Int) -> Int {
        get { storage[count - position - 1] }
        set { storage[count - position - 1] = newValue }
    }
    
    init(from array: [Int] = []) { self.storage = array.reversed() }
    
    func index(after i: Int) -> Int {
        return storage.index(before: i)
    }
    mutating func push(_ n: Int) { storage.append(n) }
    mutating func pop() -> Int? { storage.popLast() }
}
