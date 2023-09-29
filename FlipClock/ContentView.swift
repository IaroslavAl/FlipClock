//
//  ContentView.swift
//  FlipClock
//
//  Created by Iaroslav Beldin on 29.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 32) {
            FlipClock(size: 80, style: .short)
            
            Spacer()
            
            FlipClock()
            
            FlipClock(size: 35)
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
