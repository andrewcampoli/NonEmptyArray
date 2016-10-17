//
//  NonEmptyArray.swift
//  NonEmptyArray
//
//  Created by Soroush Khanlou on 10/15/16.
//  Copyright © 2016 Soroush Khanlou. All rights reserved.
//

import Foundation

public struct NonEmptyArray<Element> {
    
    fileprivate var elements: Array<Element>
    
    public init?(array: [Element]) {
        guard !array.isEmpty else {
            return nil
        }
        self.elements = array
    }
    
    public init(elements: Element...) {
        self.elements = elements
    }
    
    public init?<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        self.init(array: Array<Element>(sequence))
    }
    
    public init?() {
        return nil
    }
    
    public var count: Int {
        return elements.count
    }
    
    public var first: Element {
        return elements.first!
    }
    
    public var last: Element {
        return elements.last!
    }
    
    public var isEmpty: Bool {
        return false
    }
    
    public func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element {
        return try elements.min(by: areInIncreasingOrder)!
    }
    
    public func max(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element {
        return try elements.max(by: areInIncreasingOrder)!
    }
    
    public mutating func insert<C: Collection>(contentsOf collection: C, at index: Index) where C.Iterator.Element == Element {
        elements.insert(contentsOf: collection, at: index)
    }
    
    public mutating func insert(_ newElement: Element, at index: Index) {
        elements.insert(newElement, at: index)
    }
    
    public mutating func append(_ newElement: Element) {
        elements.append(newElement)
    }
    
    public func appending(_ newElement: Element) -> NonEmptyArray<Element> {
        var copy = self
        copy.append(newElement)
        return copy
    }
}

extension NonEmptyArray: CustomStringConvertible {
    public var description: String {
        return elements.description
    }
}

extension NonEmptyArray: CustomDebugStringConvertible {
    public var debugDescription: String {
        return elements.debugDescription
    }
}

extension NonEmptyArray: Collection {
    public typealias Index = Int
    
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return count
    }
    
    public subscript(_ index: Int) -> Element {
        return elements[index]
    }
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
}

extension NonEmptyArray where Element: Comparable {
    public func min() -> Element {
        return elements.min()!
    }
    
    public func max() -> Element {
        return elements.max()!
    }
    
    public mutating func sort() {
        elements.sort()
    }
}

public func ==<Element: Equatable>(lhs: NonEmptyArray<Element>, rhs: NonEmptyArray<Element>) -> Bool {
    return lhs.elements == rhs.elements
}

public func !=<Element: Equatable>(lhs: NonEmptyArray<Element>, rhs: NonEmptyArray<Element>) -> Bool {
    return lhs.elements != rhs.elements
}
