import SpriteKit

class Ground:ActorsController{
    
    private var image:String
    private var parentNode:SKSpriteNode
    private var zPosition:CGFloat
    private var duration:TimeInterval
    
    private var ground = SKSpriteNode()
    
    private func createLeftNode()->SKSpriteNode{
        let node = SKSpriteNode(imageNamed: image)
        node.size = CGSize(width: parentNode.size.width, height: parentNode.size.height * 1/8)
        node.position = CGPoint(x: parentNode.size.width/2, y: parentNode.size.height * 1/16)
        node.blendMode = .replace
        return node
    }
    
    private func createRightNode()->SKSpriteNode{
        let node = SKSpriteNode(imageNamed: image)
        node.size = CGSize(width: parentNode.size.width, height: parentNode.size.height * 1/8)
        node.position = CGPoint(x: parentNode.size.width * 3/2, y: parentNode.size.height * 1/16)
        node.blendMode = .replace
        return node
    }
    
    private func createSkyNodeFromTwoHalfNodes(){
        let size = CGSize(width: parentNode.size.width * 2, height: parentNode.size.height)
        ground = SKSpriteNode(color: .clear, size: size)
        ground.anchorPoint = CGPoint(x: 0, y: 0)
        ground.position = CGPoint(x: 0, y: 0)
        ground.addChild(createLeftNode())
        ground.addChild(createRightNode())
    }
    
    private func addSkyToParent(){
        parentNode.addChild(ground)
        ground.zPosition = zPosition
    }
    
    init(image:String, parentNode:SKSpriteNode, zPosition:CGFloat, duration:TimeInterval){
        self.image = image
        self.parentNode = parentNode
        self.zPosition = zPosition
        self.duration = duration
        createSkyNodeFromTwoHalfNodes()
        addSkyToParent()
    }
    
    func start() {
        ground.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.moveTo(x: -parentNode.size.width, duration: duration),
            SKAction.moveTo(x: 0, duration: 0)
            ])))
    }
    
    func stop() {
        ground.removeAllActions()
    }
    
}
