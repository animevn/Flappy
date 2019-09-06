import SpriteKit
import AVFoundation

enum PlayerError:Error{
    case LoadError
}

class Player{
    
    private var player:AVAudioPlayer
    
    init(filename:String, type:String, loop:Int)throws{
        
        guard let resource = Bundle.main.path(forResource: filename, ofType: type) else {
            throw PlayerError.LoadError
        }
        let url = URL(fileURLWithPath: resource)
        player = try AVAudioPlayer(contentsOf: url)
        player.numberOfLoops = loop
        player.prepareToPlay()
    }
    
    func play(){
        player.play()
    }
    
    func stop(){
        player.stop()
    }
}

protocol ActorsController{
    func start()
    func stop()
}

enum BodyType:UInt32{
    case bird = 0b0001
    case pipe = 0b0010
    case ground = 0b0100
    case gap = 0b1000
}

extension SKPhysicsBody{
    class func body(size:CGSize, complete:@escaping (SKPhysicsBody)->Void)->SKPhysicsBody{
        let body = SKPhysicsBody(rectangleOf: size)
        complete(body)
        return body
    }
}

extension SKAction{
    class func shake(duration:CGFloat, impactX:Int, impactY:Int)->SKAction{
        let numberOfShakes = Int(duration/0.01/2)
        var actionList = [SKAction]()
        
        (1...numberOfShakes).forEach{_ in
            let x = CGFloat(Int(arc4random_uniform(UInt32(impactX))) - impactX/2)
            let y = CGFloat(Int(arc4random_uniform(UInt32(impactY))) - impactY/2)
            let forward = SKAction.moveBy(x: x, y: y, duration: 0.01)
            let backward = forward.reversed()
            actionList.append(forward)
            actionList.append(backward)
        }
        return SKAction.sequence(actionList)
    }
}

func screenSize()->(x:CGFloat, y:CGFloat, centerX:CGFloat, centerY:CGFloat){
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let center = CGPoint(x: width/2, y: height/2)
    
    switch (width, height) {
        
    //XSMax, XR portrait : status bar = 44, bottom bar = 34
    case (414, 896):
        //        print("XSMax, XR")
        return (414, 896 - 44 - 34, center.x, center.y + 22 - 17)
        
    //X, XS portrait : status bar = 44, bottom bar = 34
    case (375, 812):
        //        print("X, XS")
        return (375, 812 - 44, center.x, center.y + 22 - 17)
        
    //6 Plus, 6S Plus, 7 Plus, 8 Plus portrait : status bar = 18
    case (414, 736):
        //        print("6 Plus, 6s Plus, 7 Plus, 8 Plus")
        return (414, 736 - 18, center.x, center.y + 9)
        
    //6, 6S, 7, 8 portrait : status bar = 20
    case (375, 667):
        //        print("6, 6s, 7, 8")
        return (375, 667 - 20, center.x, center.y + 10)
        
    //SE portrait : status bar = 20
    case (320, 568):
        //      print("SE")
        return (320, 568 - 20, center.x, center.y + 10)
        
    //default value which never used
    default:
        //      print("default")
        return (width, height - 50, center.x, center.y + 25)
    }
}



