//
//  ViewController.swift
//  Hit Test
//
//  Created by saket arya on 7/25/18.
//  Copyright © 2018 saket arya. All rights reserved.
//

import UIKit
import ARKit
import Each
class ViewController: UIViewController {

    var timer = Each(1).seconds
    var countdown = 10
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var play: UIButton!
    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        self.sceneView.session.run(configuration)
        
        // Do any additional setup after loading the view, typically from a nib.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(_ sender: Any) {
        self.addNode()
        self.setTimer()
        self.play.isEnabled = false
    }
    
    @IBAction func reset(_ sender: Any) {
    }
    
    func addNode() {
        let jellyfishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let jellyfishNode = jellyfishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        let x = self.randomNumbers(firstnum: -1, secondnum: 1)
        let y = self.randomNumbers(firstnum: -0.5, secondnum: 0.5)
        let z = self.randomNumbers(firstnum: -1, secondnum: 1)
        
        jellyfishNode?.position = SCNVector3(x, y, z)
        
        self.sceneView.scene.rootNode.addChildNode(jellyfishNode!)
        
//        let node = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        
//        node.position = SCNVector3(0,0,-1)
//        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if hitTest.isEmpty {
            print("did not touch anything")
        }
        else{
            let results = hitTest.first!
//            let geometry = results.node.geometry
//            print(geometry)
            let node = results.node
            if node.animationKeys.isEmpty {
                SCNTransaction.begin()
                self.animateNode(node: node)
                SCNTransaction.completionBlock = {
                    node.removeFromParentNode()
                    self.addNode()
                }

                SCNTransaction.commit()
            }
        }
    }
    
    func animateNode(node: SCNNode){
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = node.presentation.position
        spin.toValue = SCNVector3(node.presentation.position.x - 0.2,
                                  node.presentation.position.x - 0.2,
                                  node.presentation.position.z - 0.2)
        spin.duration = 0.07
        spin.autoreverses = true
        spin.repeatCount = 5
        node.addAnimation(spin, forKey: "position")
    }
    
    func randomNumbers(firstnum: CGFloat, secondnum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstnum - secondnum) + min(firstnum, secondnum)
        
    }
    
    func setTimer() {
        self.timer.perform { () -> NextStep in
            self.countdown -= 1
            self.timerLabel.text = String(self.countdown)
        }
    }
    
}

