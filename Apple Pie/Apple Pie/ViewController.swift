//
//  ViewController.swift
//  Apple Pie
//
//  Created by Jan Andrzejewski on 06/05/2022.
//

import UIKit


class ViewController: UIViewController {
    
    // Data
    var listOfWords = ["butcher", "glorious", "swift", "bug", "program", "stack", "mushroom", "street", "pie", "hedgehog", "squirrel", "entrepreneur"]
    
    let incorrectMovesAllowed = 7

    var currentGame: Game!
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

    
    // Outlets
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
   
    
    // Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        updateUI()
        }

func newRound() {
    if !listOfWords.isEmpty {
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
        enableLetterButtons(true)
        updateUI()
    } else {
       enableLetterButtons(false)
    }
}

    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formatedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins) Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formatedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func restartGame() {
        totalWins = 0
        totalLosses = 0
    }
    
    func displayALert() {
        let alert = UIAlertController(title: "You finished the game!", message: "Your score is \(totalWins) out of \(listOfWords.count).", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: alertDismissed(_:))
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
    func alertDismissed(_ action: UIAlertAction) {
        restartGame()
    }
}

