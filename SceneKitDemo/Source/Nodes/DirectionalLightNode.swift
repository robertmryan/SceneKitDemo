//
//  DirectionalLightNode.swift
//  MyApp1
//
//  Created by Robert Ryan on 5/28/26.
//

import SceneKit

nonisolated final class DirectionalLightNode: SCNNode {
    override init() {
        super.init()
        let light = SCNLight()
        light.type = .directional
        light.intensity = 1000
        light.castsShadow = true
        self.light = light
        eulerAngles = SCNVector3(-Float.pi / 4, Float.pi / 4, 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
