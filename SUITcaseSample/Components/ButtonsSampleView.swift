//
//  ButtonsSampleView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import SUITcase

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
                    LargeButton(action: {
                        
                    }, label: {
                        Text("Simple Button")
                    })
                    Spacer()
                }.padding()
                HStack {
                    LargeButton(action: {
                        
                    }, label: {
                        Text("Red")
                    })
                    Spacer()
                }.padding()
                HStack {
                    LargeButton(action: {
                        
                    }, label: {
                        Text("Small")
                    }, frame: (width: 70, height: 50),
                       color: .green, fontColor: .white)
                    Spacer()
                }.padding()
                HStack {
                    LargeButton(action: {
                        
                    }, label: {
                        Text("Bordered")
                    }, style: .bordered)
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
                    LargeButton(action: {
                        
                    }, label: {
                        HStack {
                            Image(systemName: "person")
                            Text("Username").padding(.leading, 10)
                        }
                    })
                    Spacer()
                }.padding()
                HStack {
                    LargeButton(action: {
                        
                    }, label: {
                        HStack {
                            Image(systemName: "lock")
                            Text("Password")
                        }.foregroundColor(.white)
                    }, color: Color.primary)
                    Spacer()
                }.padding()
                HStack {
                    LargeButton(action: {
                        
                    }, label: {
                        HStack {
                            Image(systemName: "gear")
                            Text("Settings").padding(.leading, 10)
                        }.foregroundColor(Color(UIColor.systemBackground))
                    }, color: Color.primary, style: .bordered)
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
                CircleButton(action: {
                    
                }, label: {
                    Image(systemName: "mic")
                }).frame(width: 100, height: 100)
                CircleButton(action: {
                    
                }, label: {
                    VStack {
                        Image(systemName: "message")
                        Text("Messages")
                    }
                    }).frame(width: 100, height: 100)
                CircleButton(action: {
                    
                }, label: {
                    Image(systemName: "phone.fill")
                }, circleColor: .green, fontColor: .white, style: .bordered)
                .frame(width: 100, height: 100)
            }.padding()
        }
    }
}

struct CircledButtonSection: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 30) {
                CircleButton(action: {
                    
                }, label: {
                    Text("Simple")
                    }).frame(width: 100, height: 100)
                CircleButton(action: {
                    
                }, label: {
                    Text("Green")
                }, circleColor: .green, fontColor: .white)
                .frame(width: 100, height: 100)
                CircleButton(action: {
                    
                }, label: {
                    Text("Shadowed")
                }, circleColor: .primary, fontColor: Color(UIColor.systemBackground), shadowRadius: 2)
                .frame(width: 100, height: 100)
                CircleButton(action: {
                    
                }, label: {
                    Text("Bordered")
                }, circleColor: .blue, fontColor: .blue, shadowRadius: 2, style: .bordered)
                .frame(width: 100, height: 100)
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
