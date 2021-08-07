//
//  ViewController.swift
//  CalcStoryboard
//
//  Created by Ксандер Гусаров on 06.08.2021.
//

import UIKit

class ViewController: UIViewController {

    var ScreenNum:Double = 0
    var PrevNum:Double = 0
    var isAction:Bool = false;
    var actionType:Int = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var prevnumlabel: UILabel!
    @IBOutlet weak var screennumlabel: UILabel!
    @IBOutlet weak var actionlabel: UILabel!
    
    @IBAction func DigitsHandler(_ sender: UIButton) {
        
        if isAction {
            //if action was maded
            result.text = String(sender.tag)
            isAction = false
            ScreenNum = Double(result.text!)!
        } else {
            //normal behaviour
            result.text = result.text! + String(sender.tag)
            ScreenNum = Double(result.text!)!
        }
        UpdateDebugLabels()
    }
    
    @IBAction func ActionHandler(_ sender: UIButton) {
        //handle actions
        PrevNum = ScreenNum//Double(result.text!)!
        
        if result.text != "" {
            //allow only if label not empty
            switch sender.tag {
            case 10:
                //AC button
                isAction=false
                HandleClear()
                break;
            case 11:
                //equals button
                isAction=true
                HandleEquals()
                break;
            case 12:
                //0:plus button
                //if isAction {HandleEquals()}
                isAction = true
                result.text="+"
                actionType=0
                break;
            case 13:
                //minus button
                //if isAction {HandleEquals()}
                isAction = true
                result.text="-"
                actionType=1
                break;
            case 14:
                //div button
                if (PrevNum == 0 || ScreenNum == 0) {
                    HandleClear()
                    result.text = "Gotcha!"
                    break;
                }
                //if isAction {HandleEquals()}
                isAction = true
                result.text="/"
                actionType=2
                break;
            case 15:
                //mod button
                
                //if isAction {HandleEquals()}
                isAction = true
                result.text="x"
                actionType=3
                break;
            default:
                //handle issues
                break;
            }
        }
        UpdateDebugLabels()
    }
    
    func HandleEquals() {
        //handle pressing equals button
        isAction = false
        switch actionType {
        case 0:
            //plus
            result.text = String(PrevNum+ScreenNum)
            break;
        case 1:
            //minus
            result.text = String(PrevNum-ScreenNum)
            break;
        case 2:
            //div
            result.text = String(PrevNum/ScreenNum)
            break;
        case 3:
            //mod
            result.text = String(PrevNum*ScreenNum)
            break;
        default:
            result.text = String(ScreenNum)
            break;
        }
        //actionType = -1
    }
    
    func HandleClear() {
        result.text = ""
        ScreenNum = 0
        PrevNum = 0
        actionType = -1
    }
    
    func UpdateDebugLabels() {
        prevnumlabel.text = String(PrevNum)
        screennumlabel.text = String(ScreenNum)
        actionlabel.text = String(actionType)
    }

}

