//
//  copyOnWriteValueType.swift
//  NGTools
//
//  Created by Werck, Ayrton on 2018-11-05.
//  Copyright © 2018 Nuglif. All rights reserved.
//
//  cf. https://github.com/apple/swift/blob/master/docs/OptimizationTips.rst#advice-use-copy-on-write-semantics-for-large-values

fileprivate final class Ref<T> {
    var val: T
    init(_ v: T) { val = v }
}

public struct Box<T> {
    fileprivate var ref: Ref<T>
    public init(_ x: T) { ref = Ref(x) }

    public var value: T {
        get { return ref.val }
        set {
            if !isKnownUniquelyReferenced(&ref) {
                ref = Ref(newValue)
                return
            }
            ref.val = newValue
        }
    }
}
