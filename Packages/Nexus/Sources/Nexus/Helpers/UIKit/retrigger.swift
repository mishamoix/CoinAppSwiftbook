//
//  File.swift
//  
//
//  Created by mike on 08/09/2024.
//

import Foundation

func retrigger<Object: AnyObject, Value>(_ object: Object, keyPath: ReferenceWritableKeyPath<Object, Value>) {
    object[keyPath: keyPath] = object[keyPath: keyPath]
}
