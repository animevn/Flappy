import SpriteKit

class City:ActorsController{
    
    private var image:String
    private var parentNode:SKSpriteNode
    private var zPosition:CGFloat
    private var duration:TimeInterval
    
    private var city = SKSpriteNode()
    
    
    private func createLeftNode()->SKSpriteNode{
        let node = SKSpriteNode(imageNamed: image)
        node.size = CGSize(width: parentNode.size.width, height: parentNode.size.height * 4.5/8)
        node.anchorPoint = CGPoint(x: 0, y: 0)
        node.position = CGPoint(x: 0, y: parentNode.size.height * 1/8)
        return node
    }
    
    private func createRightNode()->SKSpriteNode{
        let node = SKSpriteNode(imageNamed: image)
        node.size = CGSize(width: parentNode.size.width, height: parentNode.size.height * 4.5/8)
        node.anchorPoint = CGPoint(x: 0, y: 0)
        node.position = CGPoint(x: parentNode.size.width, y: parentNode.size.height * 1/8)
        return node
    }
    
    private func createSkyNodeFromTwoHalfNodes(){
        let size = CGSize(width: parentNode.size.width * 2, height: parentNode.size.height)
        city = SKSpriteNode(color: .clear, size: size)
        city.anchorPoint = CGPoint(x: 0, y: 0)
        city.position = CGPoint(x: 0, y: 0)
        city.addChild(createLeftNode())
        city.addChild(createRightNode())
    }
    
    private func addSkyToParent(){
        parentNode.addChild(city)
        city.zPosition = zPosition
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
        city.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.moveTo(x: -parentNode.size.width, duration: duration),
            SKAction.moveTo(x: 0, duration: 0)
            ])))
    }
    
    func stop() {
        city.removeAllActions()
    }
    
}
