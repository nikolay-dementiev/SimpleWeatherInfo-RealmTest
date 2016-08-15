//
//  OpenweathermapOrgApi.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 28.07.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Siesta
import SwiftyJSON

let OpenweathermapOrgAPI = OpenweathermapOrg()

private let SwiftyJSONTransformer =
	ResponseContentTransformer { JSON($0.content as AnyObject) }

//see: http://bustoutsolutions.github.io/siesta/guide/services-resources/

class OpenweathermapOrg {
	// MARK: Configuration

	private let sharedParameters = GeneralVariables.sharedInstance
	private let service = Service(baseURL: "http://api.openweathermap.org")

	private init() {
		service.configure {
			// By default, Siesta parses JSON using NSJSONSerialization. This example wraps that with SwiftyJSON.

			$0.config.pipeline[.parsing].add(SwiftyJSONTransformer, contentTypes: ["*/json"])
		}


		// Mapping from specific paths to models

		service.configureTransformer("/sample/*") {
			try WeatherCity(jsonBulk: $0.content)  // Input type inferred because User.init takes JSON
		}

//		service.configureTransformer("weather/?q*") {
//			try ($0.content as JSON)   // “as JSON” gives Siesta the expected input type
//				.arrayValue            // SwiftyJSON defaults to []
//				.map(WeatherCurrent.init)  // Model mapping gives Siesta an implicit output type
//		}

				service.configureTransformer("/data/2.5/weather/*") {
					try WeatherCurrent.init(json: $0.content)   // “as JSON” gives Siesta the expected input type

				}


	}

//	var currentWeatherRepositories: Resource {
//		return service
//			.resource("/data/2.5")
//			//.withParam("?q", "Kiev")
//			.withParam("mode", "json")
//			.withParam("units", "metri")
//			.withParam("appid", sharedParameters.keyForOpenweathermap)
//	}


	//http://bulk.openweathermap.org/sample/city.list.json.gz
	var bulkWeatherRepositories: Resource {
		return service
			//.relative().relative("bulk")
			.resource(absoluteURL: "http://bulk.openweathermap.org/sample/city.list.json.gz")
		//.resource("/sample").child("city.list.json.gz")
		}

	func getCity(cityName: String) -> Resource {
		return service
			.resource("/data/2.5/weather")
			.withParam("q", cityName)
			.withParam("mode", "json")
			.withParam("units", "metric")
			.withParam("appid", sharedParameters.keyForOpenweathermap)
	}

	func wiperResource () {
		service.invalidateConfiguration()  // So that future requests for existing resources pick up config change
		service.wipeResources()  // Scrub all unauthenticated data
	}

}
