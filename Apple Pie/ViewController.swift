//
//  ViewController.swift
//  Apple Pie
//
//  Created by Esteban Ordonez on 1/24/19.
//  Copyright © 2019 Esteban Ordonez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords: [String] = [
        "bucaneer",
        "swift",
        "glorius",
        "incandescendt",
        "bug",
        "program"
    ];
    
    let incorrectMovesAllowed: Int = 7;
    var currentGame: Game!;
    
    
    var totalWins: Int = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLoses: Int = 0 {
        didSet {
            newRound();
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound();
        
        // Do any additional setup after    loading the view, typically from a nib.
    }
    
    func newRound(){
        if !listOfWords.isEmpty{
            let newWord:String = listOfWords.removeFirst();
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI();
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons{
            button.isEnabled = enable;
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false;
        if let letterString = sender.title(for: .normal){
         let letter =  Character(letterString.lowercased());
           currentGame.playerGuessed(letter: letter);
        }
            updateGameState()
    }
        
        func updateGameState(){
            if currentGame.incorrectMovesRemaining == 0  {
                totalLoses += 1;
            } else if currentGame.word == currentGame.formattedWord {
                totalWins += 1;
            } else {
                updateUI();
            }
        }
        
        
        func updateUI(){
            var letters = [String]()
            for letter in currentGame.formattedWord.characters{
                letters.append(String(letter));
            }
            let wordWithSpacing = letters.joined(separator: " ");
            correctWordLabel.text = wordWithSpacing;
            scoreLabel.text = "Wins: \(totalWins), Loses: \(totalLoses)";
            treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)");
            
        }
        
    }

