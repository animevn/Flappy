import UIKit
import SpriteKit

class GameController: UIViewController {
    
    private func createView(){
        let skView = view as! SKView
        let scene = GameScene(size: skView.frame.size)
        scene.scaleMode = .aspectFill
        scene.viewController = self
        scene.restart = { [weak self] in self?.createView()}
        scene.quit = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            skView.presentScene(nil)
        }
        skView.showsFPS = true
        skView.ignoresSiblingOrder = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        skView.presentScene(scene)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
