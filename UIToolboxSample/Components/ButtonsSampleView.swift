//
//  ButtonsSampleView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import UIToolbox

struct ButtonsSampleView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                Group {
                    SectionHeaderView(name: "Large Round Cornered")
                    LargeButtonSection()
                    Divider()
                }
                Group {
                    SectionHeaderView(name: "Large with symbol")
                    LargeSymbolButtonSection()
                    Divider()
                }
                Group {
                    SectionHeaderView(name: "Circled")
                    CircledButtonSection()
                    Divider()
                }
                Group {
                    SectionHeaderView(name: "Circled with Symbol")
                    CircledSymbolButtonSection()
                }
            }
        }
    }
}

struct LargeButtonSection: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                HStack {
                    LargeButton(title: "Simple Button") {
                        
                    }
                    Spacer()
                }.padding()
                HStack {
                    LargeButton(title: "Red Button", color: .red) {
                        
                    }
                    Spacer()
                }.padding()
                HStack {
                    LargeButton(title: "Small",
                                frame: (width: 100, height: 50),
                                color: .green,
                                fontColor: .white) {
                        
                    }
                    Spacer()
                }.padding()
                HStack {
                    LargeButton(title: "Bordered",
                                frame: (width: 100, height: 50),
                                color: .green,
                                fontColor: .white,
                                style: .bordered) {
                        
                    }
                    Spacer()
                }.padding()
            }
        }
    }
}

struct LargeSymbolButtonSection: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                HStack {
                    LargeButton(title: "Username",
                                symbolName: "person",
                                frame: (width: nil, height: 50),
                                color: .orange,
                                fontColor: .white) {
                        
                    }
                    Spacer()
                }.padding()
                HStack {
                    LargeButton(title: "Password",
                                symbolName: "lock",
                                frame: (width: nil, height: 50),
                                color: Color.primary,
                                fontColor: Color(UIColor.systemBackground)) {
                        
                    }
                    Spacer()
                }.padding()
                HStack {
                    LargeButton(title: "Settings",
                                symbolName: "gear",
                                frame: (width: nil, height: 50),
                                color: .primary,
                                fontColor: Color(UIColor.systemBackground),
                                style: .bordered) {
                        
                    }
                    Spacer()
                }.padding()
            }
        }
    }
}

struct CircledSymbolButtonSection: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 30) {
                CircleButton(title: "",
                             symbol: "mic",
                             color: Color.red,
                             fontColor: Color.white,
                             style: .filled) {
                    
                }.frame(width: 100, height: 100)
                CircleButton(title: "",
                             symbol: "message",
                             color: Color.green,
                             fontColor: Color.white,
                             shadowRadius: 2,
                             style: .filled) {
                    
                }.frame(width: 100, height: 100)
                CircleButton(title: "",
                             symbol: "phone.fill",
                             color: Color.primary,
                             fontColor: Color.primary,
                             shadowRadius: 2,
                             style: .bordered) {
                    
                }.frame(width: 100, height: 100)
            }.padding()
        }
    }
}

struct CircledButtonSection: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 30) {
                CircleButton(title: "Simple") {
                    
                }.frame(width: 100, height: 100)
                CircleButton(title: "Green", color: .green, fontColor: .black) {
                    
                }.frame(width: 100, height: 100)
                CircleButton(title: "Shadowed",
                             color: Color.primary,
                             fontColor: Color(UIColor.systemBackground),
                             shadowRadius: 2) {
                    
                }.frame(width: 100, height: 100)
                CircleButton(title: "Bordered",
                             color: Color.blue,
                             fontColor: Color.blue,
                             shadowRadius: 2,
                             style: .bordered) {
                    
                }.frame(width: 100, height: 100)
            }.padding()
        }
    }
}

//struct ButtonsSampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ButtonsSampleView()
//                       .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
//                       .previewDisplayName("iPhone 11 Pro")
//            
//            
//            ButtonsSampleView()
//                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (2nd generation)"))
//                .previewDisplayName("iPhone SE (2nd generation)")
//            ButtonsSampleView()
//            .previewLayout(PreviewLayout.fixed(width: 1000, height: 500))
//            .previewDisplayName("iPhone SE (2nd generation)")
//                .background(Color.black)
//            .environment(\.colorScheme, .dark)
//            
//            ButtonsSampleView()
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
//            .previewDisplayName("iPhone SE (2nd generation)")
//        }
//    }
//}
