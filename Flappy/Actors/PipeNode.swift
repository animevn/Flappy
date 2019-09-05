import SpriteKit

class PipeNode{
    
    private let gap:CGFloat = 50
    
    private var centerY:CGFloat
    private var topImg:String
    private var bottomImg:String
    private var xPosition:CGFloat
    private var zPosition:CGFloat
    private var duration:TimeInterval
    private var parentNode:SKSpriteNode
    private var pipeNode = SKSpriteNode()
    
    private func createTopPipe()->SKSpriteNode{
        let topPipe = SKSpriteNode(imageNamed: topImg)
        topPipe.size = CGSize(width: screenSize().x/5, height: topPipe.size.height)
        topPipe.position = CGPoint(x: 0, y: centerY + gap + topPipe.size.height/2)
        return topPipe
    }
    
    private func createBottomPipe()->SKSpriteNode{
        let bottomPipe = SKSpriteNode(imageNamed: bottomImg)
        bottomPipe.size = CGSize(width: screenSize().x/5, height: bottomPipe.size.height)
        bottomPipe.position = CGPoint(x: 0, y: centerY - gap - bottomPipe.size.height/2)
        return bottomPipe
    }
    
    private func createPipeNode(){
        pipeNode.addChild(createTopPipe())
        pipeNode.addChild(createBottomPipe())
        pipeNode.position.x = xPosition
        pipeNode.zPosition = zPosition
        parentNode.addChild(pipeNode)
    }
    
    init(topImg:String, bottomImg:String, parentNode:SKSpriteNode, xPosition:CGFloat,
         zPosition:CGFloat, centerY:CGFloat, duration:TimeInterval){
        
        self.topImg = topImg
        self.bottomImg = bottomImg
        self.parentNode = parentNode
        self.xPosition = xPosition
        self.zPosition = zPosition
        self.duration = duration
        self.centerY = centerY
        
        createPipeNode()
    }
    
    func start(){
        pipeNode.run(SKAction.sequence([
            SKAction.moveTo(x: -screenSize().x/10, duration: duration),
            SKAction.removeFromParent()
            ]))
    }
    
}
