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
        }
    }
}
