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
	ResponseContentTransformer {
		JSON($0.content as AnyObject)
}


//see: http://bustoutsolutions.github.io/siesta/guide/services-resources/

class OpenweathermapOrg {
	// MARK: Configuration

	private let sharedParameters = GeneralVariables.sharedInstance
	private let service = Service(baseURL: "http://api.openweathermap.org")

	private init() {
		service.configure {
			// By default, Siesta parses JSON using NSJSONSerialization. This example wraps that with SwiftyJSON.

			$0.config.pipeline[.parsing].add(SwiftyJSONTransformer, contentTypes: ["*/json"])

			// Custom transformers can change any response into any other — in this case, replacing the default error
			// message with the one provided by the Github API.

			$0.config.pipeline[.cleanup].add(OpenweathermapOrgErrorMessageExtractor())
		}


		// Mapping from specific paths to models

//		service.configureTransformer("/sample/*") {
//			try WeatherCity(jsonBulk: $0.content)  // Input type inferred because User.init takes JSON
//		}


		service.configureTransformer("/*/*/weather") {
			//try WeatherCurrent(json: $0.content)
			WeatherCurrentMod.createObject($0.content)
		}

		service.configure("/*/*/weather") {
			$0.config.pipeline[.model].add(        // This custom transformer turns that curious convention into
				TrueIfResourceFoundTransformer())  // a resource whose content is a simple boolean.
		}

	}


	//http://bulk.openweathermap.org/sample/city.list.json.gz
	var bulkWeatherRepositories: Resource {
		return service
			.resource(absoluteURL: "http://bulk.openweathermap.org/sample/city.list.json.gz")
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

//MARK: API helpers
private struct OpenweathermapOrgErrorMessageExtractor: ResponseTransformer {
	func process(response: Response) -> Response {
		switch response {
		case .Success:
			return response

		case .Failure(var error):
			error.userMessage = error.jsonDict["message"] as? String ?? error.userMessage
			return .Failure(error)
		}
	}
}


private struct TrueIfResourceFoundTransformer: ResponseTransformer {
	func process(response: Response) -> Response {
		switch response {
		case .Success(var entity):
			entity.content = true  // Any success → true
			return logTransformation(
				.Success(entity))

		case .Failure(let error):
			if var entity = error.entity where error.httpStatusCode == 404 {
				entity.content = false  // 404 → false
				return logTransformation(
					.Success(entity))
			} else {
				return .Failure(error)  // Any other error remains an error
			}
		}
	}
}
