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
        GeometryReader { proxy in
            HStack {
                ForEach(1..<count) { i in
                    barAnimationRGB.mask(
                        ZStack {
                            Rectangle()
                                .frame(
                                width: proxy.size.width / CGFloat(count * 2),
                                height: store.bars[i - 1].height
                            )
                        }
                    )
                }
            }
                .frame(maxWidth: .infinity)
                .onAppear {
                startAnimation()
            }
        }
    }

    // MARK: - Life circle
    
    public init() { }

// MARK: - Private Methods

/// Start animation
    private func startAnimation() {

        for i in 1..<(store.count + 1) {
            let speedUp = (store.loopTime / 3) / Double(i)
            let speedDown = speedUp * 3
            Timer.scheduledTimer(withTimeInterval: speedUp + speedDown, repeats: true) { _ in
                withAnimation(Animation.linear(duration: speedUp)) {
                    store.setMaxHeight(forBar: i)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + speedUp) {
                    withAnimation(Animation.linear(duration: speedDown)) {
                        store.setMinHeight(forBar: i)
                    }
                }
            }
        }
    }
}

// MARK: -- Store --

/// Generate and manage animation bars
class BarStore: ObservableObject {

    @Published private(set) var bars: [Bar] = []

    private let barMaxHeight: CGFloat = 250
    private let barMinHeight: CGFloat = 50
    private var maxCount = 25


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

    func setMaxHeight(forBar index: Int) {
        bars[index - 1].height = barMaxHeight
    }

    func setMinHeight(forBar index: Int) {
        bars[index - 1].height = barMinHeight
    }

}

// MARK: -- Model --

/// Animation Bar
struct Bar: Identifiable, Hashable {
    var id: Int
    var height: CGFloat
}
