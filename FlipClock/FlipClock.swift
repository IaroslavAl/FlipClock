//
//  FlipClock.swift
//  FlipClock
//
//  Created by Iaroslav Beldin on 29.09.2023.
//

import SwiftUI

struct FlipClock: View {
    private let size: CGFloat
    private let style: Style
    @State private var time: String = ""
    
    init(
        size: CGFloat = 50,
        style: Style = .full
    ) {
        self.size = size
        self.style = style
    }
    
    var body: some View {
        HStack(spacing: size * 0.1) {
            ForEach(Array(time).indices, id: \.self) { index in
                Flip(
                    text: String(Array(time)[index]),
                    size: size
                )
                .padding(
                    .trailing,
                    !index.isMultiple(of: 2) && index != time.count - 1
                    ? size * 0.15
                    : 0
                )
            }
        }
        .onAppear {
            startUpdatingTime()
        }
    }
}

extension FlipClock {
    enum Style: String {
        case full = "HHmmss"
        case short = "HHmm"
    }
}

private extension FlipClock {
    func startUpdatingTime() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = style.rawValue
            time = formatter.string(from: Date())
        }
        RunLoop.current.add(timer, forMode: .common)
    }
}
