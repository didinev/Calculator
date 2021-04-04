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
    
    var runningNumer = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation: Operation = .NoOperation

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "0"
    }
    
    @IBAction func numPressed(_ sender: UIButton) {
        if runningNumer.count < 9 {
            runningNumer += "\(sender.tag)"
            label.text = runningNumer
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        runningNumer = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .NoOperation
        label.text = "0"
    }
    
    @IBAction func separator(_ sender: UIButton) {
        if runningNumer.count < 8 {
            runningNumer += "."
            label.text = runningNumer
        }
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
        if currentOperation != .NoOperation {
            if runningNumer != "" {
                rightValue = runningNumer
                runningNumer = ""
                
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
//                if currentOperation == .Add {
//                    result = "\(Double(leftValue)! + Double(rightValue)!)"
//                } else if currentOperation == .Subtract {
//                    result = "\(Double(leftValue)! - Double(rightValue)!)"
//                } else if currentOperation == .Multiply {
//                    result = "\(Double(leftValue)! * Double(rightValue)!)"
//                } else if currentOperation == .Divide {
//                    result = "\(Double(leftValue)! / Double(rightValue)!)"
//                }
                leftValue = result
                label.text = result
            }
            currentOperation = operation
        } else {
            leftValue = runningNumer
            runningNumer = ""
            currentOperation = operation
        }
    }
}
