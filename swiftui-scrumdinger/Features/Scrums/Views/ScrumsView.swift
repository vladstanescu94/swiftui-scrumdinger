//
//  ScrumsView.swift
//  swiftui-scrumdinger
//
//  Created by Vlad Stanescu on 07.01.2021.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented = false
    @State private var newScrumData = DailyScrum.Data()
    let saveAction: () -> Void
    
    // MARK: - Localized Strings
    private let homeTitle: LocalizedStringKey = "homeTitle"
    private let dismissButtonText: LocalizedStringKey = "dismissButton"
    private let addButtonText: LocalizedStringKey = "addButton"

    //MARK: - View Body
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                    CardView(scrum: scrum)
                        
                }
                .listRowBackground(scrum.color)
            }
            .onDelete(perform: { indexSet in
                scrums.remove(atOffsets: indexSet)
            })
        }
        .navigationTitle(homeTitle)
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $newScrumData)
                    .navigationBarItems(leading: Button(dismissButtonText) {
                        isPresented = false
                    }, trailing: Button(addButtonText) {
                        let newScrum = DailyScrum(title: newScrumData.title, attendees: newScrumData.attendees, lengthInMinutes: Int(newScrumData.lengthInMinutes), color: newScrumData.color)
                        scrums.append(newScrum)
                        isPresented = false
                    })
            }
        }
        .onChange(of: scenePhase, perform: { phase in
            if phase == .inactive { saveAction() }
        })
    }
    
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: {  $0.id == scrum.id }) else {
            fatalError("Can't find scrum in array")
        }
        
        return $scrums[scrumIndex]
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data), saveAction: {})
        }
    }
}
