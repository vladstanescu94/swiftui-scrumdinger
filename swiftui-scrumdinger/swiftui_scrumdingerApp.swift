//
//  swiftui_scrumdingerApp.swift
//  swiftui-scrumdinger
//
//  Created by Vlad Stanescu on 07.01.2021.
//

import SwiftUI

@main
struct swiftui_scrumdingerApp: App {
    @ObservedObject private var data = ScrumData()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
            .onChange(of: scenePhase, perform: { phase in
                if phase == .background {
                    data.save()
                }
            })
        }
    }
}
