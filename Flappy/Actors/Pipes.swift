import SpriteKit

class Pipes:ActorsController{
   
    private var parentNode:SKSpriteNode
    private var topImg:String
    private var bottomImg:String
    private var zPosition:CGFloat
    private var duration:TimeInterval
    private var durationForNewPipe:TimeInterval
    
    private var pipes = SKSpriteNode()
    
    init(topImg:String, bottomImg:String, parentNode:SKSpriteNode, zPosition:CGFloat,
         duration:TimeInterval, durationForNewPipe:TimeInterval){
        self.topImg = topImg
        self.bottomImg = bottomImg
        self.parentNode = parentNode
        self.zPosition = zPosition
        self.duration = duration
        self.durationForNewPipe = durationForNewPipe
        parentNode.addChild(pipes)
    }
    
    private func createPipes(){
        let centerY = parentNode.size.height/2 - CGFloat(arc4random_uniform(10)*20) + 100
        let node = PipeNode(
            topImg: topImg,
            bottomImg: bottomImg,
            parentNode: pipes,
            xPosition: screenSize().x + screenSize().x/10,
            zPosition: zPosition,
            centerY: centerY,
            duration: duration)
        node.start()
    }
    
    func start() {
        pipes.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run({self.createPipes()}),
            SKAction.wait(forDuration: self.durationForNewPipe)
            ])))
    }
    
    func stop() {
        pipes.removeAllActions()
        for pipe in pipes.children {
            pipe.removeAllActions()
        }
    }
}
