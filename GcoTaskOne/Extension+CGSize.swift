//
//  Extension+CGSize.swift
//  GcoTaskOne
//
//  Created by Nozhan Amiri on 10/1/24.
//

import SwiftUI

extension CGSize {
    var boundingRect: CGRect {
        .init(origin: .zero, size: self)
    }
}
