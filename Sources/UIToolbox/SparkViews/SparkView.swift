//
//  SparkView.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if !os(macOS)
public struct SparkView: View {
    var message: String
    var undoTitle: String
    var undoAction: (() -> ())?
    var forError = false
    var sparkColor: Color
    var errorColor: Color
    var height: CGFloat
    
    public init(message: String,
         undoTitle: String = "Undo",
         undoAction: (() -> ())? = nil,
         forError: Bool = false,
         sparkColor: Color = .blue,
         errorColor: Color = .red,
         height: CGFloat = 40) {
        self.message = message
        self.undoTitle = undoTitle
        self.undoAction = undoAction
        self.forError = forError
        self.sparkColor = sparkColor
        self.errorColor = errorColor
        self.height = height
    }
    
    public var body: some View {
        VStack {
            Spacer()
            VStack {
                Spacer()
                HStack {
                    Text(message).font(.body).padding(.leading, 20).foregroundColor(Color.white)
                    Spacer()
                    if undoAction != nil {
                        Button(action: {
                            self.undoAction!()
                        }, label: {
                            Text(self.undoTitle)
                        }).padding(.trailing, 10).foregroundColor(Color.white)
                    }
                }
                Spacer()
            }.background(forError ? errorColor : sparkColor)
                .frame(height: self.height)
                .padding(.bottom, 0)
                .transition(AnyTransition.opacity.combined(with: .offset(x: 0, y: UIDevice.currentDeviceHeight + 100)))
        }
    }
}

struct SparkView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                SparkView(message: "Success!", undoAction: nil)
            }
            
            VStack {
                SparkView(message: "Error",
                          undoAction: nil, forError: true)
            }
        }
    }
}
#endif
