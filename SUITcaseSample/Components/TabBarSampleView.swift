//
//  TabBarSampleView.swift
//  SUITcaseSample
//
//  Created by Ernesto Sánchez Kuri on 13/08/20.
//

import SwiftUI
import SUITcase

struct TabBarSampleView: View {
    var body: some View {
        ZStack {
            TabBarWrapper([
                TabBarElement(tabBarElementItem: .init(title: "Home",
                                                       iconName: "house.fill",
                                                       accessibilityLabel: "Agenda",
                                                       accessibilityIdentifier: "tab-agenda"), {
                                                        Text("Home")
                }),
                TabBarElement(tabBarElementItem: .init(title: "Settings",
                                                       iconName: "gear",
                                                       accessibilityLabel: "Settings",
                                                       accessibilityIdentifier: "tab-settings"), {
                                                        Text("Settings")
                })
            ])
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct TabBarSampleView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarSampleView()
    }
}
