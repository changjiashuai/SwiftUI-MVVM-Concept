//
//  BarChartAnimation.swift
//
//
//  Created by Igor Shelopaev on 27.05.2021.
//

import SwiftUI

/// View with animation for launching
public struct BarChartAnimation: View, Stylable {
    
    /// Bar Store
    @StateObject var store = BarStore()

    
    /// Count of bars for animation
    var count: Int {
        store.count
    }
    
    /// The type of view representing the body of this view.
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                HStack {
                    ForEach(1..<count) { i in
                        ZStack {
                            barAnimationRGB.mask(
                                ZStack { Rectangle()
                                        .frame(
                                        width: proxy.size.width / CGFloat(count * 2),
                                        height: store.bars[i - 1].height
                                    )
                                }
                            )
                        }
                    }
                }
            }
        }.onAppear {
            startAnimation()
        }
    }
    
    /// Initializer
    public init() { }
    
    // MARK: - Private Methods
    
    /// Start animation
    private func startAnimation() {

        for i in 1..<(store.count + 1) {
            let speedUp = (store.loopTime / 3) / Double(i)
            let speedDown = speedUp * 3
            Timer.scheduledTimer(withTimeInterval: speedUp + speedDown, repeats: true) { _ in
                withAnimation(Animation.linear(duration: speedUp)) {
                    store.bars[i - 1].height = store.barMaxHeight
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + speedUp) {
                    withAnimation(Animation.linear(duration: speedDown)) {
                        store.bars[i - 1].height = store.barMinHeight
                    }
                }
            }
        }
    }
}


/// Animation Bar
struct Bar: Identifiable, Hashable {
    var id: Int
    var height: CGFloat
}


/// Generate and manage animation bars
class BarStore: ObservableObject {

    @Published var bars: [Bar] = []

    let barMinHeight: CGFloat = 50
    let loopTime: Double = 25.0
    let barMaxHeight: CGFloat = 250

    var maxCount = 25
    
    /// Count of bars in Store
    var count: Int {
        bars.count
    }

    /// Initializer
    init() {
        addBars()
    }

    
    /// Add items to Store
    func addBars() {
        for i in 0..<25 {
            bars.append(Bar(id: i, height: barMinHeight))
        }
    }
}
