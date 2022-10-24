//
//  ContentView.swift
//  MediaPanel-SwiftUI
//
//  Created by Deepak on 10/5/22.
//

import SwiftUI
import AircoreMediaPanel

struct ContentView: View {
    let panel: MediaPanel

    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()

            // Embed the MediaPanel in your current View.
            panel
                .collapsedView()
                .ignoresSafeArea()
        }
    }
}
