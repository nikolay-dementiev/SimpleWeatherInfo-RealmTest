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

	var cellDataTransfer: CellDataTemp? {
		didSet {
			titleOfCell.text = cellDataTransfer?.titleOfCell
			detailOfCell.text = cellDataTransfer?.detailOfCell
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

struct CellDataTemp {
	var titleOfCell: String = ""
	var detailOfCell: String = ""

	init () {
		refresh()
	}

	init (title:String, detail:String) {
		refresh()
		self.titleOfCell = title
		self.detailOfCell = detail
	}

	mutating func refresh() {
		self.titleOfCell = "<no parameter>"
		self.detailOfCell = "<no data>"
	}
}
