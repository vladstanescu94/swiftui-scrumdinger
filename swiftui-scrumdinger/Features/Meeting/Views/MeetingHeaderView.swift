//
//  MeetingHeaderView.swift
//  swiftui-scrumdinger
//
//  Created by Vlad Stanescu on 08.01.2021.
//

import SwiftUI

struct MeetingHeaderView: View {
    @Binding var secondsElapsed: Int
    @Binding var secondsRemaining: Int
    private var progress: Double {
        guard secondsRemaining > 0 else { return 1 }
        let totalSeconds = Double(secondsElapsed + secondsRemaining)
        
        return Double(secondsElapsed) / totalSeconds
    }
    
    let scrumColor: Color
    
    // MARK: - accessibility data
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    private var minutesRemainingMetric : String {
        minutesRemaining == 1 ? "minute" : "minutes"
    }
    
    // MARK: - Localized Strings
    private let secondsElapsedText: LocalizedStringKey = "secondsElapsed"
    private let secondsRemainingText: LocalizedStringKey = "secondsRemaining"

    
    // MARK: - View
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(scrumColor: scrumColor))
            HStack {
                VStack(alignment: .leading) {
                    Text(secondsElapsedText)
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(secondsRemainingText)
                        .font(.caption)
                    HStack {
                        Text("\(secondsRemaining)")
                        Image(systemName: "hourglass.tophalf.fill")
                    }
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Time remaining"))
        .accessibilityValue(Text("\(minutesRemaining) \(minutesRemainingMetric)"))
        .padding([.top, .horizontal])
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: .constant(60), secondsRemaining: .constant(180), scrumColor: DailyScrum.data[0].color)
            .previewLayout(.sizeThatFits)
    }
}
