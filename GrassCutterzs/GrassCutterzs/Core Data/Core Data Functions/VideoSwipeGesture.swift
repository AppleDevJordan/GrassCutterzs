//
//  VideoSwipeGesture.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/24/25.
//


import SwiftUI

struct VideoSwipeGesture: ViewModifier {
    var onSwipeLeft: () -> Void
    var onSwipeRight: () -> Void
    var onSwipeDown: () -> Void

    @GestureState private var dragOffset: CGSize = .zero

    func body(content: Content) -> some View {
        content.gesture(
            DragGesture()
                .updating($dragOffset) { value, state, _ in
                    state = value.translation
                }
                .onEnded { value in
                    if value.translation.width < -50 {
                        onSwipeLeft()
                    } else if value.translation.width > 50 {
                        onSwipeRight()
                    } else if value.translation.height > 50 {
                        onSwipeDown()
                    }
                }
        )
    }
}
