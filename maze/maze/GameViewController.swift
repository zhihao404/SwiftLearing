//
//  GameViewController.swift
//  maze
//
//  Created by Zhihao Miao on 2022/12/30.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    
    enum Direction {
        case up, down, left, right

        var dx: Int {
            switch self {
            case .up:
                return 0
            case .down:
                return 0
            case .left:
                return -1
            case .right:
                return 1
            }
        }

        var dy: Int {
            switch self {
            case .up:
                return -1
            case .down:
                return 1
            case .left:
                return 0
            case .right:
                return 0
            }
        }
    }

    struct Tank {
        let id: Int
        var x: Int
        var y: Int
        var direction: Direction
        var destroyed: Bool

        mutating func move() {
            x += direction.dx
            y += direction.dy
        }

        func canMove(toX x: Int, toY y: Int, width: Int, height: Int) -> Bool {
            return x >= 0 && x < width && y >= 0 && y < height
        }
    }

    struct Game {
        let width: Int
        let height: Int
        var playerTank: Tank
        var computerTank: Tank
        var bullets: [(Int, Int)]

        init(width: Int, height: Int) {
            self.width = width
            self.height = height
            playerTank = Tank(id: 1, x: 1, y: 1, direction: .up, destroyed: false)
            computerTank = Tank(id: 2, x: width - 2, y: height - 2, direction: .down, destroyed: false)
                        bullets = []
                    }

                    mutating func play() {
                        while !playerTank.destroyed && !computerTank.destroyed {
                            // プレイヤーのターンの処理
                            print("Enter a command (up, down, left, right, fire):")
                            let input = readLine()
                            if input == "up" {
                                playerTank.direction = .up
                            } else if input == "down" {
                                playerTank.direction = .down
                            } else if input == "left" {
                                playerTank.direction = .left
                            } else if input == "right" {
                                playerTank.direction = .right
                            } else if input == "fire" {
                                // 砲弾の発射処理
                                let x = playerTank.x + playerTank.direction.dx
                                let y = playerTank.y + playerTank.direction.dy
                                bullets.append((x, y))
                            }
                            playerTank.move()
                            if !playerTank.canMove(toX: playerTank.x, toY: playerTank.y, width: width, height: height) {
                                playerTank.x -= playerTank.direction.dx
                                playerTank.y -= playerTank.direction.dy
                            }

                            // コンピュータのターンの処理
                            var dx = computerTank.x - playerTank.x
                            var dy = computerTank.y - playerTank.y
                            if dx > 0 {
                                computerTank.direction = .left
                            } else if dx < 0 {
                                computerTank.direction = .right
                            } else if dy > 0 {
                                computerTank.direction = .up
                            } else if dy < 0 {
                                computerTank.direction = .down
                            }
                            computerTank.move()
                            if !computerTank.canMove(toX: computerTank.x, toY: computerTank.y, width: width, height: height) {
                                computerTank.x -= computerTank.direction.dx
                                computerTank.y -= computerTank.direction.dy
                            }

                            // 砲弾の処理
                            var newBullets: [(Int, Int)] = []
                            for (var x, var y) in bullets {
                                x += playerTank.direction.dx
                                y += playerTank.direction.dy
                                if x >= 0 && x < width && y >= 0 && y < height {
                                    newBullets.append((x, y))
                                    if x == computerTank.x && y == computerTank.y {
                                        computerTank.destroyed = true
                                        print("Computer tank destroyed!")
                                    }
                                }
                            }
                            bullets = newBullets
                        }
                        if playerTank.destroyed {
                            print("Computer won!")
                        } else {
                            print("Player won!")
                        }
                    }
                }

                var game = Game(width: 10, height: 10)
    game.play()



    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
