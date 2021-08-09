//
//  ViewController.swift
//  CalcStoryboard
//
//  Created by Ксандер Гусаров on 06.08.2021.
//

import UIKit

enum mathOperations: Int {
    case ac = 10
    case equals = 11
    case plus = 12
    case minus = 13
    case div = 14
    case mod = 15
}

class ViewController: UIViewController {

    var currentNumber: Double = 0
    var previousNumber: Double = 0
    var isMathOperation: Bool = false;
    var operationType:Int = -1;
    
    @IBOutlet weak var resultLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //захват кнопок с цифрами
    @IBAction func digitsHandler(_ sender: UIButton) {
        
        if isMathOperation {
            resultLbl.text = String(sender.tag)
            isMathOperation = false
            currentNumber = Double(resultLbl.text!)!
        } else {
            resultLbl.text = resultLbl.text! + String(sender.tag)
            currentNumber = Double(resultLbl.text!)!
        }
    }
    //захват кнопок с операциями
    @IBAction func operationHandler(_ sender: UIButton) {
        if resultLbl.text != "" {
            //allow only if label not empty
            switch sender.tag {
            case mathOperations.ac.rawValue:
                isMathOperation = false
                clearResultFieldAndAction()
                break;
            case mathOperations.equals.rawValue:
                isMathOperation = true
                handleEquals()
                break;
            case mathOperations.plus.rawValue:
                previousNumber = currentNumber
                isMathOperation = true
                resultLbl.text = "+"
                operationType = 12
                break;
            case mathOperations.minus.rawValue:
                previousNumber = currentNumber
                isMathOperation = true
                resultLbl.text = "-"
                operationType = 13
                break;
            case mathOperations.div.rawValue:
                previousNumber = currentNumber
                if (previousNumber == 0 || currentNumber == 0) {
                    clearResultFieldAndAction()
                    resultLbl.text = "Gotcha!"
                    break;
                }
                isMathOperation = true
                resultLbl.text = "/"
                operationType = 14
                break;
            case mathOperations.mod.rawValue:
                previousNumber = currentNumber
                isMathOperation = true
                resultLbl.text = "x"
                operationType = 15
                break;
            default:
                //handle issues
                break;
            }
        }
    }
    
    func handleEquals() {
        switch operationType {
        case mathOperations.plus.rawValue:
            resultLbl.text = String(previousNumber + currentNumber)
            break;
        case mathOperations.minus.rawValue:
            resultLbl.text = String(previousNumber - currentNumber)
            break;
        case mathOperations.div.rawValue:
            resultLbl.text = String(previousNumber / currentNumber)
            break;
        case mathOperations.mod.rawValue:
            resultLbl.text = String(previousNumber * currentNumber)
            break;
        default:
            resultLbl.text = String(currentNumber)
            break;
        }
        //actionType = -1
    }
    
    func clearResultFieldAndAction() {
        resultLbl.text = ""
        currentNumber = 0
        previousNumber = 0
        operationType = -1
    }
}

