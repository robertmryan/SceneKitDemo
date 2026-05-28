//
//  ShapeNode.swift
//  MyApp1
//
//  Created by Robert Ryan on 5/28/26.
//

import SceneKit
import UIKit

nonisolated final class ShapeNode: SCNNode {
    init(geometry: SCNGeometry, color: UIColor, name: String) {
        super.init()
        self.name = name
        self.geometry = geometry
        self.geometry?.firstMaterial = ShapeNode.phongMaterial(color: color)
        runAction(.repeatForever(.rotateBy(x: 0.3, y: 1, z: 0.1, duration: 3)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private static func phongMaterial(color: UIColor) -> SCNMaterial {
        let mat = SCNMaterial()
        mat.diffuse.contents = color
        mat.specular.contents = UIColor.white
        mat.shininess = 50
        mat.lightingModel = .phong
        return mat
    }
}
