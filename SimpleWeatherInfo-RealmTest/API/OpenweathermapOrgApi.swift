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

//class SiestaWeathermapAPI: Service {
//	init() {
//		super.init(baseURL: "http://api.openweathermap.org")
//	}
//
//	var profile:			Resource { return resource("/profile") }
//	var currentItem:  Resource { return resource("/items") }
//
//	func item(id: String) -> Resource {
//		return items.child(id)
//	}
//}

//let myAPI = MyAPI()

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
			.resource("/data/2.5/weather")
			.withParam("?q", "Kiev")
			.withParam("mode", "json")
			.withParam("units", "metri")
			.withParam("appid", sharedParameters.keyForOpenweathermap)
	}


}
