//
//  GridSampleView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import UIToolbox

struct GridSampleView: View {
    let images: [String] = ["thermometer", "cloud.moon.bolt.fill", "sunrise.fill",
    "sun.max", "moon.fill", "cloud.rain",
    "cloud.bolt.fill", "tornado", "hurricane"]
    
    let flags = ["🏳️", "🇺🇳", "🇦🇫", "🇨🇲", "🇨🇳", "🇨🇷", "🏳️‍🌈", "🏁", "🇦🇶", "🇧🇷",
                "🇨🇰", "🇧🇹", "🇦🇹", "🇯🇵", "🇬🇼", "🇲🇪", "🇻🇳", "🇵🇹", "🇲🇰", "🇱🇧", "🇲🇽", "🇾🇹", "🇲🇵", "🇳🇪", "🇽🇰", "🇱🇦"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                SectionHeaderView(name: "3x3 Grid")
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        Grid(images, id: \.self, viewForItem: { imageName in
                            Image(systemName: imageName)
                            }).frame(width: 200, height: 200)
                    }.padding()
                }
                Divider()
                SectionHeaderView(name: "2x2 Grid")
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        Grid(Array(images[0...3]), id: \.self, viewForItem: { imageName in
                            Image(systemName: imageName)
                            }).frame(width: 150, height: 150)
                    }.padding()
                }
                Divider()
                SectionHeaderView(name: "Dynamic Grid")
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        Grid(flags, id: \.self, viewForItem: { imageName in
                            Text(imageName).font(.body)
                        }).frame(width: UIDevice.currentDeviceWidth - 50, height: 300).padding(.horizontal, 20)
                    }.padding()
                }
            }
        }
    }
}

struct GridSampleView_Previews: PreviewProvider {
    static var previews: some View {
        GridSampleView()
    }
}
