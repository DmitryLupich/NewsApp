//
//  Color+Extensions.swift
//  Common
//
//  Created by Dmitriy Lupych on 17.02.2023.
//  Copyright © 2023 Dmitry Lupich. All rights reserved.
//

import SwiftUI

public extension Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
