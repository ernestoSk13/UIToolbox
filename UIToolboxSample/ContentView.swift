//
//  ContentView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 25/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import UIToolbox

struct ContentView: View {
    var body: some View {
        ZStack {
            if UIDevice.isIpad {
                IpadContentView()
            } else {
                NavigationView {
                    VStack {
                        List(ComponentTypes.allCases, id: \.rawValue) { component in
                            NavigationLink(destination: DetailView(component: component),
                                           label: {
                                            Text(component.rawValue).padding()
                            })
                        }
                    }
                .navigationBarTitle("UIToolbox")
                }
            }
        }
    }
}

struct IpadContentView: View {
    @State private var selectedComponent: ComponentTypes = .button
    
    var body: some View {
        NavigationView {
            List(ComponentTypes.allCases, id: \.rawValue) { component in
                NavigationLink(destination: DetailView(component: component),
                               label: {
                                Text(component.rawValue).padding()
                })
            }.navigationBarTitle("Components")
            DetailView(component: selectedComponent)
        }
    }
}

struct DetailView: View {
    var component: ComponentTypes
    
    var body: some View {
        VStack {
            componentView
                .navigationBarTitle(component.rawValue)
        }
    }
    
    var componentView: AnyView {
        switch self.component {
        case .button:
            return AnyView(ButtonsSampleView())
        case .textfield:
            return AnyView(TextfieldSampleView())
        case .collectionView:
            return AnyView(GridSampleView())
        case .textView:
            return AnyView(TextViewSampleView())
        case .searchBar:
            return AnyView(SearchBarSampleView())
        case .spark:
            return AnyView(SparkSampleView())
        case .webView:
            return AnyView(WebSampleView())
        default:
            return AnyView(Text("Coming Soon").font(.headline))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.sizeThatFits)
    }
}
