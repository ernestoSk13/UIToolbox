//
//  BottomSheetTopBar.swift
//  SUITcaseSample
//
//  Created by Ernesto Sánchez Kuri on 06/01/21.
//

import SwiftUI

public struct BottomSheetTopBar: View {
    var leftTitle: String
    var rightTitle: String
    var title: String
    var applyAction: (() -> ())
    var cancelAction: (() -> ())
    var buttonColor: Color = Color.accentColor
    var isEnabled: Bool = true
    
    public init(leftTitle: String,
                rightTitle: String,
                title: String,
                applyAction: @escaping (() -> ()),
                cancelAction: @escaping (() -> ()),
                buttonColor: Color = Color.accentColor,
                isEnabled: Bool = true) {
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        self.title = title
        self.applyAction = applyAction
        self.cancelAction = cancelAction
        self.buttonColor = buttonColor
        self.isEnabled = isEnabled
    }
    
    public var body: some View {
        HStack {
            Button(action: {
                cancelAction()
            }, label: {
                Text(leftTitle)
                    .body(font: "OracleSans-Regular")
            }).foregroundColor(buttonColor)
            Spacer()
            Text(title)
                .body(font: "OracleSans-Bold")
                .foregroundColor(Color.primary)
            Spacer()
            Button(action: {
                applyAction()
            }, label: {
                Text(rightTitle)
                    .body(font: "OracleSans-Regular")
            }).foregroundColor(isEnabled ? buttonColor : Color("lightGray"))
            .disabled(!isEnabled)
        }
    }
}

struct BottomSheetTopBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetTopBar(leftTitle: "Back",
                          rightTitle: "Apply",
                          title: "Brand",
                          applyAction: {
                            
                          }, cancelAction: {
                            
                          })
    }
}
