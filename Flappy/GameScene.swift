import SpriteKit

class GameScene: SKScene {
    
    private var gameNode:SKSpriteNode!
    private var sky:Sky!
    private var city:City!
    private var bird:Bird!
    private var pipes:Pipes!
    private var ground:Ground!
    private var actors = [ActorsController]()
    
    
    private func createView(){
        gameNode = SKSpriteNode(color: .clear, size: scene!.size)
        gameNode.anchorPoint = CGPoint(x: 0, y: 0)
        gameNode.position = CGPoint(x: 0, y: 0)
        addChild(gameNode)
    }
    
    private func createActors(){
        
        sky = Sky(image: "sky", parentNode: gameNode, zPosition: 0, duration: 150)
        city = City(image: "city", parentNode: gameNode, zPosition: 1, duration: 90)
        bird = Bird(images: ["bird1", "bird2"], parentNode: gameNode,
                    position: CGPoint(x: screenSize().x/4, y: screenSize().y * 3/4) , zPosition: 2)
        pipes = Pipes(topImg: "topPipe", bottomImg: "bottomPipe", parentNode: gameNode,
                      zPosition: 3, duration: 6, durationForNewPipe: 3.3)
        ground = Ground(image: "ground", parentNode: gameNode, zPosition: 4, duration: 5)
    }
    
    private func addActorsToList(){
        actors = [sky, city, bird, pipes, ground]
    }
    
    private func startActors(){
        actors.forEach{$0.start()}
    }
    
    private func stopActors(){
        actors.forEach{$0.stop()}
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .green
        createView()
        createActors()
        addActorsToList()
        startActors()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
