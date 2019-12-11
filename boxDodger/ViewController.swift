//
//  ViewController.swift
//  boxDodger
//
//  Created by Jaeson Booker on 12/10/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var xPosition = 0.001
    var yPosition = 0.001
    var startingPosition = 0.001
    var velocity = 0.001
    var movement = 0.001
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        createBlockPosition(position: SCNVector3(xPosition,yPosition,movement))
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func createBlockPosition(position: SCNVector3){
        var block = SCNBox(width: 5.0, height: 5.0, length: 10.0, chamferRadius: 0.1)
        var boxNode = SCNNode(geometry: block)
        boxNode.position = position
        sceneView.scene.rootNode.addChildNode(boxNode)
        addAnimation(node: boxNode)
    }
    
    func createBlock(){
        //yPosition = RandomNumberGenerator
        //xPosition = RandomNumberGenerator
        createBlockPosition(position: SCNVector3(xPosition,yPosition,startingPosition))
    }
    
    func addAnimation(node: SCNNode) {
        let rotateOne = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(velocity), duration: 5.0)
        SCNAction.move(by: SCNVector3(0.0001,0.0001,velocity), duration: 5.0)
        node.runAction(rotateOne)
    }
    
//    func boxCollision(box: SCNNode, player: AVPlayer) {
//        score -= 1
//    }
    
    func update(){
        movement = startingPosition + velocity
        //if box and player collide {
        //  score -= 1
        //  movement = 0.001
        //}
        velocity += 0.0001
    }

    // MARK: - ARSCNViewDelegate
    
     //Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        if let camera = sceneView.session.currentFrame?.camera {
//            didInitializeScene = true
            let transform = camera.transform
            let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            //ViewController.makeUpdateCameraPos(towards: position)
        }
        
        let node = SCNNode()
     
        return node
    }
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
