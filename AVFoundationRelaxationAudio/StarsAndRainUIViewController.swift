//
//  StarsAndRainUIView.swift
//  AVFoundationRelaxationAudio
//
//  Created by admin on 28/12/2021.
//

import UIKit
import SpriteKit

class StarsAndRainUIViewController: UIViewController {

    let starsView = SKView()
    let rainView = SKView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        createStarLayers()
        createRainLayers()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //Creates a new star field
    func shapefieldEmitterNode(text: String, speed: CGFloat, lifetime: CGFloat, scale: CGFloat, birthRate: CGFloat, color: SKColor, twinklesColor: SKColor) -> SKEmitterNode {
        let shape = SKLabelNode(fontNamed: "Helvetica")
        shape.fontSize = 100
        shape.text = text
        let textureView = SKView()
        let texture = textureView.texture(from: shape)
        texture!.filteringMode = .nearest

        let emitterNode = SKEmitterNode()
        emitterNode.particleTexture = texture
        emitterNode.particleBirthRate = birthRate
        emitterNode.particleColor = color
        emitterNode.particleLifetime = lifetime
        emitterNode.particleSpeed = speed
        emitterNode.particleScale = scale
        emitterNode.particleColorBlendFactor = 1
        emitterNode.position = CGPoint(x: view.frame.midX, y: view.frame.maxY)
        emitterNode.particlePositionRange = CGVector(dx: view.frame.maxX, dy: 0)
        emitterNode.particleSpeedRange = 16.0

        //Rotates the shape
        emitterNode.particleAction = SKAction.repeatForever(SKAction.sequence([
            SKAction.rotate(byAngle: CGFloat(-.pi / 4.0), duration: 1),
            SKAction.rotate(byAngle: CGFloat(Double.pi / 4), duration: 1)]))

        //Causes the shape to twinkle
        let twinkles = 20
        let colorSequence = SKKeyframeSequence(capacity: twinkles*2)
        let twinkleTime = 1.0 / CGFloat(twinkles)
        for i in 0..<twinkles {
            colorSequence.addKeyframeValue(SKColor.white,time: CGFloat(i) * 2 * twinkleTime / 2)
            colorSequence.addKeyframeValue(twinklesColor, time: (CGFloat(i) * 2 + 1) * twinkleTime / 2)
        }
        emitterNode.particleColorSequence = colorSequence

        emitterNode.advanceSimulationTime(TimeInterval(lifetime))
        return emitterNode
    }
    
    func createStarLayers() {
        let scene = SKScene()
        scene.backgroundColor = .clear
        
        //A layer of a star field
        let starfieldNode = SKNode()
        starfieldNode.name = "starfieldNode"
        starfieldNode.addChild(shapefieldEmitterNode(text: "✦", speed: -48, lifetime: self.view.frame.height / 23, scale: 0.2, birthRate: 1, color: SKColor.lightGray, twinklesColor: SKColor.yellow))
        scene.addChild(starfieldNode)
        scene.size = CGSize(width: view.frame.width, height:  view.frame.height)

        //A second layer of stars
        var emitterNode = shapefieldEmitterNode(text: "✦", speed: -40, lifetime: self.view.frame.height / 10, scale: 0.14, birthRate: 2, color: SKColor.gray, twinklesColor: SKColor.blue)
        emitterNode.zPosition = -10
        starfieldNode.addChild(emitterNode)

        //A third layer
        emitterNode = shapefieldEmitterNode(text: "✦", speed: -20, lifetime: self.view.frame.height / 5, scale: 0.1, birthRate: 5, color: SKColor.darkGray, twinklesColor: SKColor.cyan)
        starfieldNode.addChild(emitterNode)
        
        starsView.presentScene(scene)
        starsView.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(starsView)
    }
    
    func createRainLayers() {
        let scene = SKScene()
        scene.backgroundColor = .clear
        
        //A layer of a rain field
        let starfieldNode = SKNode()
        starfieldNode.name = "starfieldNode2"
        starfieldNode.addChild(shapefieldEmitterNode(text: "|", speed: -148, lifetime: self.view.frame.height / 23, scale: 0.2, birthRate: 4, color: SKColor.lightGray, twinklesColor: SKColor.red))
        scene.addChild(starfieldNode)
        scene.size = CGSize(width: view.frame.width, height:  view.frame.height)

        //A second layer of rain
        var emitterNode = shapefieldEmitterNode(text: "|", speed: -300, lifetime: self.view.frame.height / 10, scale: 0.14, birthRate: 8, color: SKColor.gray, twinklesColor: SKColor.green)
        emitterNode.zPosition = -10
        starfieldNode.addChild(emitterNode)

        //A third layer
        emitterNode = shapefieldEmitterNode(text: "|", speed: -70, lifetime: self.view.frame.height / 5, scale: 0.1, birthRate: 20, color: SKColor.darkGray, twinklesColor: SKColor.orange)
        starfieldNode.addChild(emitterNode)
        
        rainView.presentScene(scene)
        rainView.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(rainView)
    }
}
