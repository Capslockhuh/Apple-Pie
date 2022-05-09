//
//  ViewController.swift
//  Apple Pie
//
//  Created by Jan Andrzejewski on 06/05/2022.
//

import UIKit

// Data
var listOfWords = ["butcher", "glorious", "swift", "bug", "program", "stack", "mushroom", "street", "pie", "hedgehog", "squirrel", "entrepreneur"]
let incorrectMovesAllowed = 7
var totalWins = 0
var totalLosses = 0
var currentGame: Game!


class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    
    // Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
         sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
            let letter = Character(letterString.lowercased())
            currentGame.playerGuessed(letter: letter)
            updateUI()
    }
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        
        func newRound() {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            
            updateUI()
        }
            
    }
 
    func updateUI() {
        scoreLabel.text = "Wins: \(totalWins) Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
}
