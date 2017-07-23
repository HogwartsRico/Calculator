//
//  ViewController.swift
//  Calculator
//
//

import UIKit

class ViewController: UIViewController {//这个类名叫ViewController  继承自UIViewController这个父类,swift是单继承

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //定义了一个属性(property) 或者叫实例变量
    @IBOutlet weak var displayNumber: UILabel!//unwarpped optional 
    
    
    
    //在swift中，当一个对象初始化了，那么这个对象的所有属性都必须要初始化，哪怕设为nil
    //var ifFirstClickButton :Bool=true;//是否第一次按键，如果是第一次，需要清除 Bool类型
    var ifFirstClickButton=true;
    
    @IBAction func appendDigit(_ sender: UIButton) {//sender表示参数名称，UIButton表示参数类型        
        let digit=sender.currentTitle!;
        print("您按下了\(digit)");
        if ifFirstClickButton {
            displayNumber.text=digit;
            ifFirstClickButton=false;
        }else{
             displayNumber.text=displayNumber.text!+digit;
        }
    }
    
    //var operandStack:Array<Double>=Array<Double>();//空数组
    var operandStack=Array<Double>();//swift是强类型语言，可以自动从后面的语句中推断出来I，所以可以省去上面一段
    
    @IBAction func enter() {
        ifFirstClickButton=true;
        operandStack.append(displayValue);
        print("openstack:\(operandStack)");
    }
    

    var displayValue:Double{
        get{
            
            return Double (displayNumber.text!)!;
        }
        set{
                displayNumber.text="\(newValue)";
                ifFirstClickButton=true;
        }
    }
    
    
    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!;
        if !ifFirstClickButton{
            enter();
        }
        switch operation{
            case "×":performOperation(operation: { (op1, op2)  in return op1*op2});//operation是参数标签
            case "÷":performOperation(operation: { (op1, op2)  in return op2/op1});
            case "+":performOperation(operation: { (op1, op2)  in return op1+op2});
            case "−":performOperation(operation: { (op1, op2)  in return op2-op1});
            case "√":performOperation(operation: { (op1)  in return sqrt(op1)});
        default:break;
        }// switch end
    }// operate end 
    
    func performOperation(operation:(Double,Double)->Double){//operation是参数标签
        if(operandStack.count>=2){
            displayValue=operation(operandStack.removeLast(),operandStack.removeLast());
            enter();
        }
    }
    
    /**
     Objective-C does not support method overloading, you have to use a different method name. When you inherited UIViewController you inherited NSObject and made the class interopable to Obj-C. Swift on the other hand does support overloading, that's why it works when you remove the inheritance.
     
     As it has already been answered, ObjC doesn't support method overloading (two methods with the same name) and In swift 2 under Xcode 7 there are two options to solve this kind of problems. One option is to rename the method using the attribute:
     
     @objc(newNameMethod:)
     
     func methodOne(par1, par2) {...}
     
     @objc(methodTwo:)
     func methodOne(par1) {...}
     another option to solve this problem in Xcode 7+ is by applying @nonobjc attribute to any method, subscript or initialiser
     
     func methodOne() {...}
     
     @nonobjc
     func methodOne() {...}
    */
    @nonobjc
    func performOperation(operation:(Double)->Double){//operation是参数标签
        if(operandStack.count>=1){
            displayValue=operation(operandStack.removeLast());
            enter();
        }
    }
}

