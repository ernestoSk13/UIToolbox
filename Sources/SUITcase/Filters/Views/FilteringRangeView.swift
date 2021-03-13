//
//  FilteringRangeView.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 06/01/21.
//

import SwiftUI

public enum RangeType: Int {
    case bottom = 0
    case inBetween
    case top
}

public struct FilteringRangeView<TopBar>: View where TopBar: View {
    @Binding var isOpen: Bool
    var measureName: String
    var range: Range<Double>
    @Binding var minValue: Double
    @Binding var maxValue: Double
    var maxHeight: CGFloat = 400
    var topBar: TopBar
    var primaryColor: UIColor = UIColor.systemBlue
    @State var selectedIndex: RangeType = .inBetween
    @State var topBottomText = ""
    @State var editing: Bool = false
    @State var isValid = false
    
    public init(isOpen: Binding<Bool>,
                measureName: String,
                rangeType: RangeType,
                range: Range<Double>,
                minValue: Binding<Double>,
                maxValue: Binding<Double>,
                maxHeight: CGFloat = 400,
                @ViewBuilder topBar: () -> TopBar,
                primaryColor: UIColor = UIColor.systemBlue) {
        _isOpen = isOpen
        self.measureName = measureName
        self.range = range
        _maxValue = maxValue
        _minValue = minValue
        self.maxHeight = maxHeight
        self.topBar = topBar()
        self.primaryColor = primaryColor
    }
    
    public var body: some View {
        BottomSheet(isOpen: $isOpen,
                    maxHeight: editing ? 600 : 280,
                    presentedPortion: 0.1,
                    content: {
                        HStack {
                            topBar
                        }.padding()
                        .foregroundColor(Color.primary)
                        FilteringMeasureView(measureName: measureName,
                                             range: range,
                                             selectedIndex: $selectedIndex,
                                             minValue: $minValue,
                                             maxValue: $maxValue,
                                             topBottomValue: $topBottomText,
                                             startedEditing: $editing,
                                             primaryColor: primaryColor,
                                             isValid: $isValid)
                    }, draggable: false)
    }
    
    func getValueForRangeType() -> String {
        if selectedIndex.rawValue == 1 {
            return "\(minValue.formatNumber()) <-> \(maxValue.formatNumber())"
        } else {
            return "\(maxValue.formatNumber())"
        }
    }
}

public struct FilteringMeasureView: View {
    var measureName: String
    var range: Range<Double>
    @Binding var minValue: Double
    @Binding var maxValue: Double
    var primaryColor: UIColor = UIColor.systemBlue
    @Binding var selectedIndex: RangeType
    var bottomTitle: String
    var inBetweenTitle: String
    var topTitle: String
    var countTitle: String
    @Binding var topBottomValue: String
    @Binding var startedEditing: Bool
    @State var minValueText = ""
    @State var maxValueText = ""
    @State var moving = false
    @State var editRange: Bool = false
    @Binding var isValid: Bool
    
    public init(measureName: String,
                range: Range<Double>,
                selectedIndex:  Binding<RangeType>,
                minValue: Binding<Double>,
                maxValue: Binding<Double>,
                topBottomValue: Binding<String>,
                startedEditing: Binding<Bool>,
                primaryColor: UIColor = UIColor.systemBlue,
                bottomTitle: String = "Bottom",
                inBetweenTitle: String = "In Between",
                topTitle: String = "Top",
                countTitle: String = "Count",
                isValid: Binding<Bool>) {
        self.measureName = measureName
        self.range = range
        _selectedIndex = selectedIndex
        _maxValue = maxValue
        _minValue = minValue
        _isValid = isValid
        _minValueText = State(initialValue: "\(minValue.wrappedValue)")
        _maxValueText = State(initialValue: "\(maxValue.wrappedValue)")
        _topBottomValue = topBottomValue
        _startedEditing = startedEditing
        self.primaryColor = primaryColor
        self.bottomTitle = bottomTitle
        self.inBetweenTitle = inBetweenTitle
        self.topTitle = topTitle
        self.countTitle = countTitle
    }
    
    public var body: some View {
        VStack {
            if selectedIndex != .inBetween {
                Picker(selection: $selectedIndex,
                       label: Text(""),
                       content: {
                        Text(bottomTitle)
                            .caption(font: "OracleSans-Regular")
                            .tag(RangeType.bottom)
                        Text(topTitle)
                            .caption(font: "OracleSans-Regular")
                            .tag(RangeType.top)
                }).pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 10)
                    .padding(.vertical)
            }
            VStack {
                HStack {
                    if selectedIndex != .inBetween {
                        Text(countTitle)
                            .body(font: "OracleSans-Bold")
                            .padding(.leading)
                        Spacer()
                        NumericField(text: $topBottomValue,
                                     numericValue: $minValue,
                                     placeholder: "\(10)",
                                     isEditing: $startedEditing,
                                     isForRange: false,
                                     maxValue: nil,
                                     minValue: nil,
                                     isValid: $isValid,
                                     isFirstResponder: true)
                            .frame(width: 80)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .padding(.trailing)
                            .padding(.vertical).onDisappear {
                                startedEditing = false
                            }
                    } else {
                        HStack {
                            HStack {
                                if !startedEditing {
                                    Button(action: {
                                        minValueText = "\(range.lowerBound)"
                                        minValue = range.lowerBound
                                    }, label: {
                                        Text("Start")
                                            .body(font: "OracleSans-Regular")
                                            .frame(width: 60, height: 40)
                                    })
                                    .foregroundColor(Color(UIColor.buttonColor))
                                    Spacer()
                                }
                                ZStack {
                                    HStack {
                                        Text("Start")
                                            .caption(font: "OracleSans-Regular")
                                            .offset(x: 0, y: startedEditing ? -30 : 0)
                                            .transition(.move(edge: .bottom))
                                        Spacer()
                                    }
                                    NumericField(text: $minValueText,
                                                 numericValue: $minValue,
                                                 placeholder: "\(minValue)",
                                                 isEditing: $startedEditing,
                                                 maxValue: maxValue.roundToPlaces(2),
                                                 minValue: range.lowerBound.roundToPlaces(2),
                                                 isValid: $isValid)
                                }
                            }
                            HStack {
                                if !startedEditing {
                                    Button(action: {
                                        maxValueText = "\(range.upperBound)"
                                        maxValue = range.upperBound
                                    }, label: {
                                        Text("End")
                                            .body(font: "OracleSans-Regular")
                                            .frame(width: 60, height: 40)
                                    })
                                    .foregroundColor(Color(UIColor.buttonColor))
                                    Spacer()
                                }
                                ZStack {
                                    HStack {
                                        Text("End")
                                            .caption(font: "OracleSans-Regular")
                                            .offset(x: 0, y: startedEditing ? -30 : 0)
                                            .transition(.move(edge: .bottom))
                                        Spacer()
                                    }
                                    NumericField(text: $maxValueText,
                                                 numericValue: $maxValue,
                                                 placeholder: "\(maxValue)",
                                                 isEditing: $startedEditing,
                                                 maxValue: range.upperBound.roundToPlaces(2),
                                                 minValue: minValue.roundToPlaces(2),
                                                 isValid: $isValid)
                                }
                            }.padding(.horizontal)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .keyboardType(.decimalPad)
                        .onAppear {
                            minValueText = "\(minValue)"
                            maxValueText = "\(maxValue)"
                        }
                    }
                }.padding(startedEditing ? .all : .vertical).frame(height: 50)
                if selectedIndex == .inBetween {
                    RangeSlider(measureName:measureName,
                                range: range,
                                minValue: $minValue,
                                maxValue: $maxValue,
                                minText: $minValueText,
                                maxText: $maxValueText,
                                selectedColor: UIColor.buttonColor,
                                moving: $moving,
                                editing: $editRange)
                        .padding(.horizontal)
                }
            }.frame(height: selectedIndex == .inBetween ? 120 : 40)
            .padding(.top, 10)
        }.padding(.bottom)
    }
    
    func getValueForRangeType() -> String {
        let value1 = Double.convertNumberWithNotation(number: minValue, decimals: true)
        let value2 = Double.convertNumberWithNotation(number: maxValue, decimals: true)
        if selectedIndex == .inBetween {
            return "\(value1) ⇿ \(value2)"
        } else {
            return "\(value1)"
        }
    }
}

struct FilteringRangeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FilteringRangeView(isOpen: .constant(true),
                               measureName: "Target Revenue",
                               rangeType: .top,
                               range: 0..<100,
                               minValue: .constant(25),
                               maxValue: .constant(75),
                               topBar: {
                                HStack {
                                    Button(action: {}, label: {
                                        Text("Back")
                                    })
                                    Spacer()
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Text("Filter by Measure")
                                            .bold()
                                    })
                                    Spacer()
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Text("Apply")
                                    })
                                }
                               }).edgesIgnoringSafeArea(.bottom)
            FilteringRangeView(isOpen: .constant(true),
                               measureName: "Target Revenue",
                               rangeType: .top,
                               range: 0..<10000,
                               minValue: .constant(3500),
                               maxValue: .constant(7500),
                               topBar: {
                                HStack {
                                    Button(action: {}, label: {
                                        Text("Back")
                                    })
                                    Spacer()
                                    Button(action: {}, label: {
                                        Text("Filter by Measure")
                                            .bold()
                                    })
                                    Spacer()
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Text("Apply")
                                    })
                                }
                               }).edgesIgnoringSafeArea(.bottom)
            RangeSampleView()
        }
    }
}



struct RangeSampleView: View {
    @State var minValue: Double = 1000.0
    @State var maxValue: Double = 5000.0
    
    var body: some View {
        FilteringRangeView(isOpen: .constant(true),
                           measureName: "Target Revenue",
                           rangeType: .bottom,
                           range: 0..<10000,
                           minValue: $minValue,
                           maxValue: $maxValue,
                           topBar: {
                            HStack {
                                Button(action: {}, label: {
                                    Text("Back")
                                })
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Text("Filter by Measure")
                                        .bold()
                                })
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Text("Apply")
                                })
                            }
                           }).edgesIgnoringSafeArea(.bottom)
    }
}
