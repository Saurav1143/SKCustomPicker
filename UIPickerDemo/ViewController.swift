//
//  ViewController.swift
//  UIPickerDemo
//
//  Created by Saurav on 2/13/19.
//  Copyright © 2019 Saurav. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,MyPickerDelegate {

    var selectedHeightInFeet:Int?
    var selectedHeightInInch:Int?
    var selectedWeight:Int?
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
 
    func getHeight(heightInFeet: Int, heightIninch: Int) {
        selectedHeightInFeet = heightInFeet
        selectedHeightInInch = heightIninch
        heightTextField.text = "\(selectedHeightInFeet!) feet \(selectedHeightInInch!) inch"
    }
    func getWeight(weight: Int) {
        selectedWeight = weight
        weightTextField.text = "\(selectedWeight!) lbs"
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == weightTextField) {
            let picker = UIPickerManager()
            picker.delegate = self
            if(selectedWeight != nil) {
                picker.selectedWeight = selectedWeight
            }
            picker.addPickerView()
        } else {
            let picker = UIPickerManager()
            picker.openHeightPicker = true
            picker.delegate = self
            if(selectedHeightInFeet != nil){
               picker.selectedHeightInFeet = selectedHeightInFeet
            }
            if (selectedHeightInInch != nil) {
                picker.selectedHeightInInch = selectedHeightInInch
            }
            picker.addPickerView()
        }
        
    }
    
    
}

