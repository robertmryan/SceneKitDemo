//
//  CameraNode.swift
//  MyApp1
//
//  Created by Robert Ryan on 5/28/26.
//

import SceneKit

nonisolated final class CameraNode: SCNNode {
    override init() {
        super.init()
        let camera = SCNCamera()
        camera.fieldOfView = 60
        camera.zFar = 100
        self.camera = camera
        position = SCNVector3(0, 2.5, 7)
        eulerAngles = SCNVector3(-0.35, 0, 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
