//
//  Pipeline.swift
//  Graphaello
//
//  Created by Mathias Quintero on 12/8/19.
//  Copyright © 2019 Mathias Quintero. All rights reserved.
//

import Foundation
import SourceKittenFramework

protocol Pipeline {
    func extract(from file: File) throws -> [Struct<Stage.Extracted>]
    func parse(extracted: Struct<Stage.Extracted>) throws -> Struct<Stage.Parsed>
    func validate(parsed: Struct<Stage.Parsed>, using apis: [API]) throws -> Struct<Stage.Validated>
    func resolve(validated: [Struct<Stage.Validated>]) throws -> [GraphQLStruct]
}

extension Pipeline {
    
    func extract(from files: [File]) throws -> [Struct<Stage.Extracted>] {
        return try files.flatMap { try extract(from: $0) }
    }
    
    func parse(extracted: [Struct<Stage.Extracted>]) throws -> [Struct<Stage.Parsed>] {
        return try extracted.map { try parse(extracted: $0) }
    }
    
    func validate(parsed: [Struct<Stage.Parsed>], using apis: [API]) throws -> [Struct<Stage.Validated>] {
        return try parsed.map { try validate(parsed: $0, using: apis) }
    }
    
}
