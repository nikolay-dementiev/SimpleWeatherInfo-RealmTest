//
//  DataTime.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 30.08.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation

extension NSDate {

	private static let parserStringDef = "yyyy-MM-dd' 'HH:mm:ss"

	class func parse(dateStr: String, format: String = parserStringDef) -> NSDate {
		let dateFmt         = NSDateFormatter()
		dateFmt.timeZone    = NSTimeZone.defaultTimeZone()
		dateFmt.dateFormat  = format

		return dateFmt.dateFromString(dateStr)!
	}

	func parseDate(dateFormat: String? = nil) -> String {

		let dateFmt           = NSDateFormatter()
		dateFmt.dateFormat    = dateFormat ?? NSDate.parserStringDef//"HH:mm:ss"//"yyyy-MM-dd' 'HH:mm:ss"

		let dateStr = dateFmt.stringFromDate(self)
		return dateStr
	}
}
