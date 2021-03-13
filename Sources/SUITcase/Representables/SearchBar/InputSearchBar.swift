//
//  InputSearchBar.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 14/01/21.
//

import SwiftUI

class CollectionDifferences: ObservableObject {
    var collectionValues: [String] = []
}

struct InputSearchBar: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    @Environment(\.colorScheme) var colorScheme
    @Binding var isOnFocus: Bool
    var elements: [String]
    @Binding var selected: [Int]
    @StateObject var collectionDifferences = CollectionDifferences()
    var textfieldChangedHandler: ((String) -> Void)?
    var onCommitHandler: (() -> Void)?
    
    /// Creates an instance of UIKit's `UITextField`
    /// - Parameters:
    ///   - text: The text displayed and edited by the text field.
    ///   - placeholder: The string that is displayed when there is no other text in the text field.
    ///   - isOnFocus: A bool that indicates  if the current text field is focused.
    ///   - textfieldChangedHandler: a block that will be executed every time the text field changes it's value.
    ///   - onCommitHandler: a block that is executed when the user taps on the `Done` key.
    public init(text: Binding<String>,
         placeholder: String,
         elements: [String],
         selected: Binding<[Int]>,
         isOnFocus: Binding<Bool>,
         textfieldChangedHandler: ((String) -> Void)? = nil,
         onCommitHandler: (() -> Void)? = nil) {
        _text = text
        _selected = selected
        self.placeholder = placeholder
        _isOnFocus = isOnFocus
        self.elements = elements
        self.textfieldChangedHandler = textfieldChangedHandler
        self.onCommitHandler = onCommitHandler
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, text: $text, isOnFocus: $isOnFocus, textfieldChangedHandler: textfieldChangedHandler)
    }
    public func makeUIView(context: Context) -> UITextField {
        let searchBar = UITextField(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        searchBar.inputAccessoryView?.isUserInteractionEnabled = true
        searchBar.autocorrectionType = .no
        searchBar.isAccessibilityElement = true
        searchBar.returnKeyType = .done
        searchBar.accessibilityTraits = .searchField
        searchBar.accessibilityLabel = placeholder
        searchBar.accessibilityValue = text
        searchBar.borderStyle = .roundedRect
        searchBar.backgroundColor = UIColor.systemBackground
        let selectedElements: [String] = self.selected.map { elements[$0] }
        let filtered = elements.filter { !selectedElements.contains($0) }
        collectionDifferences.collectionValues = filtered
        let collection = context.coordinator.inputCollectionView()
        collection.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        searchBar.inputAccessoryView = collection
        return searchBar
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.textColor = (self.colorScheme == .dark) ? UIColor.white : UIColor.label
        uiView.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                          attributes: [NSAttributedString.Key.foregroundColor
                                                            : UIColor.systemGray])
        let selectedElements: [String] = self.selected.map { elements[$0] }
        let filtered = elements.filter { !selectedElements.contains($0) }
        collectionDifferences.collectionValues = filtered
        if let inputCollection = uiView.inputAccessoryView as? UICollectionView {
            inputCollection.reloadData()
        }
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
        var parent: InputSearchBar
        @Binding var text: String
        @Binding var isOnFocus: Bool
        var textfieldChangedHandler: ((String) -> Void)?
        var onCommitHandler: (() -> Void)?
        var textFieldReference: UITextField?
        
        public init(parent: InputSearchBar,
                    text: Binding<String>,
                    isOnFocus: Binding<Bool>,
                    textfieldChangedHandler: ((String) -> Void)?) {
            self.parent = parent
            _text = text
            _isOnFocus = isOnFocus
            self.textfieldChangedHandler = textfieldChangedHandler
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            isOnFocus = true
        }
        
        func addInputAccessoryView(_ textField: UITextField) {
            textFieldReference = textField
            let inputView = UIInputView(frame: CGRect.zero, inputViewStyle: .keyboard)
            let collection = inputCollectionView()
            inputView.autoresizingMask = [.flexibleWidth,
                                          .flexibleBottomMargin,
                                          .flexibleLeftMargin,
                                          .flexibleRightMargin]
            inputView.addSubview(collection)
            textField.inputAccessoryView = inputView
            UIView.performWithoutAnimation {
                textField.reloadInputViews()
            }
        }
        
        func inputCollectionView() -> UICollectionView {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.estimatedItemSize = CGSize(width: 200, height: 60)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
            let itemCollectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0,
                                                                                      y: 0,
                                                                                      width: UIScreen.main.bounds.width,
                                                                                      height: 60),
                                                                        collectionViewLayout: self.layout())

            itemCollectionView.dataSource = self
            itemCollectionView.delegate = self
            itemCollectionView.register(ElementCollectionViewCell.self, forCellWithReuseIdentifier: "elementCell")
            itemCollectionView.backgroundColor = UIColor.secondarySystemBackground
            return itemCollectionView
        }
        
        func layout() -> UICollectionViewCompositionalLayout {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .estimated(150),
                heightDimension: .estimated(30)
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize, subitem: item, count: 1
            )
            group.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                leading: nil, top: .flexible(0),
                trailing: nil, bottom: .flexible(10)
            )
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.scrollDirection = .horizontal
            let layout = UICollectionViewCompositionalLayout(
                section: section, configuration: config
            )
            return layout
        }

        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return parent.collectionDifferences.collectionValues.count
        }
        
        
        public func collectionView(_ collectionView: UICollectionView,
                                   cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "elementCell",
                                                                for: indexPath) as? ElementCollectionViewCell else {
                fatalError()
            }
            let element = parent.collectionDifferences.collectionValues[indexPath.row]
            cell.setCellWithElement(element)
            return cell
        }
        
        public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let element = parent.collectionDifferences.collectionValues[indexPath.row]
            guard let index = parent.elements.firstIndex(where: { (value) -> Bool in
                return value == element
            }) else {
                return
            }
            parent.collectionDifferences.collectionValues.remove(at: indexPath.row)
            parent.selected.append(index)
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            isOnFocus = false
            textField.resignFirstResponder()
            return true
        }

        public func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
            if let currentValue = textField.text as NSString? {
                let proposedValue = currentValue.replacingCharacters(in: range, with: string)
                textfieldChangedHandler?(proposedValue as String)
                DispatchQueue.init(label: "textfield", qos: .userInteractive).async {
                    self.text = proposedValue
                }
                let selectedElements: [String] = self.parent.selected.map { self.parent.elements[$0] }
                let filtered = parent.elements.filter { !selectedElements.contains($0) }
                DispatchQueue.main.async {
                    self.parent.collectionDifferences.collectionValues = filtered.filter { element in
                        guard self.parent.text.count > 0 else { return true }
                        return element.lowercased().contains(self.parent.text)
                    }
                }
            }
            return true
        }

        public func textFieldDidEndEditing(_ textField: UITextField) {
            isOnFocus = false
            onCommitHandler?()
        }
    }
}

class ElementCollectionViewCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var separator: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.label
        return view
    }()
    
    override init(frame _: CGRect) {
        let defaultFrame = CGRect(x: 0, y: 0, width: 120, height: 60)
        super.init(frame: defaultFrame)
        addLabel()
        addSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLabel() {
        addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func addSeparator() {
        addSubview(separator)
        separator.widthAnchor.constraint(equalToConstant: 0.33).isActive = true
        separator.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
    func setCellWithElement(_ element: String) {
        titleLabel.text = element
        layoutIfNeeded()
    }
}
