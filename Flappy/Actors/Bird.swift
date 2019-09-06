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
        bird.physicsBody = SKPhysicsBody.body(size: bird.size, complete: {
            $0.affectedByGravity = true
            $0.isDynamic = true
            $0.categoryBitMask = BodyType.bird.rawValue
            $0.collisionBitMask = BodyType.bird.rawValue
            $0.contactTestBitMask = BodyType.pipe.rawValue | BodyType.ground.rawValue
                                    | BodyType.gap.rawValue
        })
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
        bird.physicsBody?.isDynamic = false
    }
    
    func update(){
        guard let dy = bird.physicsBody?.velocity.dy else {return}
        switch dy{
        case let dy where dy > 30:
            bird.zRotation = CGFloat.pi/4
        case dy where dy < -100:
            bird.zRotation = -CGFloat.pi/3
        default:
            return
        }
    }
    
    func flap(){
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 8))
    }
}
