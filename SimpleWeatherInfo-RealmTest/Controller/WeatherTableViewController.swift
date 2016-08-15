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

	var repositories: [WeatherCurrent] = [] {
		didSet {
			tableView.reloadData()
		}
	}

	var statusOverlay = ResourceStatusOverlay()

	func resourceChanged(resource: Resource, event: ResourceEvent) {
		// Siesta’s typedContent() infers from the type of the repositories property that
		// repositoriesResource should hold content of type [Repository].

		repositories = repositoriesResource?.typedContent() ?? []
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
		return  repositories.count ?? 0
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
		if let cell = cell as? RepositoryTableViewCell {
			cell.repository = repositories[indexPath.row]
		}
		return cell
	}



}
