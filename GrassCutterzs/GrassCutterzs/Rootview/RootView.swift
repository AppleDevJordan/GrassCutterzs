//
//  RootView.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/18/25.
//


import SwiftUI
import AVKit

struct RootView: View {
    @EnvironmentObject var mediaData: MediaData

    var body: some View {
        TabView {
            HomeTabView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            ProfileTabView()
                .environmentObject(mediaData) // Pass shared data
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }

            SettingsTabView()
                .environmentObject(mediaData)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}


// Dummy tab views — you can customize these later


