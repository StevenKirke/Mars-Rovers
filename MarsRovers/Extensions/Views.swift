//
//  Views.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.05.2023.
//

import SwiftUI

public extension View {
    func animationObserver<Value: VectorArithmetic>(for value: Value,
                                                    onChange: ((Value) -> Void)? = nil,
                                                    onComplete: (() -> Void)? = nil) -> some View {
        self.modifier(AnimateObserver(for: value, onChange: onChange, onComplete: onComplete))
    }
}
