//
//  FiltersFullScreenView.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 13/01/21.
//

import SwiftUI

public struct FiltersFullScreenView<TopBar>: View where TopBar: View {
    @Binding var filters: [FilterElement]
    var maxHeight: CGFloat = 300
    var topBar: TopBar
    @State var textfieldFocused = false
    @State var topBottomText = ""
    @State var selectedIndex: RangeType = .inBetween
    @State var isValid = false
    
    public init(filters: Binding<[FilterElement]>,
                maxHeight: CGFloat,
                @ViewBuilder topBar: () -> TopBar) {
        _filters = filters
        self.topBar = topBar()
        self.maxHeight = maxHeight
        
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                ForEach(filters) { filter in
                    getFilterView(filter: filter).padding()
                    Divider()
                }
            }
            .padding(.bottom, 10)
            .navigationBarItems(leading: Button("Back") {
                
            }, trailing: Button("Apply") {
                
            })
            .navigationTitle(Text("Filters"))
        }
    }
    
    func getFilterView(filter: FilterElement) -> some View {
        switch filter {
        case let measureFilter as FilterMeasure:
            return AnyView(FilteringMeasureView(measureName: measureFilter.columnLabel,
                                                range: measureFilter.range,
                                                selectedIndex: $selectedIndex,
                                                minValue: .constant(measureFilter.initialValue ?? 0),
                                                maxValue: .constant(measureFilter.finalValue ?? 0),
                                                topBottomValue: $topBottomText,
                                                startedEditing: $textfieldFocused,
                                                isValid: $isValid))
        case let dimensionFilter as FilterDimension:
            return AnyView(FilteringDimensionFullView(title: dimensionFilter.columnLabel,
                                                      elements: dimensionFilter.elements,
                                                      selectedIndexes: .constant(dimensionFilter.selected),
                                                      textFieldFocused: $textfieldFocused))
        case let topBottomFilter as FilterTopBottomDimension:
            return AnyView(Text("topBottomFilter \(topBottomFilter.columnLabel)"))
        case let dateRangeFilter as FilterDateRange:
            return AnyView(RangedCalendar(startingDate: .constant(dateRangeFilter.initialDate ?? Date()),
                                          endingDate: .constant(dateRangeFilter.finalDate ?? Date()),
                                          startingString: "Start",
                                          endingString: "End"))
        case let relativeDateFilter as FilterRelativeDate:
            return AnyView(Text("Relative Date \(relativeDateFilter.columnLabel)"))
        default:
            return AnyView(Text("Unknown"))
        }
    }
}

struct FiltersFullScreenView_Previews: PreviewProvider {
    
    static var filters: [FilterElement] = [FilterMeasure(range: 0 ..< 200,
                                                         initialValue: 0,
                                                         finalValue: 100,
                                                         filter: FilterElement(filterId: "1",
                                                                               type: .measure,
                                                                               columnLabel: "Revenue")),
                                           FilterMeasure(range: -50 ..< 2000,
                                                         initialValue: -20,
                                                         finalValue: 1000,
                                                         filter: FilterElement(filterId: "2",
                                                                               type: .measure,
                                                                               columnLabel: "Profit")),
                                            FilterDimension(elements: ["Sony", "Mac", "Lenovo", "HP"],
                                                            selected: [0, 3],
                                                            filter: FilterElement(filterId: "3",
                                                                                  type: .dimension,
                                                                                  columnLabel: "Brand"))]
    
    static var previews: some View {
        FiltersFullScreenView(filters: .constant(FiltersFullScreenView_Previews.filters),
                              maxHeight: 700, topBar: {
                                BottomSheetTopBar(leftTitle: "Back",
                                                  rightTitle: "Apply",
                                                  title: "Filters",
                                                  applyAction: {
                                                    
                                                  }, cancelAction: {
                                                    
                                                  })
                              })
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
