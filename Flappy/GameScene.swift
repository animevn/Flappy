import SpriteKit

class GameScene: SKScene {
    
    private var gameNode:SKSpriteNode!
    private var sky:Sky!
    private var city:City!
    private var bird:Bird!
    private var pipes:Pipes!
    private var ground:Ground!
    
    private func createView(){
        gameNode = SKSpriteNode(color: .clear, size: scene!.size)
        gameNode.anchorPoint = CGPoint(x: 0, y: 0)
        gameNode.position = CGPoint(x: 0, y: 0)
        addChild(gameNode)
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .green
        createView()
        
        sky = Sky(image: "sky", parentNode: gameNode, zPosition: 0, duration: 150)
        sky.start()
        
        city = City(image: "city", parentNode: gameNode, zPosition: 1, duration: 90)
        city.start()
        
        bird = Bird(images: ["bird1", "bird2"], parentNode: gameNode,
                    position: CGPoint(x: screenSize().x/4, y: screenSize().y * 3/4) , zPosition: 2)
        bird.start()
        
        pipes = Pipes(topImg: "topPipe", bottomImg: "bottomPipe", parentNode: gameNode,
                      zPosition: 3, duration: 6, durationForNewPipe: 3.3)
        pipes.start()
        
        ground = Ground(image: "ground", parentNode: gameNode, zPosition: 4, duration: 5)
        ground.start()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
