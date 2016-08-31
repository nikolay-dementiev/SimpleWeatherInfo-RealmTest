//
//  DataTime.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 30.08.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation
import SwiftyJSON

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

extension JSON {
	public var date: NSDate? {
		get {
			if let str: String = self.string {
				return JSON.jsonDateFormatter.dateFromString(str)
//			} else {
//				let dateAsInt = self.int as NSInteger!
//				let unixTime = dateAsInt / 10000000
//				return  NSDate(timeIntervalSince1970: NSTimeInterval(unixTime))
			}
			return nil
		}
	}

	private static let jsonDateFormatter: NSDateFormatter = {
		let fmt = NSDateFormatter()
		fmt.dateFormat = NSDate.parserStringDef //"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
		fmt.timeZone = NSTimeZone(forSecondsFromGMT: 0)
		return fmt
	}()
}
