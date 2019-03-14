//
//  GameScreen.swift
//  MemorizeThis WatchKit Extension
//
//  Created by shivam gandhi on 2019-03-14.
//  Copyright © 2019 shivam gandhi. All rights reserved.
//

import WatchKit
import Foundation


class GameScreen: WKInterfaceController {
    
    var isWatching = true {
        didSet {
            if isWatching {
                setTitle("WATCH!")
            } else {
                setTitle("REPEAT!")
            }
        }
    }
    
    var key: Int = 1
    var wonKey: Int = 0
    var showPlayButton: Bool = false
    
    @IBOutlet weak var A: WKInterfaceButton!
    @IBOutlet weak var B: WKInterfaceButton!
    @IBOutlet weak var C: WKInterfaceButton!
    @IBOutlet weak var D: WKInterfaceButton!
    @IBOutlet weak var userMessage: WKInterfaceLabel!
    var sequence = [WKInterfaceButton]()
    var sequenceIndex = 0
    var won : Bool = true
    @IBOutlet weak var playAgainButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        startNewGame()
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        userMessage.setText("square number \(key)")
        userMessage.setAlpha(0.0)
        playAgainButton.setEnabled(false)
        playAgainButton.setAlpha(0.0)
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    func playNextSequenceItem() {
        // stop flashing if we've finished our sequence
        print(sequenceIndex)
        guard sequenceIndex < sequence.count else {
            isWatching = false
            sequenceIndex = 0
            for i in 0...3{
                
                let button1 = sequence[i]
                button1.setAlpha(1.0)
                
            }
            print("condition false")
            userMessage.setAlpha(1.0)
            return
        }
        
        // otherwise move our sequence forward
        
        for i in 0...3{
            
            if(sequenceIndex == i){
                let button1 = sequence[sequenceIndex]
                button1.setAlpha(1.0)
            }
            else{
            }
        }
        print(sequence[sequenceIndex])
        let button = sequence[sequenceIndex]
        sequenceIndex += 1
        // wait a fraction of a second before flashing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            // mark this button as being active
            button.setTitle("•")
            print("button flashed")
            // wait again
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // deactivate the button and flash again
                button.setTitle("")
                
                self?.playNextSequenceItem()
            }
        }
    }
    func addToSequence() {
        // show static button in sequance A-B-C-D
        let colors: [WKInterfaceButton] = [A, B, C, D]
        for i in 0...3{
            sequence.append(colors[i])
        }
        
        // start the flashing at the beginning
        sequenceIndex = 0
        
        // update the player instructions
        isWatching = true
        
        for i in 0...3{
            
                let button1 = sequence[i]
                button1.setAlpha(0.0)
            
        }
        
        
        // give the player a little respite, then start flashing
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            print("inside addToSequance - playNextSequence")
            self.playNextSequenceItem()
        }
    }
    func startNewGame() {
        sequence.removeAll()
        addToSequence()
    }

    func makeMove(_ color: WKInterfaceButton) {
        // don't let the player touch stuff while in watch mode
        guard isWatching == false else { return }
        
        if sequence[sequenceIndex] == color {
            // they were correct! Increment the sequence index.
            sequenceIndex += 1
            
            if sequenceIndex == sequence.count {
                // they made it to the end; add another button to the sequence
                addToSequence()
            }
        } else {
            // they were wrong! End the game.
            let playAgain = WKAlertAction(title: "Play Again", style: .default) {
                self.startNewGame()
            }
            
            presentAlert(withTitle: "Game over!", message: "You scored \(sequence.count - 1).", preferredStyle: .alert, actions: [playAgain])
        }
    }
    @IBAction func buttonA_pressed() {
         guard isWatching == false else { return }
        print("button A pressed: key-> \(key) and won->\(won)")
        if (key == 1 && won != false)  {
            won = true
            wonKey += 1
            key += 1
            userMessage.setText("square number \(key)")
        }
        else{
            won = false
            userMessage.setText("You Suck.")
            playAgainButton.setEnabled(true)
            playAgainButton.setAlpha(1.0)
        }
        if(wonKey > 3){
            userMessage.setText("You Win.")
            playAgainButton.setEnabled(true)
            playAgainButton.setAlpha(1.0)
        }
    }
    @IBAction func buttonB_pressed() {
         guard isWatching == false else { return }
        if (key == 2 && won != false) {
            won = true
            wonKey += 1
            key += 1
            userMessage.setText("square number \(key)")
        }
        else{
            won = false
            userMessage.setText("You Suck.")
            playAgainButton.setEnabled(true)
            playAgainButton.setAlpha(1.0)
        }
        if(wonKey > 3){
            userMessage.setText("You Win.")
            playAgainButton.setEnabled(true)
            playAgainButton.setAlpha(1.0)
        }
    }
    @IBAction func buttonC_pressed() {
         guard isWatching == false else { return }
        if (key == 3 && won != false) {
            won = true
            wonKey += 1
            key += 1
            userMessage.setText("square number \(key)")
        }
        else{
            won = false
            userMessage.setText("You Suck.")
            playAgainButton.setEnabled(true)
            playAgainButton.setAlpha(1.0)
        }
        if(wonKey > 3){
            userMessage.setText("You Win.")
            playAgainButton.setEnabled(true)
            playAgainButton.setAlpha(1.0)
        }
    }
    @IBAction func buttonD_pressed() {
         guard isWatching == false else { return }
        if (key == 4 && won != false) {
            won = true
            wonKey += 1
            key += 1
            userMessage.setText("square number \(key)")
        }
        else{
            won = false
           userMessage.setText("You Suck.")
            playAgainButton.setEnabled(true)
            playAgainButton.setAlpha(1.0)
            
        }
        if(wonKey > 3){
            userMessage.setText("You Win.")
            playAgainButton.setEnabled(true)
            playAgainButton.setAlpha(1.0)
        }
    }
    
    @IBAction func playAgainClicked() {
        guard showPlayButton == false else { return }
        
    }
}
