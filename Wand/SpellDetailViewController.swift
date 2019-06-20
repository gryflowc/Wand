

import UIKit
import AVFoundation

class SpellDetailViewController: UIViewController {

    @IBOutlet weak var nameHeader: UILabel!
    @IBOutlet weak var descriptionHeader: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var castSpellButton: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    
    var spellData = SpellData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameHeader.text = spellData.name
        
        spellData.getData {
            self.descriptionLabel.text = "\(self.spellData.description)"
            self.nameLabel.text = "\(self.spellData.name)"
        }

    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: Data from \(soundName) could not be played as an audio file.")
            }
        } else {
            print("ERROR: ... ")
        }
    }
    
    
    @IBAction func viewSwiped(_ sender: UISwipeGestureRecognizer) {
        playSound(soundName: "\(spellData.soundFile)", audioPlayer: &audioPlayer)
    }
    
 
    // Not sure if swipe worked or not:
    @IBAction func castSpellButtonPressed(_ sender: UIButton) {
        playSound(soundName: "\(spellData.soundFile)", audioPlayer: &audioPlayer)
    }
    

}
