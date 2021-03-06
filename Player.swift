import SpriteKit

struct ColliderType
{
    static let Player: UInt32 = 0
    static let Cloud: UInt32 = 1
    static let DarkCloudAndCollectables: UInt32 = 2
}

class Player: SKSpriteNode
{
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animetePlayerAction = SKAction()
    
    private var lastY = CGFloat()
    
    func initializePlayerAnimation()
    {
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        for i in 2...textureAtlas.textureNames.count
        {
            let name = "Player \(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        animetePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 5))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Cloud
        self.physicsBody?.contactTestBitMask = ColliderType.DarkCloudAndCollectables
        
        lastY = self.position.y
    }
    
    func animatePlayer(moveLeft: Bool)
    {
        if moveLeft
        {
            self.xScale = -fabs(self.xScale)
        }
        else
        {
            self.xScale = fabs(self.xScale)
        }
        
        self.run(SKAction.repeatForever(animetePlayerAction), withKey: "Animate")
    }
    
    func stopPlayerAnimation()
    {
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
    }
    
    func movePlayer(moveLeft: Bool)
    {
        if moveLeft
        {
            self.position.x = self.position.x - 10
        }
        else
        {
            self.position.x = self.position.x + 10
        }
    }
    
    func setScore()
    {
        if self.position.y < lastY
        {
            GameplayController.instance.incrementScore()
            lastY = self.position.y
        }
    }
    
}




