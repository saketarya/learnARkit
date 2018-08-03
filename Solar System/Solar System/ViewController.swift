//
//  ViewController.swift
//  Solar System
//
//  Created by saket arya on 7/24/18.
//  Copyright © 2018 saket arya. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
        sun.position = SCNVector3(0,0,-1)
        
        let earthParent = SCNNode()
        earthParent.position = SCNVector3(0,0,-1)
        
        let venusParent = SCNNode()
        venusParent.position = SCNVector3(0,0,-1)
    
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth emission"), normal: #imageLiteral(resourceName: "Earth normal"), position: SCNVector3(1.2, 0, 0))
        
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0, 0, 0.7))
        
        let earthMoon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon surface"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.3,0.15,0))
        
        let venusMoon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon surface"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.3,0.15,0))
        
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        earth.addChildNode(earthMoon)
        venus.addChildNode(venusMoon)
        
//        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 20)
//        let forever = SCNAction.repeatForever(action)
        let sunRotation = getRotateAction(x: 0, y: 360, z: 0, duration: 20)
        let earthRotation = getRotateAction(x: 0, y: 360, z: 0, duration: 13)
        let venusRotation = getRotateAction(x: 0, y: 360, z: 0, duration: 6)
        let earthParentRotation = getRotateAction(x: 0, y: 360, z: 0, duration: 17)
        let venusParentRotation = getRotateAction(x: 0, y: 360, z: 0, duration: 10)
        
        sun.runAction(sunRotation)
        
//        let actionEarth = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
//        let foreverEarth = SCNAction.repeatForever(actionEarth)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        earth.runAction(earthRotation)
        venus.runAction(venusRotation)
    }
    
    func getRotateAction(x: Int, y: Int, z: Int, duration: TimeInterval) -> SCNAction {
        let action = SCNAction.rotateBy(x: CGFloat(x.degreesToRadians), y: CGFloat(y.degreesToRadians), z: CGFloat(x.degreesToRadians), duration: duration)
        let forever = SCNAction.repeatForever(action)
        
        return forever
    }
    func planet(geometry: SCNGeometry, diffuse: UIImage?, specular: UIImage?, emission: UIImage?,
                normal: UIImage?, position: SCNVector3) -> SCNNode{
        let node = SCNNode(geometry: geometry)
        node.geometry?.firstMaterial?.diffuse.contents = diffuse
        node.geometry?.firstMaterial?.specular.contents = specular
        node.geometry?.firstMaterial?.emission.contents = emission
        node.geometry?.firstMaterial?.normal.contents = normal
        node.position = position
        
        return node
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180 }
}
