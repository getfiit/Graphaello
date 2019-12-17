//
//  GraphQLObject.swift
//  GraphQLCLI
//
//  Created by Mathias Quintero on 06.12.19.
//  Copyright © 2019 Mathias Quintero. All rights reserved.
//

import Foundation

struct GraphQLObject {
    let components: [Field : GraphQLComponent]
    let fragments: [String : GraphQLFragment]
    let typeConditionals: [String : GraphQLTypeConditional]
}

extension GraphQLObject {

    var subFragments: [GraphQLFragment] {
        return fragments.values + components.values.flatMap { $0.subFragments }
    }

}

extension GraphQLObject {
    
    static func + (lhs: GraphQLObject, rhs: GraphQLObject) -> GraphQLObject {
        let components = lhs.components.merging(rhs.components) { $0 + $1 }
        let fragments = lhs.fragments.merging(rhs.fragments) { $1 }
        let typeConditional = lhs.typeConditionals.merging(rhs.typeConditionals) { $0 + $1 }
        return GraphQLObject(components: components, fragments: fragments, typeConditionals: typeConditional)
    }
    
}