//
//  NumericField.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 18/02/21.
//

import SwiftUI

struct NumericField: UIViewRepresentable {
    @Binding var text: String
    @Binding var numericValue: Double
    var placeholder: String
    @Binding var isEditing: Bool
    var isForRange: Bool = true
    var maxValue: Double?
    var minValue: Double?
    @Binding var isValid: Bool
    var isFirstResponder: Bool = false
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField(frame: .zero)
        textfield.text = text
        textfield.borderStyle = .roundedRect
        textfield.placeholder = placeholder
        textfield.layer.borderColor = UIColor.textfieldBorder.withAlphaComponent(0.5).cgColor
        textfield.layer.borderWidth = 1.0
        textfield.layer.cornerRadius = 4.0
        textfield.backgroundColor = UIColor.textfieldBackground
        textfield.keyboardType = .numberPad
        textfield.tintColor = UIColor.label
        textfield.delegate = context.coordinator
        textfield.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textfield
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: NumericField
        var didBecomeFirstResponder = false
        
        init(parent: NumericField) {
            self.parent = parent
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isEditing = true
            if !UIDevice.isIpad {
                createDoneToolbar(textField)
            }
        }
        
        func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
            let characterSet = CharacterSet(charactersIn: string)
            
            guard allowedCharacters.isSuperset(of: characterSet) else { return false }
            
            if var currentText = textField.text {
                if currentText.isEmpty && string == "." {
                    textField.text = "0."
                    return false
                } else if string.isEmpty {
                    _ = currentText.removeLast()
                    parent.text = currentText
                    textField.text = currentText
                }
            
                guard let nextValue = Double(currentText + string) else { return false }
                parent.text = currentText + string
                parent.numericValue = nextValue
                guard parent.isForRange else {
                    parent.minValue = nextValue
                    return true
                }
                if let minValue = parent.minValue  {
                    parent.isValid = nextValue >= minValue
                }
                
                if let maxValue = parent.maxValue {
                    parent.isValid = nextValue <= maxValue
                }
            }
            
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            
        }
        
        func createDoneToolbar(_ textfield: UITextField) {
            let toolbar = UIToolbar(frame: .zero)
            toolbar.barStyle = .default
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let dismissButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeKeyboard))
            toolbar.setItems([spacer, dismissButton], animated: false)
            toolbar.sizeToFit()
            textfield.inputAccessoryView = toolbar
        }
        
        @objc func closeKeyboard() {
            UIApplication.shared.endEditing()
            guard parent.isForRange else {
                if let topBottomValue = parent.minValue {
                    parent.text = "\(topBottomValue)"
                    parent.numericValue = topBottomValue
                }
                parent.isEditing = false
                return
            }
            
            if let minValue = parent.minValue, parent.numericValue < minValue {
                parent.text = "\(minValue)"
                parent.numericValue = minValue
            }
            
            if let maxValue = parent.maxValue, parent.numericValue > maxValue {
                parent.text = "\(maxValue)"
                parent.numericValue = maxValue
            }
            parent.isEditing = false
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isEditing = false
        }
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder && !isForRange {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

struct NumericField_Previews: PreviewProvider {
    static var previews: some View {
        NumericField(text: .constant(""),
                     numericValue: .constant(0.0),
                     placeholder: "123",
                     isEditing: .constant(false),
                     maxValue: 100,
                     isValid: .constant(true))
            .frame(width: nil, height: 60)
            .padding()
    }
}
