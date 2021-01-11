//
//  MeetingFooterVIew.swift
//  swiftui-scrumdinger
//
//  Created by Vlad Stanescu on 08.01.2021.
//

import SwiftUI

struct MeetingFooterVIew: View {
    @Binding var speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        
        return index + 1
    }
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    // MARK: - Localized Strings
    private let lastSpeakerText: LocalizedStringKey = "lastSpeaker"
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text(lastSpeakerText)
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction, label: {
                        Image(systemName: "forward.fill")
                    })
                    .accessibilityLabel(Text("Next speaker"))
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterVIew_Previews: PreviewProvider {
    static var speakers = [
        ScrumTimer.Speaker(name: "Vlad", isCompleted: false),
        ScrumTimer.Speaker(name: "John", isCompleted: false)
    ]
    static var previews: some View {
        MeetingFooterVIew(speakers: .constant(speakers), skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
