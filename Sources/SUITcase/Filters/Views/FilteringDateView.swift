//
//  FilteringDateView.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 06/01/21.
//

import SwiftUI

public struct FilteringDateView<TopBar>: View where TopBar: View {
    @Binding var isOpen: Bool
    @Binding var startDate: Date
    @Binding var endDate: Date
    var startTitle: String
    var endTitle: String
    var maxHeight: CGFloat = 250
    var topBar: TopBar
    var primaryColor: Color = Color.primary
    
    public init(isOpen: Binding<Bool>,
                startDate: Binding<Date>,
                endDate: Binding<Date>,
                startTitle: String,
                endTitle: String,
                maxHeight: CGFloat = 250,
                @ViewBuilder topBar: () -> TopBar,
                primaryColor: Color = Color.primary) {
        _isOpen = isOpen
        _startDate = startDate
        _endDate = endDate
        self.maxHeight = maxHeight
        self.topBar = topBar()
        self.startTitle = startTitle
        self.endTitle = endTitle
        self.primaryColor = primaryColor
    }
    
    public var body: some View {
        BottomSheet(isOpen: $isOpen,
                    maxHeight: maxHeight,
                    presentedPortion: 0.3, content: {
            HStack {
                topBar
            }.padding()
            .foregroundColor(Color.primary)
            RangedCalendar(startingDate: $startDate,
                           endingDate: $endDate,
                           startingString: startTitle,
                           endingString: endTitle)
        }, draggable: false)
    }
}

struct FilteringDateView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringDateView(isOpen: .constant(true),
                          startDate: .constant(Date()),
                          endDate: .constant(Date()),
                          startTitle: "Start",
                          endTitle: "End",
                          maxHeight: 250,
                          topBar: {
                            HStack {
                                Button(action: {}, label: {
                                    Text("Back")
                                })
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Text("Calendar Date")
                                        .bold()
                                })
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Text("Apply")
                                })
                            }
                          }, primaryColor: Color.blue)
            .edgesIgnoringSafeArea(.bottom)
    }
}
