//
//  BarChartAnimation.swift
//
//
//  Created by Igor Shelopaev on 27.05.2021.
//

import SwiftUI

/// View with animation for launching
public struct BarAnimation: View, Stylable {
    
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
                store.startAnimation()
            }
            .onDisappear {
                store.stopAnimation()
            }
        }
    }
    
    // MARK: - Life circle
    
    public init() { }
    
}

// MARK: -- Store --

/// Generate and manage animation bars
class BarStore: ObservableObject {
    
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
    
    private  func setMinHeight(forBar index: Int) {
        bars[index - 1].height = barMinHeight
    }
    
}

// MARK: -- Model --

/// Animation Bar
struct Bar: Identifiable, Hashable {
    var id: Int
    var height: CGFloat
}
