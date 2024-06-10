//
//  Event.swift
//  iOS_NanoDegree
//
//  Created by Ahad Albaqami on 6/10/24.
//

import Foundation
import SwiftUI

struct Events: Identifiable, Comparable {
    let id = UUID()
    var title: String
    var date: Date
    var textColor: Color
    
    static func < (lhs: Events, rhs: Events) -> Bool {
        return lhs.date < rhs.date
    }
}
