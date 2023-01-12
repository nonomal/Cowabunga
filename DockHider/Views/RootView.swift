//
//  RootView.swift
//  DockHider
//
//  Created by lemin on 1/6/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            SpringBoardView()
                .tabItem {
                    Label("SpringBoard Tools", systemImage: "snowflake")
                }
            /*AudioView()
                .tabItem {
                    Label("Audio Tools", systemImage: "speaker.wave.2.fill")
                }*/
            OtherModsView()
                .tabItem {
                    Label("Misc. Mods", systemImage: "hammer")
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
