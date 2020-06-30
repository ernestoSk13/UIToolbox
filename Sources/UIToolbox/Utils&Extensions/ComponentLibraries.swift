//
//  ComponentLibraries.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 27/06/20.
//

import SwiftUI

#if targetEnvironment(macCatalyst) || os(iOS)
@available(iOS 14.0, *)
public struct ButtonLibrary: LibraryContentProvider {
    @LibraryContentBuilder
    public var views: [LibraryItem] {
        LibraryItem(
            LargeButton(action: {
                
            }, label: {
                Text("Press here")
            }), category: .control
        )
        
        LibraryItem(
            LargeButton(action: {
                
            }, label: {
                HStack {
                    Image(systemName: "person")
                    Text("User").padding(.leading, 10)
                }
            })
            , title: "Large Button with Symbol"
            , category: .control
        )
        
        LibraryItem(
            LargeButton(action: {
                
            }, label: {
                Text("Press here")
            }, style: .bordered)
            , title: "Large Button with Border"
            , category: .control
        )
        
        LibraryItem(
            CircleButton(action: {
                
            }, label: {
                Text("Press Here").foregroundColor(Color.white)
            }), category: .control
        )
        
        LibraryItem(
            CircleButton(action: {
                
            }, label: {
                VStack {
                    Image(systemName: "person")
                    Text("User").foregroundColor(Color.white)
                }
            }),
            title: "Cirlce Button with symbol",
            category: .control
        )
        
        LibraryItem(
            CircleButton(action: {
                
            }, label: {
                VStack {
                    Image(systemName: "person")
                    Text("User").foregroundColor(Color.white)
                }
            }, style: .bordered),title: "Circle Button with border",
            category: .control
        )
    }
}

@available(OSX 10.16, *)
@available(iOS 14.0, *)
public struct TextfieldLibrary: LibraryContentProvider {
    @LibraryContentBuilder
    public var views: [LibraryItem] {
        LibraryItem(
            FormTextfield(text: .constant(""),
                          placeholder: "Username",
                          textfieldTitle: "Username",
                          onCommit: {},
                          infoActions: {}),
            title: "Form Textfield - Default",
            category: .control
        )
        
        LibraryItem(
            FormTextfield(text: .constant(""),
                          placeholder: "",
                          textfieldTitle: "Phone number",
                          dataType: .number,
                          showInfo: false,
                          keyboardType: UIKeyboardType.phonePad,
                          onCommit: {}, infoActions: {}),
            title: "Form Textfield - Phone",
            category: .control
        )
        
        LibraryItem(
            FormTextfield(text: .constant(""),
                          placeholder: "",
                          textfieldTitle: "Email",
                          dataType: .email,
                          showInfo: false,
                          keyboardType: UIKeyboardType.emailAddress,
                          onCommit: {}, infoActions: {}),
            title: "Form Textfield - Email",
            category: .control
        )
        
        LibraryItem(
            PasswordField(text: .constant(""), placeholder: "Enter your password")
            ,
            title: "Password Field - Default",
            category: .control
        )
        
        LibraryItem(
            PasswordField(text: .constant(""), placeholder: "Enter your password", showable: true)
            ,
            title: "Password Field - Show Button",
            category: .control
        )
    }
}


@available(OSX 10.16, *)
@available(iOS 14.0, *)
public struct SparkViewLibrary: LibraryContentProvider {
    @LibraryContentBuilder
    public var views: [LibraryItem] {
        LibraryItem(
            SparkView(label: {
                Text("Success")
            }),
            title: "Spark View - Default",
            category: .control
        )
        
        LibraryItem(
            SparkView(label: {
                Text("Error")
            }, forError: true),
            title: "Spark View - Error",
            category: .control
        )
        
        LibraryItem(
            SparkView(label: {
                Text("Downloading")
            }, undoTitle: "Undo", undoAction: { },
            sparkColor: .blue),
            title: "Spark View - Undo Action",
            category: .control
        )
    }
}

@available(OSX 10.16, *)
@available(iOS 14.0, *)
public struct GridViewsLibrary: LibraryContentProvider {
    @LibraryContentBuilder
    public var views: [LibraryItem] {
        LibraryItem(
            Grid(["1", "2", "3"], id: \.self, viewForItem: { sample in
                Text(sample)
            }),
            title: "Grid - Default",
            category: .control
        )
        
        LibraryItem(
            Grid(["1", "2", "3", "4", "5", "6"], id: \.self, viewForItem: { sample in
                Text(sample)
            }).background(Color(UIColor.systemBackground))
            .padding()
            .frame(width: 150, height: 150),
            title: "Grid - squared",
            category: .control
        )
    }
}


@available(OSX 10.16, *)
@available(iOS 14.0, *)
public struct BottomSheetLibrary: LibraryContentProvider {
    @LibraryContentBuilder
    public var views: [LibraryItem] {
        LibraryItem(
            BottomSheet(isOpen: .constant(false),
                        maxHeight: UIDevice.currentDeviceHeight,
                        presentedPortion: 0.3,
                        content: {
                            VStack {
                                Text("Awesome bottomsheet")
                            }
                        }),
            title: "Bottom Sheet - closed",
            category: .control
        )
        
        LibraryItem(
            BottomSheet(isOpen: .constant(true),
                        maxHeight: UIDevice.currentDeviceHeight,
                        presentedPortion: 0.3,
                        content: {
                            VStack {
                                Text("Awesome bottomsheet")
                            }
                        }),
            title: "Bottom Sheet - open",
            category: .control
        )
    }
}

@available(OSX 10.16, *)
@available(iOS 14.0, *)
public struct RepresentableLibrary: LibraryContentProvider {
    @LibraryContentBuilder
    public var views: [LibraryItem] {
        LibraryItem(
            ActivityIndicator(),
            title: "Activity Indicator - Default",
            category: .control
        )
        
        LibraryItem(
            ActivityIndicator(color: .gray, style: .large),
            title: "Activity Indicator - Large Gray",
            category: .control
        )
        
        LibraryItem(
            HStack {
                SearchBarView(text: .constant(""),
                              placeholder: .constant("Search for all"),
                              isOnFocus: .constant(false),
                              textfieldChangedHandler: { text in
                                
                }, onCommitHandler: {
                    
                }).padding()
            }
            .clipped()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .frame(width: 350, height: 40)
            .padding()
            .shadow(radius: 2),
            title: "Search bar - Default",
            category: .control
        )
        
        LibraryItem(
            TextViewRepresentable(text: .constant("Sample")),
            title: "Activity Indicator - Large Gray",
            category: .control
        )
        
        LibraryItem(
            WebView(request: URLRequest(url: URL(string: "")!)),
            title: "Web View - Default",
            category: .control
        )
        
        LibraryItem(
            TabBarWrapper([
                TabBarElement(tabBarElementItem: .init(title: "Home",
                                                       iconName: "house.fill",
                                                       accessibilityLabel: "Home",
                                                       accessibilityIdentifier: "tab-home"), {
                                                        Text("Home")
                }),
                TabBarElement(tabBarElementItem: .init(title: "Favorites",
                                                       iconName: "star.fill",
                                                       accessibilityLabel: "favorites",
                                                       accessibilityIdentifier: "tab-favorites"), {
                                                        Text("Favorites")
                }),
                TabBarElement(tabBarElementItem: .init(title: "Settings",
                                                       iconName: "gear",
                                                       accessibilityLabel: "settings",
                                                       accessibilityIdentifier: "tab-settings"), {
                                                        Text("Settings")
                })
            ])
            ,
            title: "Tab Bar View - Default",
            category: .control
        )
    }
}
#endif
