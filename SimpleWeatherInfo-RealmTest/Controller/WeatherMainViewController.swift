//
//  MainWeatherViewController.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 29.07.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit
import Siesta

class WeatherMainViewController: UIViewController, UISearchBarDelegate, ResourceObserver {

	@IBOutlet weak var citySearch: UISearchBar!

	var repoListVC: WeatherTableViewController?
	var statusOverlay = ResourceStatusOverlay()

	var weatherResource: Resource? {
		didSet {
			// One call to removeObservers() removes both self and statusOverlay as observers of the old resource,
			// since both observers are owned by self (see below).

			oldValue?.removeObservers(ownedBy: self)
			oldValue?.cancelLoadIfUnobserved(afterDelay: 0.1)

			// Adding ourselves as an observer triggers an immediate call to resourceChanged().

			weatherResource?.addObserver(self)
				.addObserver(statusOverlay, owner: self)
				.loadIfNeeded()
		}
	}

	func resourceChanged(resource: Resource, event: ResourceEvent) {

	}


	override func viewDidLoad() {
		super.viewDidLoad()

		citySearch.delegate = self

		statusOverlay.embedIn(self)
		showActiveRepos()

		// Do any additional setup after loading the view.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func showActiveRepos() {
		//		usernameLabel.text = "Active Repositories"
		//		fullNameLabel.text = nil
		//		avatar.imageURL = nil
		repoListVC?.repositoriesResource = OpenweathermapOrgAPI.currentWeatherRepositories
	}

	func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
		if let searchText = searchBar.text where !searchText.isEmpty {

			// Setting userResource triggers a load and display of the new user data. Note that Siesta’s redunant
			// request elimination and model caching make it reasonable to do this on every keystroke.

			weatherResource = OpenweathermapOrgAPI.getCity(searchText)
		} else {
			weatherResource = nil
			showActiveRepos()
		}
	}

	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/

}