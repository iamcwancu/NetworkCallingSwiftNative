//
//  HomeTableViewCell.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 10/06/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var backgroundsView: UIView!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productCategoryLabel: UILabel!
    @IBOutlet private weak var productRateButton: UIButton!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    var product: HomeModel? {
        didSet {
            guard let product else { return }
            self.productImageView.setImage(with: product.image)
            self.productTitleLabel.text = product.title
            self.productCategoryLabel.text = product.title
            self.productRateButton.setTitle("\(product.rating?.rate ?? 0.0)", for: .normal)
            self.productDescriptionLabel.text = product.title
            self.productPriceLabel.text = "$\(product.price ?? 0.0)"
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func productBuyButtonAction(_ sender: UIButton) {
    }
}
