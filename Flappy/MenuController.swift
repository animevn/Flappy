import UIKit

class MenuController:UIViewController{
    
    private var theme:MediaPlayer?
    
    private func prepareThemeSound(){
        do{
            theme = try MediaPlayer(filename: "theme", type: "mp3", loop: -1)
        }catch let error{
            print(error)
        }
    }
    
    private func createButton(title:String, color:UIColor, center:CGPoint, action:Selector){
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: screenSize().x/2.5, height: screenSize().y/10)
        button.center = center
        button.setTitle(title, for: .normal)
        button.setBackgroundImage(UIImage(named: "bnNormal"), for: .normal)
        button.setBackgroundImage(UIImage(named: "bnHighlight"), for: .highlighted)
        button.setTitleColor(color, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.addTarget(self, action: action, for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func playGame(){
        performSegue(withIdentifier: "open", sender: self)
    }
    
    @objc private func gameCenter(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        prepareThemeSound()
        
        createButton(
            title: "PLAY",
            color: .blue,
            center: CGPoint(x: screenSize().x/2, y: screenSize().y * 1/3),
            action: #selector(playGame))
        
        createButton(
            title: "Game Center",
            color: .black,
            center: CGPoint(x: screenSize().x/2, y: screenSize().y * 2/3),
            action: #selector(gameCenter))
        theme?.play()
    }
}



