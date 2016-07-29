//
//  Optional+Browser.swift
//
//  Created by Paul on 2016/7/19.
//  Copyright © 2016 Bust Out Solutions. All rights reserved.
//

import Foundation

extension Optional {
    func required(name: String = "<unknown>") throws -> Wrapped {
        guard let value = self else {
            throw MissingRequiredValue(name: name, type: Wrapped.self)
        }
        return value
    }
}

struct MissingRequiredValue: ErrorType {
    let name: String?
    let type: Any.Type
}
