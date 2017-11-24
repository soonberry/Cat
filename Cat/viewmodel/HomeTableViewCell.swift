//
//  HomeTableViewCell.swift
//  Cat
//
//  Created by Shuwen Li on 25/10/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var catMessage: UILabel!
    @IBOutlet weak var catTime: UILabel!
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catAvatar: UIImageView!
    
    @IBOutlet weak var thumbA: UIImageView!
    @IBOutlet weak var thumbB: UIImageView!
    @IBOutlet weak var thumbC: UIImageView!
    @IBOutlet weak var thumbStack: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(cellViewModel: HomeCellViewModel) {
        catName.text = cellViewModel.cat
        catTime.text = cellViewModel.time
        catMessage.text = cellViewModel.message
        catAvatar.kf.setImage(with: cellViewModel.avatar)
        setThumbs(cellViewModel: cellViewModel)
    }
    
    private func setThumbs(cellViewModel: HomeCellViewModel) {
        thumbA.kf.setImage(with: cellViewModel.thumbs[0])
        thumbB.kf.setImage(with: cellViewModel.thumbs[1])
        if cellViewModel.thumbs.count > 2 {
            thumbC.kf.setImage(with: cellViewModel.thumbs[2])
        }
    }
}
