//
//  FilterSampleView.swift
//  SUITcaseSample
//
//  Created by Ernesto Sánchez Kuri on 06/01/21.
//

import SwiftUI
import SUITcase


class FiltersObject: ObservableObject {
    @Published var filters: [FilterElement] = []
    
    func populateFilters() {
        let measureRangeFilter = FilterMeasure(range: -100..<200,
                                               initialValue: 20,
                                               finalValue: 100, filter: FilterElement(filterId: "1",
                                                                                      type: .measure,
                                                                                      columnLabel: "Profit"))
        let revenueRangeFilter = FilterMeasure(range: 0..<300,
                                               initialValue: 10,
                                               finalValue: 300, filter: FilterElement(filterId: "2",
                                                                                      type: .measure,
                                                                                      columnLabel: "Revenue"))
        
        let dimensionListFilter = FilterDimension(elements: ["Ajax", "Juventus", "Liverpool", "Barcelona", "Manchester United", "Real Madrid", "Chelsea", "Roma"],
                                                  selected: [2, 3, 7],
                                                  filter: FilterElement(filterId: "3",
                                                                        type: .dimension,
                                                                        columnLabel: "Teams"))
        let dateFilter = FilterDateRange(initialDate: Date(),
                                         finalDate: Date().addingTimeInterval(10000000),
                                         filter: FilterElement(filterId: "4",
                                                               type: .measure,
                                                               columnLabel: "Date"))
        
        filters.append(contentsOf: [measureRangeFilter, revenueRangeFilter, dateFilter, dimensionListFilter])
    }
}

struct FilterSampleView: View {
    @State var filterType: Int = 0
    var elements: [String] = ["Ajax", "Juventus", "Liverpool", "Barcelona", "Manchester Unitedsdfsdfsdf s fsdf sdf sdfs d", "Real Madrid", "Chelsea", "Roma"]
    @State var selectedIndexes: [Int] = [0]
    @State var rangeType: RangeType = .inBetween
    var range: Range<Double> = 0..<100
    @State var minValue: Double = 25
    @State var maxValue: Double = 75
    @State var startDate: Date = Date()
    @State var endDate: Date = Date().addingTimeInterval(38000)
    @StateObject var filters: FiltersObject = FiltersObject()
    @State var showAllFilters = false
    
    var body: some View {
        VStack {
            Picker(selection: $filterType,
                   label: Text(""),
                   content: {
                Text("Dimension").tag(0)
                Text("Measure").tag(1)
                Text("Date").tag(2)
                Text("All").tag(3)
            }).pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 10)
                .padding(.vertical)
            
            ZStack {
                switch filterType {
                case 0:
                    drawFilterList()
                case 1:
                    drawMeasureFilterView()
                case 2:
                    drawDateFilterView()
                case 3:
                    VStack {
                        Spacer()
                        Button("Show All Filters") {
                            showAllFilters = true
                        }
                        Spacer()
                    }
                default:
                    Spacer()
                }
            }.edgesIgnoringSafeArea(.bottom)
        }.background(Color(UIColor.systemGroupedBackground))
        .sheet(isPresented: $showAllFilters, content: {
            drawAllFiltersView().onAppear {
                self.filters.populateFilters()
            }
        })
    }
    
    func drawFilterList() -> some View {
        return FilteringListView(elements: elements,
                                 selectedIndexes: $selectedIndexes,
                                 isOpen: .constant(true),
                                 topBar: {
                                    BottomSheetTopBar(leftTitle: "Back",
                                                      rightTitle: "Apply",
                                                      title: "Brand",
                                                      applyAction: {
                                                        
                                                      }, cancelAction: {
                                                        
                                                      })
                                 })
    }
    
    func drawAllFiltersView() -> some View {
        return FiltersFullScreenView(filters: $filters.filters,
                                     maxHeight: UIScreen.main.bounds.height - 100,
                                     topBar: {
                                       BottomSheetTopBar(leftTitle: "Back",
                                                         rightTitle: "Apply",
                                                         title: "Filters",
                                                         applyAction: {
                                                           
                                                         }, cancelAction: {
                                                           
                                                         })
                                     })
    }
    
    func drawMeasureFilterView() -> some View {
        return FilteringRangeView(isOpen: .constant(true),
                                  measureName: "Revenue",
                                  rangeType: rangeType,
                                  range: range,
                                  minValue: $minValue,
                                  maxValue: $maxValue, topBar: {
                                    BottomSheetTopBar(leftTitle: "Back",
                                                      rightTitle: "Apply",
                                                      title: "Revenue",
                                                      applyAction: {
                                                        
                                                      }, cancelAction: {
                                                        
                                                      })
                                  })
    }
    
    func drawDateFilterView() -> some View {
        return FilteringDateView(isOpen: .constant(true),
                                 startDate: $startDate,
                                 endDate: $endDate,
                                 startTitle: "Start",
                                 endTitle: "End",
                                 topBar: {
                                    BottomSheetTopBar(leftTitle: "Back",
                                                      rightTitle: "Apply",
                                                      title: "Calendar Date",
                                                      applyAction: {
                                                        
                                                      }, cancelAction: {
                                                        
                                                      })
                                 })
    }
}

struct FilterSampleView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSampleView()
    }
}
