//
//  BarAnimation.swift
//
//
//  Created by Igor Shelopaev on 27.05.2021.
//

import SwiftUI
import Service

/// View with animation for launching
public struct BarAnimation: View, Stylable {
    
    /// Bar Store
    @StateObject fileprivate var store = BarStore()
    
    /// Logger service
    @EnvironmentObject var logger: Logger
    
    /// The type of view representing the body of this view.
    public var body: some View {
        GeometryReader { proxy in
            HStack {
                ForEach(1..<store.count) { i in
                    barAnimationRGB.mask(
                        Rectangle()
                            .frame( width: barWidth(proxy), height: barHeight(i) )
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .onAppear {
                logger.log("Animation started")
                store.startAnimation()
                
            }
            .onDisappear { store.stopAnimation() }
        }
    }
    
    // MARK: - Life circle
    
    public init() { }
    
    // MARK: - Private Methods
    
    private func barWidth(_ proxy : GeometryProxy) -> CGFloat {
        proxy.size.width / CGFloat(store.count * 2)
    }
    
    private func barHeight(_ index : Int) -> CGFloat{
        store.bars[index - 1].height
    }
    
}

// MARK: -- Store --

/// Generate and manage animation bars
fileprivate class BarStore: ObservableObject {
    
    @Published private(set) var bars: [Bar] = []
    
    private let barMaxHeight: CGFloat = 250
    private let barMinHeight: CGFloat = 50
    private var maxCount = 25
    
    private var timer: [Timer] = []
    
    
    /// Lenth of an animation circle
    var loopTime: Double {
        25.0
    }
    /// Count of bars in Store
    var count: Int {
        bars.count
    }
    
    // MARK: - Life circle
    
    init() {
        for i in 0..<25 {
            bars.append(Bar(id: i, height: barMinHeight))
        }
    }
    
    // MARK: - API Methods
    
    func stopAnimation() {
        self.timer.forEach { t in
            t.invalidate()
        }
    }
    /// Start animation
    func startAnimation() {
        
        for i in 1..<(count + 1) {
            let speedUp = (loopTime / 3) / Double(i)
            let speedDown = speedUp * 3
            let timer = Timer.scheduledTimer(withTimeInterval: speedUp + speedDown, repeats: true) { _ in
                withAnimation(Animation.linear(duration: speedUp)) {
                    self.setMaxHeight(forBar: i)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + speedUp) {
                    withAnimation(Animation.linear(duration: speedDown)) {
                        self.setMinHeight(forBar: i)
                    }
                }
            }
            self.timer.append(timer)
        }
    }
    
    // MARK: - Private Methods
    
    private func setMaxHeight(forBar index: Int) {
        bars[index - 1].height = barMaxHeight
    }
    
    private func setMinHeight(forBar index: Int) {
        bars[index - 1].height = barMinHeight
    }
    
}

// MARK: -- Model --

/// Animation Bar
fileprivate struct Bar: Identifiable, Hashable {
    var id: Int
    var height: CGFloat
}
