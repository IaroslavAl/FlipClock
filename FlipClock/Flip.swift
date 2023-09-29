//
//  Flip.swift
//  FlipClock
//
//  Created by Iaroslav Beldin on 29.09.2023.
//

import SwiftUI

struct Flip: View {
    private let text: String
    private let size: CGFloat
    @State private var newValue: String = ""
    @State private var oldValue: String = ""
    @State private var animateTop: Bool = false
    @State private var animateBottom: Bool = false
    
    init(text: String, size: CGFloat) {
        self.text = text
        self.size = size
    }
    
    var body: some View {
        showFlip()
        .onAppear {
            newValue = text
            oldValue = text
        }
        .onChange(of: text) { value in
            update(value)
        }
    }
}

private extension Flip {
    enum FlipType {
        case top
        case bottom
    }
    
    func showFlip() -> some View {
        VStack(spacing: .zero) {
            showDoubleHalf(type: .top, animate: animateTop)
            Color(uiColor: .systemGray)
                .frame(height: size * 0.03)
            showDoubleHalf(type: .bottom, animate: animateBottom)
        }
        .fixedSize()
    }
    
    func showDoubleHalf(type: FlipType, animate: Bool) -> some View {
        ZStack {
            showHalf(
                text: type == .top ? newValue : oldValue,
                type: type
            )
            showHalf(
                text: type == .top ? oldValue : newValue,
                type: type
            )
            .rotation3DEffect(
                .degrees(
                    type == .top
                    ? animate ? -90 : 0
                    : animate ? 0 : 90
                ),
                axis: (1, 0, 0),
                anchor: type == .top ? .bottom : .top,
                perspective: 0.5
            )
        }
    }
    
    func showHalf(text: String, type: FlipType) -> some View {
        Text(text)
            .font(.system(size: size))
            .fontWeight(.heavy)
            .foregroundColor(Color(uiColor: .label))
            .fixedSize()
            .padding(type == .top ? .bottom : .top, -size * 0.5)
            .frame(
                width: size * 0.4,
                height: size * 0.5,
                alignment: type == .top ? .bottom : .top
            )
            .padding(type == .top ? .top : .bottom, size * 0.25)
            .padding(.horizontal, size * 0.25)
            .background(Color(uiColor: .systemGray5))
            .cornerRadius(size * 0.1)
            .padding(type == .top ? .bottom : .top, -size * 0.1)
            .clipped()
    }
    
    func update(_ value: String) {
        oldValue = newValue
        animateTop = false
        animateBottom = false
        
        withAnimation(Animation.easeIn(duration: 0.25)) {
            newValue = value
            animateTop = true
        }
        
        withAnimation(Animation.easeOut(duration: 0.25).delay(0.25)) {
            animateBottom = true
        }
    }
}
