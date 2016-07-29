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
			//tableView.reloadData()
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
	}


	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}
