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
                Text("AircoreMediaPanel version \(Client.frameworkVersion)")
                    .font(.footnote)
            }
            .padding()

            // Embed the MediaPanel in your current View.
            panel
                .collapsedView()
                .ignoresSafeArea()
        }
    }
}
