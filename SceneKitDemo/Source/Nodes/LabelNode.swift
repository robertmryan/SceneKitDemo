//
//  LabelNode.swift
//  MyApp1
//
//  Created by Robert Ryan on 5/28/26.
//

import SceneKit
import UIKit

nonisolated final class LabelNode: SCNNode {
    init(_ text: String) {
        super.init()
        let geometry = SCNText(string: text, extrusionDepth: 0.02)
        geometry.font = UIFont.systemFont(ofSize: 0.3, weight: .semibold)
        geometry.flatness = 0.1
        geometry.firstMaterial?.diffuse.contents = UIColor.white
        geometry.firstMaterial?.isDoubleSided = true

        self.geometry = geometry

        let bbox = geometry.boundingBox
        pivot = SCNMatrix4MakeTranslation(
            bbox.min.x + (bbox.max.x - bbox.min.x) / 2,
            bbox.min.y + (bbox.max.y - bbox.min.y) / 2,
            0
        )
        constraints = [SCNBillboardConstraint()]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
