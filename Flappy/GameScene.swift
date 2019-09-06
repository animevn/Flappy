import SpriteKit

class GameScene: SKScene {
    
    private var gameNode:SKSpriteNode!
    private var sky:Sky!
    private var city:City!
    private var bird:Bird!
    private var pipes:Pipes!
    private var ground:Ground!
    private var actors = [ActorsController]()
    private var flap:Player?
    private var punch:Player?
    private var yeah:Player?
    
    var viewController:UIViewController?
    var restart:(()->Void)?
    var quit:(()->Void)?
    
    private func prepareSound(){
        
        do{
            flap = try Player(filename: "flap", type: "wav", loop: 0)
            punch = try Player(filename: "punch", type: "wav", loop: 0)
            yeah = try Player(filename: "yeah", type: "mp3", loop: 0)
        }catch let error{
            print(error)
        }
    }
    
    private func createPhysicsWorld(){
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.physicsWorld.gravity = CGVector(dx: 0, dy: -3)
            self.isUserInteractionEnabled = true
        })
    }
    
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
        prepareSound()
        createPhysicsWorld()
        createView()
        createActors()
        addActorsToList()
        startActors()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.flap()
        flap?.play()
    }
    
    override func update(_ currentTime: TimeInterval) {
        bird.update()
    }
}

extension GameScene:SKPhysicsContactDelegate{
    
    private func createAlert(){
        let alert = UIAlertController(title: "Ouch!!!",
                                      message: "Would you play again?",
                                      preferredStyle: .alert)
        let actionOK = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {action in self.restart!()})
        
        let actionCancel = UIAlertAction(
            title: "Cancel",
            style: .default,
            handler: {action in
            self.quit!()
        })
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collide = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collide == BodyType.bird.rawValue | BodyType.ground.rawValue
            || collide == BodyType.bird.rawValue | BodyType.pipe.rawValue{
            punch?.play()
            stopActors()
            gameNode.run(SKAction.shake(duration: 1, impactX: 20, impactY: 20))
            createAlert()
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let collide = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collide == BodyType.bird.rawValue | BodyType.gap.rawValue{
            print("one point")
        }
    }
}
