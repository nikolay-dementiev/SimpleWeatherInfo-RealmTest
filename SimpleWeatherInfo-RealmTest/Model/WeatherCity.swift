//
//  WeatherCity.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 28.07.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import SwiftyJSON

//_id
//name
//country
//coord
//		lon
//		lat

struct WeatherCity {

	// swiftlint:disable:next variable_name
	let _id: Int
	var name: String?
	var country: String?
	var coordLon: Double?
	var coordLat: Double?

	init(jsonCurrent json: JSON) throws {
		_id							= json["id"].intValue
		initOtherFirelds (json)

	}

	init(jsonBulk json: JSON) throws {
		_id							= json["_id"].intValue
		initOtherFirelds (json)
	}

	private mutating func initOtherFirelds (json: JSON) {
//		do {
//			name						= try json["name"].string.required("city.name")
//			country					= try json["sys"]["country"].string.required("sys.country")
//		} catch {
//			print ("error to parse JSON 'city.name' or 'sys.country'")
//		}
		name						= json["name"].stringValue
		country					= json["sys"]["country"].stringValue
		coordLon				= json["coord"]["lon"].doubleValue
		coordLat				= json["coord"]["lat"].doubleValue

	}

}
