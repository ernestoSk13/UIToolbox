//
//  RangedCalendar.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 06/01/21.
//

import SwiftUI

public struct RangedCalendar: View {
    @Binding var startingDate: Date
    @Binding var endingDate: Date
    var startingString: String
    var endingString: String
    var dateRange: ClosedRange<Date>?
    @State var currentSelection: Int = 0
    
    public init(startingDate: Binding<Date>,
                endingDate: Binding<Date>,
                startingString: String,
                endingString: String,
                dateRange: ClosedRange<Date>? = nil) {
        _startingDate = startingDate
        _endingDate = endingDate
        self.startingString = startingString
        self.endingString = endingString
        self.dateRange = dateRange
    }
    
    public var body: some View {
        VStack {
            Picker(selection: $currentSelection,
                   label: Text(""), content: {
                Text(startingString).tag(0)
                Text(endingString).tag(1)
                   })
                .caption(font: "OracleSans-Regular")
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            DatePicker(currentSelection == 0 ? startingString : endingString,
                       selection: currentSelection == 0 ? $startingDate : $endingDate,
                       in: dateRange ?? startingDate...Date(),
                       displayedComponents: .date)
                .body(font: "OracleSans-Regular")
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
        }
    }
}

struct RangedCalendar_Previews: PreviewProvider {
    static var previews: some View {
        RangedCalendar(startingDate: .constant(Date())
                       , endingDate: .constant(Date()),
                       startingString: "Start",
                       endingString: "End")
    }
}
