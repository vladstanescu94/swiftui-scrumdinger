//
//  HistoryView.swift
//  swiftui-scrumdinger
//
//  Created by Vlad Stanescu on 11.01.2021.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    // MARK: - Localized Strings
    private let attendeesTitle: LocalizedStringKey = "attendeesLabel"
    private let transcriptTitle: LocalizedStringKey = "transcriptLabel"

    // MARK: - View Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text(attendeesTitle)
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript {
                    Text(transcriptTitle)
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(history: History(attendees: ["Jon", "Darla", "Luis"], lengthInMinutes: 10, transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI..."))
    }
}
