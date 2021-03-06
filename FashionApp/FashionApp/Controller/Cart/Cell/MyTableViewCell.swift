//
//  MyTableViewCell.swift
//  FashionApp
//
//  Created by Apple on 4/14/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit
import Kingfisher

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPresent: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbSize: UILabel!
    @IBOutlet weak var lbColor: UILabel!
    @IBOutlet weak var lbQuantity: UILabel!
    
    var modelCart: ModelCart? {
        didSet {
            lbName.text = self.modelCart?.name
            guard let rating = self.modelCart?.rating else {return}
            lbRating.text = "Rating: \(rating) ⭐️"
            guard let data = self.modelCart?.pic else {return}
            self.imgPresent.setImage(url: data)
            guard let quantitys = self.modelCart?.quantity else {return}
            lbQuantity.text = "x\(quantitys)"
            guard let size = self.modelCart?.size else {return}
            lbSize.text = "Size: \(size)"
            guard let color = self.modelCart?.color else {return}
            lbColor.text = "Color: \(color)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
