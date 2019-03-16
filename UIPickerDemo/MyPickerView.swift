//
//  MyPickerView.swift
//  UIPickerDemo
//
//  Created by Saurav on 2/13/19.
//  Copyright © 2019 Saurav. All rights reserved.
//

import UIKit

protocol MyPickerDelegate : class {
    func getHeight(heightInFeet:Int,heightIninch:Int)
    func getWeight(weight:Int)
}

//To make optional
extension MyPickerDelegate {
    
    func getHeight(heightInFeet:Int,heightIninch:Int) {
        
    }
    func getWeight(weight:Int) {
        
    }
}

//Class....

class MyPickerView: UIView {
    
    //MARK:- Variables......
     private let feetArray:[Int] = [1,2,3,4,5,6,7,8,9]
     private let inchArray:[Int] = [0,1,2,3,4,5,6,7,8,9,10,11]
     private var weightArray:[Int] = []
    
     var delegate:MyPickerDelegate?
     var heightPicker:Bool = false
    
     //For Height....
     var selectedHeightInFeet:Int?
     var selectedHeightInInch:Int?
    
     private var selectedRowForHeightInFeet:Int = 0
     private var selectedRowForHeightInInche:Int = 0
    
     //For Weight.....
     var selectedWeight:Int?
     private var selectedRowForWeight:Int = 0
    
    //MARK:- @IBOutlets....
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    //MARK:- App life cycle...
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        if(weightArray.isEmpty) {
            weightArray = getWeightArr()
        }
    }
    
    public func intializer() {
        pickerView.reloadAllComponents()
        if (heightPicker) {
            getRowForHeight()
        } else {
             getRowForWeight()
        }
    }
    
    private func getRowForHeight() {
        
        if (selectedHeightInFeet != nil && feetArray.contains(selectedHeightInFeet!)) {
            selectedRowForHeightInFeet = feetArray.firstIndex(of: selectedHeightInFeet!)!
            pickerView.selectRow(selectedRowForHeightInFeet, inComponent: 0, animated: true)
        }
        
        if (selectedHeightInInch != nil && inchArray.contains(selectedHeightInInch!)) {
            selectedRowForHeightInInche = inchArray.firstIndex(of: selectedHeightInInch!)!
            pickerView.selectRow(selectedRowForHeightInInche, inComponent: 1, animated: true)
        }
    }
    
    private func getRowForWeight() {
        if(selectedWeight != nil) {
            selectedRowForWeight = weightArray.firstIndex(of: selectedWeight!)!
            pickerView.selectRow(selectedRowForWeight, inComponent: 0, animated: true)
        }
    }
    
    //MARK:- @IBAction methods.....
    
    @IBAction func removeButton(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    @IBAction func doneButton(_ sender: UIButton) {
        if(heightPicker) {
            if(selectedHeightInFeet == nil) {
              selectedHeightInFeet = feetArray.first
            }
            if(selectedHeightInInch == nil) {
              selectedHeightInInch = inchArray.first
            }
            delegate?.getHeight(heightInFeet: selectedHeightInFeet!, heightIninch: selectedHeightInInch!)
        } else {
            if (selectedWeight == nil) {
                selectedWeight = weightArray.first
            }
          delegate?.getWeight(weight: selectedWeight!)
        }
        self.removeFromSuperview()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
       self.removeFromSuperview()
    }
    
    //MARK:- Custom Methods....
    //This function will return weight arr
    
    private func getWeightArr() ->[Int] {
        var tempArr:[Int] = []
        var startValue = 50
        for _ in 1...250 {
          tempArr.append(startValue)
            startValue += 1
        }
        return tempArr
    }
    
}//

//MARK:- Extension.....

//MARK:- UIPickerView Data Source Methods.....
extension MyPickerView: UIPickerViewDataSource{
    //Component means Column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if (heightPicker) { //Because height conatins feet and incehs
            return 2
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (heightPicker) {
            if (component == 0) {
                return feetArray.count
            } else {
                return inchArray.count
            }
        } else {
            return weightArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (heightPicker) {
            if (component == 0) {
                return "\(feetArray[row]) feet"
            } else {
                 return "\(inchArray[row]) inch"
            }
        } else {
            return "\(weightArray[row]) lbs"
        }
    }
}

//MARK:- UIPickerView Delegate Methods.....
extension MyPickerView: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (heightPicker) { //For Height
            if(component == 0) {
                selectedHeightInFeet = feetArray[row]
            } else {
                selectedHeightInInch = inchArray[row]
            }
        } else { //For Weight
            selectedWeight = weightArray[row]
        }
    }
    
}//Extension.....
