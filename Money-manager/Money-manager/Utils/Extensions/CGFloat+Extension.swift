//
//  CGFloat+Extension.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import Foundation

extension CGFloat {
    func closest(between first: CGFloat, and second: CGFloat) -> CGFloat {
        return abs(self - first) < abs(self - second) ? first : second
    }
}
