//
//  GeneralVariables.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 28.07.16.
//  Copyright © 2016 mc373. All rights reserved.
//

//Singleton pattern
//https://github.com/ochococo/Design-Patterns-In-Swift#-singleton

class GeneralVariables {

	static let sharedInstance = GeneralVariables()

	let keyForOpenweathermap: String

	private init() {
		keyForOpenweathermap = "8883a951e7fc21341e748cc799879612"

	}
}
