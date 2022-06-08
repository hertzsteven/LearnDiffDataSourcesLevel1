    //
    //  MYNumber.swift
    //  LearnDiffDataSourcesLevel1
    //
    //  Created by Steven Hertz on 6/8/22.
    //

import Foundation

// the item in the diffDataSource
struct MYNumber: Hashable {
    let numberName: String
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: MYNumber, rhs: MYNumber) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
