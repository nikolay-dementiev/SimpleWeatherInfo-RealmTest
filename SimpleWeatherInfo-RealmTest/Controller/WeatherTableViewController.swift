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
		return  representData?.countOfElements ?? 0
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
		if let cell = cell as? RepositoryTableViewCell {

			cell.cellDataTransfer = representData![indexPath.row]
		}
		return cell
	}
}

struct RepresentDataObj {
	var arrayOfRepresentData: [CellDataTemp] = []
	var countOfElements: Int { get {return arrayOfRepresentData.count} }

	init (cWeather: WeatherCurrent?) {
		guard cWeather != nil  else {
			arrayOfRepresentData = []
			return
		}

		arrayOfRepresentData = cWeather!.getRepresentOfObject()
	}

	func notEmpty() -> Bool {
		return countOfElements > 0
	}

	subscript(indx: Int) -> CellDataTemp {

		get {
			var valueToReturn = CellDataTemp()

			if indx >= 0 && indx <= arrayOfRepresentData.count-1 {

				valueToReturn = arrayOfRepresentData [indx]
			} else {
				valueToReturn.refresh()
			}

			return valueToReturn
		}

	}
}
