//
//  CodegenCommand.swift
//  GraphQLCLI
//
//  Created by Mathias Quintero on 11/29/19.
//  Copyright © 2019 Mathias Quintero. All rights reserved.
//

import Foundation
import CLIKit
import XcodeProj
import PathKit

class CodegenCommand : Command {
    let pipeline = PipelineFactory.create()
    
    @CommandOption(default: .first(Path.currentDirectory),
                   description: "Path to Xcode Project usind GraphQL")
    var project: ProjectPath

    var description: String {
        return "Generates a file with all the boilerplate code for your GraphQL Code"
    }

    func run() throws {
        let extracted = try pipeline.extract(from: try project.open())
        let parsed = try pipeline.parse(extracted: extracted)
        let validated = try pipeline.validate(parsed: parsed)
        let resolved = try pipeline.resolve(validated: validated)

        let autoGeneratedFile = try resolved.generate()
        print(autoGeneratedFile)
    }
}
