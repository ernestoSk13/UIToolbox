//
//  BottomSheetSampleView.swift
//  SUITcaseSample
//
//  Created by Ernesto Sánchez Kuri on 13/08/20.
//

import SwiftUI
import SUITcase

struct BottomSheetSampleView: View {
    @State var opened: Bool = false
    @State var maxSize: CGFloat = 0.45
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.opened = true
                        self.maxSize = 0.75
                    }, label: {
                        Text("Large")
                    })
                    Spacer()
                    Button(action: {
                        self.opened = true
                        self.maxSize = 0.6
                    }, label: {
                        Text("Medium")
                    })
                    Spacer()
                    Button(action: {
                        self.opened = true
                        self.maxSize = 0.45
                    }, label: {
                        Text("Small")
                    })
                    Spacer()
                }.padding()
                Spacer()
            }
            BottomSheet(isOpen: self.$opened,
                        cornered: true,
                        maxHeight: UIDevice.currentDeviceHeight * self.maxSize,
                        presentedPortion: 0.1,
                        showIndicator: true, content: {
                            VStack {
                                HStack {
                                    Text("Drag or tap the button to open this.")
                                    Spacer()
                                    Button(action: {
                                        self.opened.toggle()
                                    }, label: {
                                        Image(systemName: self.opened ? "chevron.down" : "chevron.up")
                                    })
                                }.padding()
                                if self.opened {
                                    Image("surprise").resizable().scaledToFit().padding()
                                }
                            }
            }, backgroundColor: Color(UIColor.tertiarySystemBackground))
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomSheetSampleView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetSampleView()
    }
}
