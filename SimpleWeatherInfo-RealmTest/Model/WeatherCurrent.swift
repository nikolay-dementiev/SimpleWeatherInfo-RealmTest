//
//  WeatherCurrent.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 28.07.16.
//  Copyright © 2016 mc373. All rights reserved.
//


import SwiftyJSON

struct WeatherCurrent {

	let city: WeatherCity
	//	let name: String
	//	// swiftlint:disable:next variable_name
	//	let _id: Int64
	//	let country: String
	let weatherMain: String
	let weatherDescription: String
	let weatherIcon: String?
	let mainTemp: Double
	let mainPressure: Int
	let mainHumidity: Int
	let mainTempMin: Double
	let mainTempMax: Double
	let windSpeed: Int
	let windDeg: Int



	init(json: JSON) throws {
		//		url              = try json["url"].string.required("repository.url")
		//		name             = try json["name"].string.required("repository.name")
		//		starCount        = json["stargazers_count"].int
		//		description      = json["description"].string
		//		collaboratorsURL = json["collaboratorsURL"].string

		//let dict = json.dictionaryValue

//		for (key,subJson):(String, JSON) in json {
//   //Do something you want
//		}

		city            = try WeatherCity(jsonCurrent: json)

		weatherMain			= json["weather"]["main"].stringValue
		weatherDescription = json["weather"]["description"].stringValue
		weatherIcon = ""
		mainTemp = json["main"]["temp"].doubleValue
		mainPressure = 0
		mainHumidity = 0
		mainTempMin = 0
		mainTempMax = 0
		windSpeed = json["wind"]["speed"].intValue
		windDeg = 0





	}
}
