//
//  previewOfObjects.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 25.08.16.
//  Copyright © 2016 mc373. All rights reserved.
//


struct CellDataTemp {
	var key: String = ""
	var value: String = ""

	init () {
		refresh()
	}

	init (k key: String, v value: String) {
		refresh()
		self.key = key
		self.value = value
	}

	mutating func refresh() {
		self.key = "<no parameter>"
		self.value = "<no data>"
	}
}

