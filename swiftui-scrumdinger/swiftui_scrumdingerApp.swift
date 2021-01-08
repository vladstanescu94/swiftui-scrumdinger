//
//  swiftui_scrumdingerApp.swift
//  swiftui-scrumdinger
//
//  Created by Vlad Stanescu on 07.01.2021.
//

import SwiftUI

@main
struct swiftui_scrumdingerApp: App {
    @State private var scrums = DailyScrum.data
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
