//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Joe Chavez on 8/10/15.
//  Copyright (c) 2015 izen.me, Inc. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var shiftStatus: Int! // 0 = off, 1 = on, 2 = caps lock
    
    @IBOutlet var numbersRow1View: UIView!
    @IBOutlet var numbersRow2View: UIView!
    @IBOutlet var symbolsRow1View: UIView!
    @IBOutlet var symbolsRow2View: UIView!
    @IBOutlet var numbersSymbolsRow3View: UIView!
    
    @IBOutlet var letterButtonsArray: [UIButton]!
    @IBOutlet var switchModeRow3Button: UIButton!
    @IBOutlet var switchModeRow4Button: UIButton!
    @IBOutlet var shiftButton: UIButton!
    @IBOutlet var spaceButton: UIButton!
    
    private var proxy: UITextDocumentProxy {
        return textDocumentProxy as! UITextDocumentProxy
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        shiftStatus = 1;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    @IBAction func globeKeyPressed(sender: UIButton) {
        advanceToNextInputMode()
    }
    
    
    @IBAction func shiftKeyPressedX(sender: UITapGestureRecognizer) {
    }
    
    @IBAction func keyPressed(sender: UIButton) {
        proxy.insertText(sender.titleLabel!.text!)
        
        if(shiftStatus == 1) {
            shiftKeyPressed(self.shiftButton)
        }
    }
    
    @IBAction func backspaceKeyPressed(sender: UIButton) {
        proxy.deleteBackward()
    }
    
    @IBAction func spaceKeyPressed(sender: UIButton)
    {
        proxy.insertText(" ")
    }
    
    @IBAction func shifKeyDoubleTapped(sender: UITapGestureRecognizer) {
        shiftStatus = 2;
        shiftKeys()
    }
    
    @IBAction func shiftKeyTripleTapped(sender: UITapGestureRecognizer) {
        shiftStatus = 0
        shiftKeyPressed(self.shiftButton)
    }
    
    @IBAction func spaceKeyDoubleTapped(sender: UITapGestureRecognizer) {
        proxy.deleteBackward()
        proxy.insertText(". ")
        
        if(shiftStatus == 0) {
            shiftKeyPressed(self.shiftButton)
        }
    }

    @IBAction func returnKeyPressed(sender: UIButton) {
        proxy.insertText("\n");
    }

    @IBAction func shiftKeyPressed(sender: UIButton) {
        shiftStatus = shiftStatus > 0 ? 0 : 1;
        shiftKeys()
    }
    
    func shiftKeys() {
        if(shiftStatus == 0) {
            for (letterButtonIndex, letterButton) in enumerate(letterButtonsArray) {
                letterButton.setTitle(letterButton.titleLabel?.text!.lowercaseString, forState: UIControlState.Normal)
            }
        }
        else {
            for (letterButtonIndex, letterButton) in enumerate(letterButtonsArray) {
                letterButton.setTitle(letterButton.titleLabel?.text!.uppercaseString, forState: UIControlState.Normal)
            }
        }
    
        var shiftButtonImageName = String(format: "shift_%i.png", shiftStatus)
        shiftButton.setImage(UIImage(named: shiftButtonImageName), forState: UIControlState.Normal)

        var shiftButtonHLImageName = String(format: "shift_%i.png", shiftStatus)
        shiftButton.setImage(UIImage(named: shiftButtonHLImageName), forState: UIControlState.Highlighted)
    }

    @IBAction func switchKeyboardMode(sender: UIButton) {
        numbersRow1View.hidden = true;
        numbersRow2View.hidden = true;
        symbolsRow1View.hidden = true;
        symbolsRow2View.hidden = true;
        numbersSymbolsRow3View.hidden = true;
        
        switch (sender.tag) {
            
        case 1:
            numbersRow1View.hidden = false
            numbersRow2View.hidden = false
            numbersSymbolsRow3View.hidden = false
            
            switchModeRow3Button.setImage(UIImage(named: "symbols.png"), forState: UIControlState.Normal)
            switchModeRow3Button.setImage(UIImage(named: "symbolsHL.png"), forState: UIControlState.Highlighted)
            switchModeRow3Button.tag = 2
            
            switchModeRow4Button.setImage(UIImage(named: "abc.png"), forState: UIControlState.Normal)
            switchModeRow4Button.setImage(UIImage(named: "abcHL.png"), forState: UIControlState.Highlighted)
            switchModeRow4Button.tag = 0
        break;
            
        case 2:
            
            symbolsRow1View.hidden = false
            symbolsRow2View.hidden = false
            numbersSymbolsRow3View.hidden = false
            
            switchModeRow3Button.setImage(UIImage(named: "numbers.png"), forState: UIControlState.Normal)
            switchModeRow3Button.setImage(UIImage(named: "numbersHL.png"), forState: UIControlState.Highlighted)
            switchModeRow3Button.tag = 1
            
        break;
            
        default:
            switchModeRow4Button.setImage(UIImage(named: "numbers.png"), forState: UIControlState.Normal)
            switchModeRow4Button.setImage(UIImage(named: "numbersHL.png"), forState: UIControlState.Highlighted)
            switchModeRow4Button.tag = 1
            break;
            
        }
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    }

}
