//
//  ViewController.swift
//  MyApp1
//
//  Created by Robert Ryan on 5/28/26.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    // MARK: - View Lifecycle

    override func loadView() {
        let sceneView = SCNView()
        sceneView.scene = makeScene()
        sceneView.allowsCameraControl = true   // pinch/rotate/pan to explore
        sceneView.autoenablesDefaultLighting = false
        sceneView.backgroundColor = .black
        sceneView.showsStatistics = true
        view = sceneView
    }

    // MARK: - Scene

    private func makeScene() -> SCNScene {
        let scene = SCNScene()

        scene.rootNode.addChildNode(CameraNode())
        scene.rootNode.addChildNode(AmbientLightNode())
        scene.rootNode.addChildNode(DirectionalLightNode())

        let shapes: [(SCNGeometry, UIColor, String)] = [
            (SCNSphere(radius: 0.4),                                             .systemBlue,   "Sphere"),
            (SCNBox(width: 0.7, height: 0.7, length: 0.7, chamferRadius: 0.05), .systemOrange, "Box"),
            (SCNCylinder(radius: 0.3, height: 0.8),                             .systemGreen,  "Cylinder"),
            (SCNCone(topRadius: 0, bottomRadius: 0.4, height: 0.8),             .systemRed,    "Cone"),
            (SCNTorus(ringRadius: 0.35, pipeRadius: 0.12),                      .systemPurple, "Torus"),
            (SCNPyramid(width: 0.7, height: 0.8, length: 0.7),                  .systemYellow, "Pyramid"),
        ]

        let ringRadius: Float = 2.2
        for (index, (geometry, color, name)) in shapes.enumerated() {
            let angle = Float(index) / Float(shapes.count) * 2 * .pi
            let x = ringRadius * cos(angle)
            let z = ringRadius * sin(angle)

            let shapeNode = ShapeNode(geometry: geometry, color: color, name: name)
            shapeNode.position = SCNVector3(x, 0, z)
            scene.rootNode.addChildNode(shapeNode)

            let labelNode = LabelNode(name)
            labelNode.position = SCNVector3(x, 0.75, z)
            scene.rootNode.addChildNode(labelNode)
        }

        return scene
    }
}
