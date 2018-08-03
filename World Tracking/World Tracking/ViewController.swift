//
//  ViewController.swift
//  World Tracking
//
//  Created by saket arya on 7/23/18.
//  Copyright © 2018 saket arya. All rights reserved.
//
extension Int {
    var degreeToRadians: Double { return Double(self) * .pi/180 }
}

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
        self.sceneView.autoenablesDefaultLighting = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func add(_ sender: Any) {
        
        // self.buildAHouse()
        // self.buildABezierPath()
        // self.rotateAPyramid()
        self.relativeRotation()
    }
    
    @IBAction func reset(_ sender: Any) {
        self.resetTracking()
    }
    
    func resetTracking(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes{ (node, _) in
            node.removeFromParentNode()
        }
    
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbrs(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func rotateAPyramid(){
        let node = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.position = SCNVector3(0.05, 0.05, -0.05)
        node.eulerAngles = SCNVector3(Float(180.degreeToRadians), 0, 0)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    func relativeRotation(){
        let sunNode = SCNNode(geometry: SCNSphere(radius: 0.1) )
        let earthNode = SCNNode(geometry: SCNSphere(radius: 0.07))
        let moonNode = SCNNode(geometry: SCNSphere(radius: 0.03))
        sunNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        earthNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        moonNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        
        sunNode.position = SCNVector3(0.05, 0.05, -0.15)
        earthNode.position = SCNVector3(-0.21, 0, -0.21)
        moonNode.position = SCNVector3(-0.11, 0.11, -0.11)
        
        sunNode.eulerAngles = SCNVector3(0, Float(-60.degreeToRadians), 0)
        self.sceneView.scene.rootNode.addChildNode(sunNode)
        sunNode.addChildNode(earthNode)
        earthNode.addChildNode(moonNode)
        
    }
    
    func buildAHouse(){
        let node = SCNNode()
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01))
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.05, height: 0.05))
        
        
        // Adding bezier path
        //        let path = UIBezierPath()
        //        path.move(to: CGPoint(x:0, y:0))
        //        path.addLine(to: CGPoint(x:0, y:0.2))
        //        path.addLine(to: CGPoint(x:0.7, y:0.7))
        //        path.addLine(to: CGPoint(x:1, y:0.1))
        //        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        //        node.geometry = shape
        
        // adding Sphere
        //        let g = SCNSphere(radius: 0.1)
        //        g.isGeodesic = true
        //        node.geometry = g
        //node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        //        let x = randomNumbrs(firstNum: -0.3, secondNum: 0.3)
        //        let y = randomNumbrs(firstNum: -0.3, secondNum: 0.3)
        //        let z = randomNumbrs(firstNum: -0.3, secondNum: 0.3)
        
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        
        // define position of your object from origin
        node.position = SCNVector3(0.2,0.3,-0.2)
        boxNode.position = SCNVector3(0,-0.05,0)
        doorNode.position = SCNVector3(0,0,0.05)
        
        
        self.sceneView.scene.rootNode.addChildNode(node)
        
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
    }
    
    func buildABezierPath(){
        let node = SCNNode()
        
         //Adding bezier path
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0, y:0))
        path.addLine(to: CGPoint(x:0, y:0.2))
        path.addLine(to: CGPoint(x:0.7, y:0.7))
        path.addLine(to: CGPoint(x:1, y:0.1))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        // define position of your object from origin
        node.position = SCNVector3(0.2,0.3,-0.2)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    
}

