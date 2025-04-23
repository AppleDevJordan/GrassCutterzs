//
//  GrassCutterzsApp.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/7/25.
//

import SwiftUI

@main
struct GrassCutterzsApp: App {
    @StateObject var mediaData = MediaData()
    @StateObject var userData = UserData()

    @State private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                RootView()
                    .environmentObject(mediaData)
                    .environmentObject(userData)
                    .onAppear {
                        mediaData.loadFromUserDefaults()
                    }
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
