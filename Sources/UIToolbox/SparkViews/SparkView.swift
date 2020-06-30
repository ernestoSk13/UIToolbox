//
//  SparkView.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if targetEnvironment(macCatalyst) || os(iOS)
/// A view that can be used to provide feedback to the user whenever a task finishes.
public struct SparkView<Label>: View where Label: View {
    var content: Label
    var undoTitle: String
    var undoAction: (() -> ())?
    var forError = false
    var sparkColor: Color
    var errorColor: Color
    var height: CGFloat
    
    /// Creates an instance
    /// - Parameters:
    ///   - label: A generic view used to show the message inside the spark.
    ///   - undoTitle: A String that will be set to a button at the right of the spark.
    ///   - undoAction: An action that will be executed when the undo button is tapped.
    ///   - forError: Determines if the spark is showing an error.
    ///   - sparkColor: The background color of the current spark.
    ///   - errorColor: The background color used for error messages.
    ///   - height: The height of the current spark.
    public init(@ViewBuilder label: () -> Label,
                             undoTitle: String = "Undo",
                             undoAction: (() -> ())? = nil,
                             forError: Bool = false,
                             sparkColor: Color = .blue,
                             errorColor: Color = .red,
                             height: CGFloat = 40) {
        self.content = label()
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
                    self.content.padding(.leading, 10).foregroundColor(Color.white)
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
        }
    }
}

struct SparkView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                SparkView(label: {
                    Text("Success!")
                }, undoAction: { })
            }
            
            VStack {
                SparkView(label: {
                    HStack{
                        Image(systemName: "xmark")
                        Text("Error")
                    }
                },undoAction: nil, forError: true)
            }
        }
    }
}
#endif
