//
//  DetailView.swift
//  swiftui-scrumdinger
//
//  Created by Vlad Stanescu on 07.01.2021.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var data: DailyScrum.Data = DailyScrum.Data()
    @State private var isPresented = false
    
    // MARK: - Localized Strings
    private let headerText: LocalizedStringKey = "meetingInfo"
    private let startMeetingLabel: LocalizedStringKey = "meetingStart"
    private let lengthLabel: LocalizedStringKey = "lengthLabel"
    private let colorLabel: LocalizedStringKey = "colorLabel"
    private let attendeesTitle: LocalizedStringKey = "attendeesLabel"
    private let historyTitle: LocalizedStringKey = "historyLabel"
    private let editButtonLabel: LocalizedStringKey = "editLabel"
    private let cancelButtonLabel: LocalizedStringKey = "cancelLabel"
    private let doneButtonLabel: LocalizedStringKey = "doneLabel"

    // MARK: - View Body
    
    var body: some View {
        List {
            Section(header: Text(headerText)) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label(startMeetingLabel, systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .accessibilityLabel(Text("Start meeting"))
                }
                HStack {
                    Label(lengthLabel, systemImage: "clock")
                        .accessibilityLabel(Text("Meeting length"))
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                HStack {
                    Label(colorLabel, systemImage: "paintpalette")
                        .accessibilityLabel(Text("Meeting length"))
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(scrum.color)
                }
                .accessibilityElement(children: .ignore)
            }
            Section(header: Text(attendeesTitle)) {
                ForEach(scrum.attendees, id: \.self) { attendee in
                    Label(attendee, systemImage: "person")
                        .accessibilityLabel(Text("Person"))
                        .accessibilityValue(Text(attendee))
                }
            }
            Section(header: Text(historyTitle)) {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history) { history in
                    NavigationLink(destination: HistoryView(history: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(scrum.title)
        .navigationBarItems(trailing: Button(editButtonLabel) {
            isPresented = true
            data = scrum.data
        })
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $data)
                    .navigationTitle(scrum.title)
                    .navigationBarItems(leading: Button(cancelButtonLabel) {
                        isPresented = false
                    }, trailing: Button(doneButtonLabel) {
                        isPresented = false
                        scrum.update(from: data)
                    })
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.data[0]))
        }
    }
}
