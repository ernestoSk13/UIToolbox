//
//  TabBarWrapper.swift
//  Regicide-UI
//
//  Created by Ernesto Sánchez Kuri on 20/05/20.
//  Copyright © 2020 Oracle America. All rights reserved.
//

import SwiftUI
#if !os(macOS)
public struct TabBarWrapper: View {
    var controllers: [UIHostingController<TabBarElement>]
    
    public init(_ elements: [TabBarElement]) {
        self.controllers = elements.enumerated().map {
            let hostingController = UIHostingController(rootView: $1)
            
            hostingController.tabBarItem = UITabBarItem(title: $1.tabBarElementItem.title,
                                                        image: $1.tabBarElementItem.systemIcon ? UIImage(systemName: $1.tabBarElementItem.iconName) : UIImage(named: $1.tabBarElementItem.iconName),
                                                        tag: $0
            )
            
            hostingController.tabBarItem.accessibilityLabel = $1.tabBarElementItem.accessibilityLabel
            hostingController.tabBarItem.accessibilityValue = $1.tabBarElementItem.accessibilityValue
            hostingController.tabBarItem.accessibilityIdentifier = $1.tabBarElementItem.accessibilityIdentifier
            
            return hostingController
        }
    }
    
    public var body: some View {
        TabbarControllerWrapper(viewControllers: self.controllers)
    }
}

fileprivate struct TabbarControllerWrapper: UIViewControllerRepresentable {
    var viewControllers: [UIViewController]
    
    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = UIColor.label
        return tabBar
    }
    
    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        uiViewController.setViewControllers(self.viewControllers, animated: true)
    }
    
    typealias UIViewControllerType = UITabBarController
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: TabbarControllerWrapper
        
        init(_ controller: TabbarControllerWrapper) {
            self.parent = controller
        }
    }
}

public struct TabBarElementItem {
    var title: String
    var systemIcon = true
    var iconName: String
    var accessibilityLabel: String
    var accessibilityValue: String?
    var accessibilityIdentifier: String
}

protocol TabBarElementView: View {
    associatedtype Content
    
    var content: Content { get set }
    var tabBarElementItem: TabBarElementItem { get set }
}

public struct TabBarElement: TabBarElementView {
    internal var content: AnyView
    
    var tabBarElementItem: TabBarElementItem
    
    public init<Content: View>(tabBarElementItem: TabBarElementItem, @ViewBuilder _ content: () -> Content) {
        self.tabBarElementItem = tabBarElementItem
        self.content = AnyView(content())
    }
    
    public var body: some View { self.content }
}



struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBarWrapper([
                TabBarElement(tabBarElementItem: .init(title: "Agenda",
                                                       iconName: "book",
                                                       accessibilityLabel: "Agenda",
                                                       accessibilityIdentifier: "tab-agenda"), {
                                                        Text("1")
                }),
                TabBarElement(tabBarElementItem: .init(title: "Configuración",
                                                       iconName: "gear",
                                                       accessibilityLabel: "Configuracion",
                                                       accessibilityIdentifier: "tab-settings"), {
                                                        Text("2")
                })
            ]).previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            
            TabBarWrapper([
                TabBarElement(tabBarElementItem: .init(title: "Agenda",
                                                       iconName: "book",
                                                       accessibilityLabel: "Agenda",
                                                       accessibilityIdentifier: "tab-agenda"), {
                                                        Text("1")
                }),
                TabBarElement(tabBarElementItem: .init(title: "Configuración",
                                                       iconName: "gear",
                                                       accessibilityLabel: "Configuracion",
                                                       accessibilityIdentifier: "tab-settings"), {
                                                        Text("2")
                })
            ]).previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif