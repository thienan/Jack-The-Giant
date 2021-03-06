import SpriteKit

class CollectableController
{
    func getCollectable() -> SKSpriteNode
    {
        var collectable = SKSpriteNode()
        
        let intRandon = Int(randomBetweenNumbers(firstNum: 0, secondNum: 7))
        
        if intRandon >= 4
        {
            if GameplayController.instance.life! < 2
            {
                collectable = SKSpriteNode(imageNamed: "Life")
                collectable.name = "Life"
                collectable.physicsBody = SKPhysicsBody(rectangleOf: collectable.size)
            }
            else
            {
                collectable.name = "Empty"
            }
        }
        else
        {
            collectable = SKSpriteNode(imageNamed: "Coin")
            collectable.name = "Coin"
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
        }
        
        collectable.physicsBody?.affectedByGravity = false
        collectable.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectables
        collectable.physicsBody?.collisionBitMask = ColliderType.Player
        collectable.zPosition = 3
        
        return collectable
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
