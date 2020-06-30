//
//  UTBProgressView.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 27/06/20.
//

import SwiftUI

#if targetEnvironment(macCatalyst) || os(iOS)
struct UTBProgressView: View {
    var backgroundColor: Color
    
    init(backgroundColor: Color = .blue) {
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(backgroundColor)
        }.frame(width: nil, height: 20)
        
    }
}

struct UTBProgressView_Previews: PreviewProvider {
    static var previews: some View {
        UTBProgressView()
            .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
