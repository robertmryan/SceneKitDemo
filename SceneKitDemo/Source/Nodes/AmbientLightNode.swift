//
//  AmbientLightNode.swift
//  MyApp1
//
//  Created by Robert Ryan on 5/28/26.
//

import SceneKit

nonisolated final class AmbientLightNode: SCNNode {
    override init() {
        super.init()
        let light = SCNLight()
        light.type = .ambient
        light.intensity = 400
        self.light = light
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
