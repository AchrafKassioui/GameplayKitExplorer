//
//  Basic.swift
//  GameplayKitExplorer
//
//  Created by Achraf Kassioui on 24/10/2024.
//

import GameplayKit
import SwiftUI
import SpriteKit

struct BasicView: View {
    var body: some View {
        SpriteView(scene: BasicScene())
            .ignoresSafeArea()
    }
}

#Preview {
    BasicView()
}

class BasicScene: SKScene {
    override func didMove(to view: SKView) {
        size = view.bounds.size
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = .gray
        view.isMultipleTouchEnabled = true
        
        let entity = BasicEntity(color: .systemYellow, size: CGSize(width: 100, height: 100))
        if let renderComponent = entity.component(ofType: BasicRenderComponent.self) {
            addChild(renderComponent.sprite)
        }
    }
}

@MainActor
class BasicEntity: GKEntity {
    init(color: SKColor, size: CGSize) {
        super.init()
        
        let renderComponent = BasicRenderComponent(color: color, size: size)
        addComponent(renderComponent)
        
        let animationComponent = BasicAnimationComponent()
        addComponent(animationComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@MainActor
class BasicRenderComponent: GKComponent {
    let sprite: SKSpriteNode
    
    init(color: SKColor, size: CGSize) {
        self.sprite = SKSpriteNode(texture: nil, color: color, size: size)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BasicAnimationComponent: GKComponent {
    let action1 = SKAction.scale(to: 1.3, duration: 0.07)
    let action2 = SKAction.scale(to: 1, duration: 0.15)
    
    override init() {
        super.init()
    }

    override func didAddToEntity() {
        if let renderComponent = entity?.component(ofType: BasicRenderComponent.self) {
            renderComponent.sprite.run(SKAction.repeatForever(SKAction.sequence([action1, action2])))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
