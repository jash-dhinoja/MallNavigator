//
//  UITextFieldExtension.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 30/03/2021.
//

import UIKit

extension UITextField{
    
    //MARK: Basic Formatting
    func UIConfiguration(placeHolder holder: String = ""){
        placeholder = holder
        layer.cornerRadius = frame.height/2
        borderStyle = .none
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.7
    }
    
    //MARK: Date Picker
    /// Pop up Date Picker for the UITextField
    func datePicker<T>(target: T,doneAction: Selector,cancelAction: Selector,datePickerMode: UIDatePicker.Mode = .date,minDate: Date, maxDate: Date? = nil) {
        let screenWidth = UIScreen.main.bounds.width
        
        //For button
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            
            return barButtonItem
        }
        
        //Date Picker
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = datePickerMode
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate != nil ? maxDate : nil
        self.inputView = datePicker
        
        //Toolbar Code
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
    
    //MARK: Right Icon View
    ///Add an image to the right view of the TextField
    func addRightImageView(imageName: String){
        let someView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: frame.height))
        let imageView = UIImageView(image: UIImage(systemName: imageName))
        imageView.frame = CGRect(x: 6, y: 0, width: 24, height: someView.frame.height)
        imageView.contentMode = .scaleAspectFit
        someView.tintColor = .systemGray
        someView.addSubview(imageView)
        rightView = someView
        rightViewMode = .always
    }
}
