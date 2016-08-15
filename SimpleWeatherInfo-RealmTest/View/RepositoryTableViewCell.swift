//
//  RepositoryTableViewCell.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 15.08.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

	@IBOutlet weak var titleOfCell: UILabel!
	@IBOutlet weak var detailOfCell: UILabel!

 var repository: WeatherCurrent? {
	didSet {
		titleOfCell.text = "title"
		detailOfCell.text = repository?.city.name

	}
	}


	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}
	
}
