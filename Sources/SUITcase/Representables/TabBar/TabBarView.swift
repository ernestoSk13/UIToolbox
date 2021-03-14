//
//  TabBarWrapper.swift
//  Regicide-UI
//
//  Created by Ernesto Sánchez Kuri on 20/05/20.
//  Copyright © 2020 Oracle America. All rights reserved.
//

import SwiftUI
#if targetEnvironment(macCatalyst) || os(iOS)
/// A Tab Bar Wrapper that enhances the power of the UIKit's UITabBar
public struct TabBarWrapper: View {
    var controllers: [UIHostingController<TabBarElement>]
    var color: UIColor = UIColor.label
    
    /// Creates an instance of UITabBar
    /// - Parameter elements: an array of generic views that contain the important information to build a UITabBarItem
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
        TabbarControllerWrapper(viewControllers: self.controllers, color: color)
    }
}

/// A `UIViewControllerRepresentable` of UITabBarController tha can be used by SwiftUI.
fileprivate struct TabbarControllerWrapper: UIViewControllerRepresentable {
    var viewControllers: [UIViewController]
    var color: UIColor = UIColor.label
    
    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = color
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

/// A model that has the properties needed by `TabBarElement` to build a TabBarItem
public struct TabBarElementItem {
    public var title: String
    public var systemIcon = true
    public var iconName: String
    public var accessibilityLabel: String
    public var accessibilityValue: String?
    public var accessibilityIdentifier: String
    
    public init(title: String,
         systemIcon: Bool = true,
         iconName: String,
         accessibilityLabel: String,
         accessibilityValue: String? = nil,
         accessibilityIdentifier: String) {
        self.title = title
        self.systemIcon = systemIcon
        self.iconName = iconName
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityValue = accessibilityValue
        self.accessibilityIdentifier = accessibilityIdentifier
    }
}

/// A protocol that represents a Tab View
protocol TabBarElementView: View {
    associatedtype Content
    
    var content: Content { get set }
    var tabBarElementItem: TabBarElementItem { get set }
}

/// A view that implements the `TabBarElementView` protocol and that will be used to build a UITabBarView
public struct TabBarElement: TabBarElementView {
    internal var content: AnyView
    
    var tabBarElementItem: TabBarElementItem
    
    /// Creates an instance
    /// - Parameters:
    ///   - tabBarElementItem: an element that contains the needed information to build a tab.
    ///   - content: a generic `Content` view that will be used to represent the content of the tab.
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
                TabBarElement(tabBarElementItem: .init(title: "Settings",
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
