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
    
    var grayOperatorInitialBackground = "A5A5A5FF"
    var orangeOperatorInitialBackground = "F1A33CFF"
    var equalButtonClicked = "F1A33C08"

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "0"
    }
    
    func changeNumbersBackground(_ sender: UIButton) {
        UIView.animate(withDuration: 1) {
            sender.backgroundColor = UIColor(hex: self.grayOperatorInitialBackground)
            sender.backgroundColor = UIColor(rgb: 0x333333)
        }
    }
    
    @IBAction func changeGrayOperatorBackground(_ sender: UIButton) {
        UIView.animate(withDuration: 1) {
            sender.backgroundColor = .white
            sender.backgroundColor = UIColor(hex: self.grayOperatorInitialBackground)
        }
    }
    
    var lastButtonPressed: UIButton?
    
    @IBAction func changeOrangeOperatorBackground(_ sender: UIButton) {
        if let button = lastButtonPressed {
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(hex: orangeOperatorInitialBackground)
        }
        sender.setTitleColor(UIColor(hex: orangeOperatorInitialBackground), for: .normal)
        sender.backgroundColor = .white
        lastButtonPressed = sender
    }
    
    @IBAction func numPressed(_ sender: UIButton) {
        if let button = lastButtonPressed {
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(hex: orangeOperatorInitialBackground)
        }
        runningNumber += "\(sender.tag)"
        label.text = runningNumber
        changeNumbersBackground(sender)
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        if let button = lastButtonPressed {
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(hex: orangeOperatorInitialBackground)
        }
        UIView.animate(withDuration: 1) {
            sender.backgroundColor = UIColor(hex: self.equalButtonClicked)
            sender.backgroundColor = UIColor(hex: self.orangeOperatorInitialBackground)
        }
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

extension UIColor {
    convenience init(rgb: Int) {
        let components = (
            R: CGFloat((rgb >> 16) & 0xff) / 255,
            G: CGFloat((rgb >> 08) & 0xff) / 255,
            B: CGFloat((rgb >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    convenience init(hex: String) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 1

        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            if hex.count == 8 {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
            }
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
