//
//  ViewController.swift
//  Calculator
//
//  Created by Dimitar Dinev on 2.04.21.
//

import UIKit

enum Operation: String {
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case NoOperation = "NoOperation"
}

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation: Operation = .NoOperation
    var operationNames = ["+", "-"]

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "0"
    }
    
    func changeBackground(_ sender: UIButton) {
        if sender.titleLabel?.text == "\(sender.tag)" {
            UIView.animate(withDuration: 1) {
                sender.backgroundColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
                sender.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            }
        }
    }
    
    @IBAction func changeGrayOperatorBackground(_ sender: UIButton) {
        UIView.animate(withDuration: 1) {
            sender.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            sender.backgroundColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        }
    }
    
    @IBAction func changeOrangeOperatorBackground(_ sender: UIButton) {
        sender.setTitleColor(UIColor(red: 241/255, green: 163/255, blue: 60/255, alpha: 1), for: .focused)
        sender.backgroundColor = sender.isFocused ? .white : UIColor(red: 241/255, green: 163/255, blue: 60/255, alpha: 1)
    }
    
    @IBAction func numPressed(_ sender: UIButton) {
        runningNumber += "\(sender.tag)"
        label.text = runningNumber
        changeBackground(sender)
    }
    
    @IBAction func clear(_ sender: UIButton) {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .NoOperation
        label.text = "0"
    }
    
    @IBAction func separator(_ sender: UIButton) {
        runningNumber += "."
        label.text = runningNumber
    }
    
    @IBAction func equals(_ sender: UIButton) {
        operation(operation: currentOperation)
    }
    
    @IBAction func plus(_ sender: UIButton) {
        operation(operation: .Add)
    }
    
    @IBAction func minus(_ sender: UIButton) {
        operation(operation: .Subtract)
    }
    
    @IBAction func multiply(_ sender: UIButton) {
        operation(operation: .Multiply)
    }
    
    @IBAction func divide(_ sender: UIButton) {
        operation(operation: .Divide)
    }
    
    func operation(operation: Operation) {
        if currentOperation == .NoOperation {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
            return
        }
        
        if runningNumber != "" {
            rightValue = runningNumber
            runningNumber = ""
            
            switch currentOperation {
            case .Add:
                result = "\(Double(leftValue)! + Double(rightValue)!)"
            case .Subtract:
                result = "\(Double(leftValue)! - Double(rightValue)!)"
            case .Multiply:
                result = "\(Double(leftValue)! * Double(rightValue)!)"
            case .Divide:
                result = "\(Double(leftValue)! / Double(rightValue)!)"
            default:
                result = ""
            }
            leftValue = result
            label.text = result
        }
        currentOperation = operation
    }
}
