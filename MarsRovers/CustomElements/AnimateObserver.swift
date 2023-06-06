//
//  AnimateObserver.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.05.2023.
//

import SwiftUI

struct AnimateObserver<Value: VectorArithmetic>: AnimatableModifier {
    
    private let observedValue: Value
    private let onChange: ((Value) -> Void)?
    private let onComplete: (() -> Void)?
    public var animatableData: Value {
        didSet {
            notifyProgress()
        }
    }
    
    public init(for observedValue: Value, onChange: ((Value) -> Void)?, onComplete: (() -> Void)?) {
        self.observedValue = observedValue
        self.onChange = onChange
        self.onComplete = onComplete
        animatableData = observedValue
    }
    
    public func body(content: Content) -> some View {
        content
    }
    
    private func notifyProgress() {
        DispatchQueue.main.async {
            onChange?(animatableData)
            if animatableData == observedValue {
                onComplete?()
            }
        }
    }
}
