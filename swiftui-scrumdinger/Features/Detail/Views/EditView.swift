//
//  EditView.swift
//  swiftui-scrumdinger
//
//  Created by Vlad Stanescu on 07.01.2021.
//

import SwiftUI

struct EditView: View {
    @Binding var scrumData: DailyScrum.Data
    @State private var newAttendee = ""
    
    // MARK: - Localized Strings
    private let headerText: LocalizedStringKey = "meetingInfo"
    private let lengthLabel: LocalizedStringKey = "lengthLabel"
    private let colorLabel: LocalizedStringKey = "colorLabel"
    private let attendeesTitle: LocalizedStringKey = "attendeesLabel"
    private let scrumTitle: LocalizedStringKey = "scrumTitleLabel"
    private let newAttendeeLabel: LocalizedStringKey = "newAttendeeLabel"

    // MARK: - View Body
    
    var body: some View {
        List {
            Section(header: Text(headerText)) {
                TextField(scrumTitle, text: $scrumData.title)
                HStack {
                    Slider(value: $scrumData.lengthInMinutes, in: 5...30, step: 1.0) {
                        Text(lengthLabel)
                    }
                    .accessibilityValue(Text("\(Int(scrumData.lengthInMinutes)) minutes"))
                    Spacer()
                    Text("\(Int(scrumData.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ColorPicker(colorLabel, selection: $scrumData.color)
                    .accessibilityLabel(Text("Color picker"))
            }
            Section(header: Text(attendeesTitle)) {
                ForEach(scrumData.attendees, id: \.self) { attendee in
                    Text(attendee)
                }
                .onDelete(perform: { indices in
                    scrumData.attendees.remove(atOffsets: indices)
                })
                HStack {
                    TextField(newAttendeeLabel, text: $newAttendee)
                    Button(action: {
                        withAnimation {
                            scrumData.attendees.append(newAttendee)
                            newAttendee = ""
                        }
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel(Text("Add attendee"))
                    })
                    .disabled(newAttendee.isEmpty)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(scrumData: .constant(DailyScrum.data[0].data))
    }
}
