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
	}

	var currentWeatherRepositories: Resource {
		return service
			.resource("/data/2.5")
			//.withParam("?q", "Kiev")
			.withParam("mode", "json")
			.withParam("units", "metri")
			.withParam("appid", sharedParameters.keyForOpenweathermap)
	}

	//http://bulk.openweathermap.org/sample/city.list.json.gz
	var bulkWeatherRepositories: Resource {
		return service
			//.relative().relative("bulk")
			.resource(absoluteURL: "http://bulk.openweathermap.org/sample/city.list.json.gz")
		//.resource("/sample").child("city.list.json.gz")
		}

	func getCity(cityName: String) -> Resource {
		return service
			.resource("/weather")
			.withParam("?q", cityName)//child(cityName)
	}

	func wiperResource () {
		service.invalidateConfiguration()  // So that future requests for existing resources pick up config change
		service.wipeResources()  // Scrub all unauthenticated data
	}

}
