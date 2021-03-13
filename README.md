# SUITcase : SwiftUI Toolcase
SUITCase is a library for iOS, WatchOS and Mac Catalyst projects that use SwiftUI.  This library provide components that have been customized and that are not part of the basic SwiftUI native library. 


### Installation

SUITcase is available to install view Swift Package Manager (SPM). To add it to a current iOS project follow the next steps:

1. Using Xcode 11 or above, go to File > Swift Packages > Add Package Dependency
2. Select the target where SUITcase will be running.
3. Paste the project's URL: https://orahub.oci.oraclecorp.com/fmw-bimobile-dev/suitcase.git
4. Click next and select on "Rules" the "Branch" option and type "master" 
5. Review the product that will be generated and Finish the process.
6. Ensure that your package has been added correctly to the project.

## Usage

To start using SUITcase simply import the libary to the view where you want to apply it.

```swift
import UIToolbox
```

Once you import the library you can implement any of the components that have been created for you:

## Documentation

* [Buttons](#buttons)
* [Text Fields](#textfields)
* [Grids](#grids)
* [Bottom Sheets](#bottomsheets)
* [Spark Views](#sparkviews)
* [Representables](#representables)


## Buttons

- LargeButton

A Large rectangled button with cornered radius. It receives a generic view that will be drawn inside the button's content.

Init:

```swift
    /// Creates an instance
    /// - Parameters:
    ///   - action: The action to perform when self is triggered.
    ///   - label: A view that describes the effect of calling onTrigger.
    ///   - frame: a tuple that has a width and height parameter. by default the width is dynamic and the height is 50
    ///   - color: The background color (or border color if `style` is .bordered) of the rectangle. It is .blue by default.
    ///   - fontColor: The foreground color that will be given to the `Label` passed. It is .white by default.
    ///   - style:  the `ButtonStyle`  of the button. It is `.bordered` by default.
    public init(action: @escaping (() -> ()),
                @ViewBuilder label: () -> Label,
                frame: (width: CGFloat?, height: CGFloat?) = (width: nil, height: 50),
                color: Color = .blue,
                fontColor: Color = .white,
                style: ButtonStyle = .filled)
```

Large Button - Default:

```swift
LargeButton(action: {
    //Do Something                
}, label: {
    Text("Blue")
})
```

Large Button - Bordered:

```swift
LargeButton(action: {
    //Do Something
}, label: {
    Text("Bordered")
    }, color: .black,
    fontColor: .black,
    style: .bordered)
```

Large Button - Label With Symbol:

```swift
LargeButton(action: {
    //Do Something
}, label: {
    HStack {
        Image(systemName: "cart")
        Text("Buy")
    }
})
```

- Circled Button

A circled button that receives a generic view that will be drawn inside the button's content.

Init:

```swift
    /// Creates an instance
    /// - Parameters:
    ///   - action: The action to perform when self is triggered.
    ///   - label: A view that describes the effect of calling onTrigger.
    ///   - circleColor: The background color (or border color if `style` is .bordered) of the circle. It is .blue by default.
    ///   - fontColor: The foreground color that will be given to the `Label` passed. It is .white by default.
    ///   - shadowRadius: The shadow radius applied to the circle. It is 0 by default.
    ///   - style: the `ButtonStyle`  of the button. It is `.bordered` by default.
    public init(action: @escaping (() -> ()),
                @ViewBuilder label: () -> Label,
                circleColor: Color = .blue,
                fontColor: Color = .white,
                shadowRadius: CGFloat = 0,
                style: ButtonStyle = .filled)  
```

Default: 

```swift
CircleButton(action: {
    //Do Something            
}, label: {
    Text("Hello").foregroundColor(Color.white)
})
```

Bordered: 

```swift
CircleButton( action: {
    //Do Something
}, label: {
    Text("Yellow")
}, circleColor: .yellow, 
fontColor: .black,
style: .bordered)
```

Symbol Button:

```swift
CircleButton(action: {
    //Do Something
}, label: {
    VStack {
        Image(systemName: "mic").imageScale(.large)
        Text("Record").font(.callout)
    }
}, circleColor: .black)
```
## Textfields

- Form Textfield

A custom textfield that has a title and an optional info button. 

Init:

```swift
    /// Creates an instance
    /// - Parameters:
    ///   - text: The text to be displayed and edited.
    ///   - placeholder: The placeholder to be displayed and edited.
    ///   - textfieldTitle: The title that will be shown at the top of the current text field.
    ///   - dataType: A `DataType` enum indicating the data expected in the textfield.
    ///   - showInfo: Determines if an info button should be displayed to the right of the text field's title.
    ///   - keyboardType: The type of keyboard to display for a given text-based view.
    ///   - onCommit:  a block that is executed when the user taps on the `Done` key.
    ///   - infoActions: a block that will be executed when the info button is tapped.
    public init(text: Binding<String>,
                placeholder: String,
                textfieldTitle: String,
                dataType: DataType = .text,
                showInfo: Bool = false,
                keyboardType: UIKeyboardType = .default,
                onCommit: (() -> ())?,
                infoActions: (() -> ())?)
```

Default:

```swift
HStack {
    FormTextfield(text: .constant(""),
                  placeholder: "10 digit number",
                  textfieldTitle: "Phone",
                  dataType: .number,
                  showInfo: true,
                  keyboardType: .numberPad,
                  onCommit: {
                    //Do Something when "Return" key is typed    
                  }, infoActions: {
                    //Do Something
    }).padding()
}
```

- PasswordField

A custom Password textfield that can show/hide the typed password.

Init:

```swift
    /// Creates an instance
    /// - Parameters:
    ///   - text: The text that will be display and edited.
    ///   - placeholder: The place holder that will appear in the current text field
    ///   - showable: Determines if the "show password" button is going to appear.
    public init(text: Binding<String>,
         placeholder: String,
         showable: Bool = false)
```

Default:

```swift
    PasswordField(text: .constant("1234567890"), placeholder: "Password", showable: true)
```

## Grids

- Grid

A dynamic grid that can contain multiple generic `View` items

Init:

```swift
    /// Creates an instance
    /// - Parameters:
    ///   - items: an array of `Item` models that will be used to populate the grid
    ///   - id: The key path to the provided data’s identifier.
    ///   - viewForItem: a closure that returns an `Item` model that can be used to draw values in the `ItemView` generic view.
    public init(_ items: [Item], id: KeyPath<Item,ID>, viewForItem: @escaping (Item) -> ItemView)
```

Default:

```swift
Grid(Grid_Previews.images, id: \.self, viewForItem: { image in
                Image(systemName: image)
})
.frame(width: 200, height: 200)
```

## BottomSheets

- BottomSheet

A Partial View that will appear at the bottom of the screen. A generic `Content`view will be attached to the body.

Init

```swift
    /// - Parameters:
    ///   - isOpen: Determines if the sheet is partially or fully viewed.
    ///   - maxHeight: The maximum height that will be shown if `isOpen` is true
    ///   - presentedPortion: The minimum height that will be shown if `isOpen` is false
    ///   - showIndicator: Determines if a drag indicator should be shown at top. By default is set to `false`
    ///   - content: A Content that will be sent by the user and will be presented inside the current sheet
    ///   - backgroundColor: The backgrouind color of the sheet.
    public init(isOpen: Binding<Bool>,
         maxHeight: CGFloat,
         presentedPortion: CGFloat,
         showIndicator: Bool = false,
         @ViewBuilder content: () -> Content,
         backgroundColor: Color = Color(UIColor.systemBackground))
```

Default:

```swift
BottomSheet(isOpen: .constant(true),
            maxHeight: 400,
            presentedPortion: 0.3,
            showIndicator: true) {
                VStack {
                    HStack {
                        Text("Sample").padding()
                        Spacer()
                    }
                }
}
```

## SparkViews

- SparkView

A view that can be used to provide feedback to the user whenever a task finishes.

Init

```swift
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
                             height: CGFloat = 40)
```

Default:

```swift
SparkView(label: {
    HStack{
        Image(systemName: "xmark")
        Text("Error")
    }
},undoAction: nil, forError: true)
```

## Representables

- ActivityIndicator

A `UIViewReprentable` that will draw an activity indicator that is used to give user a feedback when something is loading in the background

Init:

```swift
    /// Creates an Activity Indicator instance.
    /// - Parameters:
    ///   - color: the color of tha activity indicator view
    ///   - style: A constant that specifies the style of the object to be created. by defailt it is set to `.large`
    public init(color: UIColor = UIColor.lightGray, style: UIActivityIndicatorView.Style = .large)
```

Default:

```swift
ActivityIndicator(color: .gray, style: .large)
```

- SearchBarView

A `UIViewReprentable` that will draw a Textfield that can be used in SwiftUI to have access to delegate methods.

Init:

```swift
    /// - Parameters:
    ///   - text: The text displayed and edited by the text field.
    ///   - placeholder: The string that is displayed when there is no other text in the text field.
    ///   - isOnFocus: A bool that indicates  if the current text field is focused.
    ///   - textfieldChangedHandler: a block that will be executed every time the text field changes it's value.
    ///   - onCommitHandler: a block that is executed when the user taps on the `Done` key.
    public init(text: Binding<String>,
                placeholder: Binding<String>,
                isOnFocus: Binding<Bool>,
                textfieldChangedHandler: ((String) -> Void)? = nil,
                onCommitHandler: (() -> Void)? = nil)
```

Default:

```swift
HStack {
     SearchBarView(text: .constant(""),
                   placeholder: .constant("Search for all"),
                   isOnFocus: .constant(false),
                   textfieldChangedHandler: { text in
                                
                   }, onCommitHandler: {
                    
                   }).padding()
}
    .clipped()
    .background(Color(UIColor.tertiarySystemBackground))
    .cornerRadius(10)
    .frame(width: 350, height: 40)
```

- TabBarWrapper

A Tab Bar Wrapper that enhances the power of the UIKit's UITabBar

Init:

```swift
    /// Creates an instance of UITabBar
    /// - Parameter elements: an array of generic views that contain the important information to build a UITabBarItem
    public init(_ elements: [TabBarElement])
```

Default:

```swift
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
            ])
```

- TextViewRepresentable

A `UIViewRepresentable` of UIKit's `UITextView` that can be used in SwiftUI.

```swift
    /// - Parameters:
    ///   - text: The  editable text displayed by the text view.
    ///   - font: The font of the text. System Font with 12 points of size as default.
    ///   - textColor: The color of the current text.
    ///   - background: The background color of the text view.
    ///   - isEditable: Determines if the text view is editable.
    ///   - attributedString: The styled text displayed by the text view.
    public init(text: Binding<String>,
                font: UIFont = UIFont.systemFont(ofSize: 12),
                textColor: UIColor = UIColor.label,
                background: UIColor = UIColor.systemBackground,
                isEditable: Bool = true,
                attributedString: NSAttributedString? = nil)
```

Default:

```swift
TextViewRepresentable(text: .constant("Lorem Ipsum"))
            .padding()
            .cornerRadius(2)
            .clipped()
            .shadow(radius: 2)
```

- WebView

A `UIViewRepresentable` of `WKWebView` that can be used in SwiftUI

Init:

```swift
    /// Creates an instance of `WKWebView`
    /// - Parameters:
    ///   - request: The request specifying the URL to navigate to.
    public init(request: URLRequest)
```

Default:

```swift
WebView(request: URLRequest(url: URL(string:"www.oracle.com")!))
```


## Contributing
See [CONTRIBUTING](./CONTRIBUTING.md) for details.


