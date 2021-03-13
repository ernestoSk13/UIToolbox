//
//  FilteringRelativeDateView.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 27/01/21.
//
import SwiftUI

public struct FilteringRelativeDateView: View {
    @Binding var rangeType: FilterDateRangeType
    @Binding var numberOfPeriods: String
    @Binding var dateRelativeToType: String
    @Binding var timeLevel: FilterRelativeDateTimeLevel
    @Binding var startedEditing: Bool
    var editable = false
    var titles: [String: String] = ["rangeTitle": "Range Type",
                                   "last": "Last",
                                   "next": "Next",
                                   "toDate": "To Date",
                                   "increment": "Increment",
                                   "timeLevel": "Time Level",
                                   "day": "Day",
                                   "week": "Week",
                                   "month": "Month",
                                   "quarter": "Quarter",
                                   "year": "Year",
                                   "relativeTo": "Relative To"]
    
    public init(rangeType:  Binding<FilterDateRangeType>,
                numberOfPeriods: Binding<String>,
                dateRelativeToType: Binding<String>,
                timeLevel: Binding<FilterRelativeDateTimeLevel>,
                titles: [String: String] = ["rangeTitle": "Range Type",
                                            "last": "Last",
                                            "next": "Next",
                                            "toDate": "To Date",
                                            "increment": "Increment",
                                            "timeLevel": "Time Level",
                                            "day": "Day",
                                            "week": "Week",
                                            "month": "Month",
                                            "quarter": "Quarter",
                                            "year": "Year",
                                            "relativeTo": "Relative To"],
                editable: Bool = false,
                startedEditing: Binding<Bool>) {
        _rangeType = rangeType
        _numberOfPeriods = numberOfPeriods
        _dateRelativeToType = dateRelativeToType
        _timeLevel = timeLevel
        _startedEditing = startedEditing
        self.titles = titles
        self.editable = editable
    }
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(titles["rangeTitle"] ?? "")
                        .body(font: "OracleSans-Regular")
                    Spacer()
                    if editable {
                        Picker(selection: $rangeType,
                               label: Text(selectedRangeType), content: {
                                Text(titles["last"] ?? "").tag(FilterDateRangeType.last)
                                Text(titles["next"] ?? "").tag(FilterDateRangeType.next)
                                Text(titles["toDate"] ?? "").tag(FilterDateRangeType.periodOfDate)
                               }).pickerStyle(MenuPickerStyle())
                            .body(font: "OracleSans-Regular")
                            .frame(width: 80)
                    } else {
                        Text(selectedRangeType)
                            .body(font: "OracleSans-Regular")
                            .frame(width: 80).multilineTextAlignment(.trailing)
                    }
                }
                Divider()
                if rangeType != .periodOfDate {
                    HStack {
                        Text(titles["increment"] ?? "")
                            .body(font: "OracleSans-Regular")
                        Spacer()
                        TextField("0", text: $numberOfPeriods, onEditingChanged: { editing in
                            withAnimation(.easeInOut) {
                                startedEditing = editing
                            }
                          })
                            .body(font: "OracleSans-Regular")
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .frame(maxWidth: 80)
                            .multilineTextAlignment(.center)
                    }
                    Divider()
                }
                HStack {
                    Text(titles["timeLevel"] ?? "")
                        .body(font: "OracleSans-Regular")
                    Spacer()
                    if editable {
                        Picker(selection: $timeLevel,
                               label: Text(selectedTime), content: {
                                Text(titles["day"] ?? "").tag(FilterRelativeDateTimeLevel.day)
                                Text(titles["month"] ?? "").tag(FilterRelativeDateTimeLevel.month)
                                Text(titles["quarter"] ?? "").tag(FilterRelativeDateTimeLevel.quarter)
                                Text(titles["week"] ?? "").tag(FilterRelativeDateTimeLevel.week)
                                Text(titles["year"] ?? "").tag(FilterRelativeDateTimeLevel.year)
                        })
                            .body(font: "OracleSans-Regular")
                            .pickerStyle(MenuPickerStyle())
                            .frame(width: 80)
                    } else {
                        Text(selectedTime)
                            .body(font: "OracleSans-Regular")
                            .frame(width: 80)
                            .multilineTextAlignment(.trailing)
                    }
                }
                Divider()
                HStack {
                    Text(titles["relativeTo"] ?? "")
                        .body(font: "OracleSans-Regular")
                    Spacer()
                    Text(dateRelativeToType)
                        .body(font: "OracleSans-Regular")
                        .frame(width: 80).multilineTextAlignment(.trailing)
                }
            }
        }
        .gesture(DragGesture().onChanged{ _ in
            UIApplication.shared.endEditing()
        })
        .padding(.horizontal)
        .padding(.top)
    }
    
    var selectedTime: String {
        switch timeLevel {
        case .day:
            return titles["day"] ?? ""
        case .month:
            return titles["month"] ?? ""
        case .quarter:
            return titles["quarter"] ?? ""
        case .week:
            return titles["week"] ?? ""
        case .year:
            return titles["year"] ?? ""
        }
    }
    
    var selectedRangeType: String {
        switch rangeType {
        case .last:
            return titles["last"] ?? ""
        case .next:
            return titles["next"] ?? ""
        case .periodOfDate:
            return titles["toDate"] ?? ""
        }
    }
}

struct FilteringRelativeDateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BottomSheet(isOpen: .constant(true),
                        maxHeight: 400,
                        presentedPortion: 0.5, content:  {
                            FilteringRelativeDateView(rangeType: .constant(.last),
                                                      numberOfPeriods: .constant("7"),
                                                      dateRelativeToType: .constant("Today"),
                                                      timeLevel: .constant(.year), startedEditing: .constant(false))
                        }, draggable: false)
        }
    }
}
