import SpriteKit

class Bird:ActorsController{
   
    private var parentNode:SKSpriteNode
    private var images:[String]
    private var zPosition:CGFloat
    private var position:CGPoint
    
    private var bird = SKSpriteNode()
    private var textures = [SKTexture]()
    
    private func createTextures(){
        textures = images.map{
            return SKTexture(imageNamed: $0)
        }
    }
    
    private func createBird(){
        bird = SKSpriteNode(imageNamed: images.first!)
        bird.position = position
        bird.zPosition = zPosition
        parentNode.addChild(bird)
    }
    
    init(images:[String], parentNode:SKSpriteNode, position:CGPoint, zPosition:CGFloat){
        self.parentNode = parentNode
        self.images = images
        self.position = position
        self.zPosition = zPosition
        
        createBird()
        createTextures()
    }
    
    func start() {
        bird.run(SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.3)))
        
    }
    
    func stop() {
        bird.removeAllActions()
    }
}
