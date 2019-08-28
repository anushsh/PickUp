//
//  GameTableViewCell.swift
//  PickUp
//
//  Created by Anushrut Shah on 25/04/2019.
//  Copyright © 2019 Anushrut Shah. All rights reserved.
//

import UIKit

protocol GameCellDelegate {
    func didTapJoin(game: Game)
}

class GameTableViewCell: UITableViewCell {
    var game: Game!
    var delegate: GameCellDelegate?
    var joining: Bool = true;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var gameText: UILabel!
    @IBOutlet weak var playerCount: UILabel!
    @IBOutlet weak var pitchText: UILabel!
    
    @IBAction func joinButton(_ sender: UIButton) {
        if joining {
            playerCount.text = String (Int(playerCount.text!)! + 1)
            joining.toggle()
        }
        else {
           playerCount.text = String (Int(playerCount.text!)! - 1)
            joining.toggle()
        }
        delegate?.didTapJoin(game: game)
    }
}
