//
//  ContentView.swift
//  SUITcaseSample
//
//  Created by Ernesto Sánchez Kuri on 06/07/20.
//

import SwiftUI
import SUITcase

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
                        }.listStyle(GroupedListStyle())
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
        case .activityIndicators:
            return AnyView(ActivityIndicatorSampleView())
        case .bottomSheet:
            return AnyView(BottomSheetSampleView())
        case .button:
            return AnyView(ButtonsSampleView())
        case .textfield:
            return AnyView(TextfieldSampleView())
        case .filters:
            return AnyView(FilterSampleView())
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
        case .progressBar:
            return AnyView(ProgressSampleView())
        case .progressRings:
            return AnyView(ProgressRingSampleView())
        case .tabBar:
            return AnyView(TabBarSampleView())
        case .sliders:
            return AnyView(SliderSampleView())
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

