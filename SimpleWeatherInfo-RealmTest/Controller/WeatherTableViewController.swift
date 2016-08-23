//
//  ViewController.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 27.07.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit
import Siesta

class WeatherTableViewController: UITableViewController, ResourceObserver {

	// MARK: Interesting Siesta stuff

	var repositoriesResource: Resource? {
		didSet {
			oldValue?.removeObservers(ownedBy: self)

			repositoriesResource?
				.addObserver(self)
				.addObserver(statusOverlay, owner: self)
				.loadIfNeeded()
		}
	}

	var representData: RepresentDataObj? {
		didSet {

			if representData!.notEmpty() {
				tableView.reloadData()
			} else {
				// need blank screeen with empty data warnings!
			}
		}
	}

	var statusOverlay = ResourceStatusOverlay()

	func resourceChanged(resource: Resource, event: ResourceEvent) {
		// Siesta’s typedContent() infers from the type of the repositories property that
		// repositoriesResource should hold content of type [Repository].

		//let repositories:WeatherCurrent? = repositoriesResource?.typedContent()


//		if repositories != nil {
//			dictOfRepresentData = repositories!.getRepresentOfObject()
//		} else {
//
//			dictOfRepresentData = [:]
//		}

		representData = RepresentDataObj(cWeather: repositoriesResource?.typedContent())

	}


	// MARK: Standard table view stuff
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		statusOverlay.embedIn(self)
	}

	override func viewDidLayoutSubviews() {
		statusOverlay.positionToCoverParent()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	//MARK: Table DataSource/ Delegate

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return  representData?.countOfElements ?? 0 //dictOfRepresentData.count ?? 0
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
		if let cell = cell as? RepositoryTableViewCell {

			let dataFromDict = representData![indexPath.row]

			let cellTransfer = CellDataTemp(title: dataFromDict.key, detail: dataFromDict.value)

			cell.cellDataTransfer = cellTransfer
		}
		return cell
	}

}

struct RepresentDataObj {
	var dictOfRepresentData: [String: String] = [:] {
		didSet {
			arrayOfKeyDict = [String](dictOfRepresentData.keys)
		}
	}
	var countOfElements: Int { get {return dictOfRepresentData.count} }
	var arrayOfKeyDict:[String] = []

	init (cWeather: WeatherCurrent?) {
		guard cWeather != nil else {
			dictOfRepresentData = [:]
			return
		}

		dictOfRepresentData = cWeather!.getRepresentOfObject()
		arrayOfKeyDict = [String](dictOfRepresentData.keys)
	}

	func notEmpty() -> Bool {
		return countOfElements > 0
	}

	struct ValueFromDict {
		var key: String = ""
		var value: String = ""
	}

	subscript(indx: Int) -> ValueFromDict {

		// 1
		get {
			var valueToReturn = ValueFromDict()

			if indx >= 0 && indx <= arrayOfKeyDict.count-1 {
				let keyByIndex = arrayOfKeyDict[indx]
				let valueFromD = self.dictOfRepresentData[keyByIndex]!

				valueToReturn.key = keyByIndex
				valueToReturn.value = valueFromD
			}

			return valueToReturn
		}

	}
}
