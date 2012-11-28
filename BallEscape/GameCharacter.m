//
//  GameCharacter.m
//  BallEscape
//
//  Created by Alberto Salido López on 27/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "GameCharacter.h"

//  Factor of bounding for the ball.
//  As greater is the factor, the ball becomes more elastic,
//  making longer bounds.
static float const BOUNDING_FACTOR = 0.4;

@interface GameCharacter ()

@property (nonatomic) GLKVector3 position;
@property (nonatomic) GLKVector3 velocity;
@property (nonatomic) GLfloat radius;
@property (nonatomic) float yawRadians;

//  Next position of the ball.
@property (nonatomic) GLKVector3 nextPosition;

//  Checks if a position, represented as a |GLKvector3| is inside
//  of another object, represented by its Bounding Box.
- (BOOL)isInsideOfObjectWithPosition:(GLKVector3)position 
                         boundingBox:(AGLKAxisAllignedBoundingBox)borders;

- (void)rotateAtBounce;

@end

@implementation GameCharacter

@synthesize position = _position;
@synthesize velocity = _velocity;
@synthesize radius = _radius;
@synthesize nextPosition = _nextPosition;
@synthesize yawRadians = _yawRadians;

- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
           velocity:(GLKVector3)velocity
         yawRadians:(float)radians
{
    if ((self = [super initWithModel:model position:position])
        != nil) {
        self.velocity = velocity;
        self.yawRadians = radians;
        
        //  Gets the bounding box of the object.
        AGLKAxisAllignedBoundingBox boundingBox = self.model.axisAlignedBoundingBox;
        
        //  Gets the size of the object in X and Z coordinates.
        float xSize = boundingBox.max.x - boundingBox.min.x;
        float zSize = boundingBox.min.z - boundingBox.min.z;
        
        //  The radius of the ball is the half of the widest diameter.
        self.radius = MAX(xSize, zSize) * 0.5;
    }
    return self;
}

- (void)bounceOffBorders:(AGLKAxisAllignedBoundingBox)borders
{
    //  Detects collisions with the four borders.
    //  Updates the velocity, as the ball was hitten, and sets up the nextPosition.
    //  The borders of the boardgame are defined by its height and width, starting in
    //  the 0,0 point. 
    
    float top = (borders.max.x - borders.min.x);
    float width = (borders.max.z - borders.min.z);
    
    //  Collision with the bottom:
    //  Checks if the next position plus the ball's radius (the equation has the
    //  '-' because it is checking the bottom) is lower than 0.
    if (self.nextPosition.x - self.radius < 0) {
        self.nextPosition = GLKVector3Make(self.radius,
                                           self.nextPosition.y, 
                                           self.nextPosition.z);
        self.velocity = GLKVector3Make(-self.velocity.x * BOUNDING_FACTOR,
                                       self.velocity.y,
                                       self.velocity.z);
    }
    
    //  Collision with the top:
    if (self.nextPosition.x + self.radius > top) {
        self.nextPosition = GLKVector3Make(top - self.radius,
                                           self.nextPosition.y,
                                           self.nextPosition.z);
        self.velocity = GLKVector3Make(-self.velocity.x * BOUNDING_FACTOR,
                                       self.velocity.y,
                                       self.velocity.z);
    }
    
    //  Collision with the left border:
    if (self.nextPosition.z - self.radius < 0) {
        self.nextPosition = GLKVector3Make(self.nextPosition.x,
                                           self.nextPosition.y,
                                           self.radius);
        self.velocity = GLKVector3Make(self.velocity.x,
                                       self.velocity.y,
                                       -self.velocity.z * BOUNDING_FACTOR);
    }
    
    //  Collision with the right border:
    if (self.nextPosition.z + self.radius > width) {
        self.nextPosition = GLKVector3Make(self.nextPosition.x,
                                           self.nextPosition.y,
                                           width - self.radius);
        self.velocity = GLKVector3Make(self.velocity.x,
                                       self.velocity.y,
                                       -self.velocity.z * BOUNDING_FACTOR);
    }
}

- (void)rotateAtBounce
{
    self.yawRadians += GLKMathDegreesToRadians(180);
}

- (BOOL)bounceOffWalls:(NSSet *)walls
{
    float height;
    float width;
    
    //  Detects a collision with any wall.
    for (Wall *currentWall in walls) {
        
        AGLKAxisAllignedBoundingBox  wallBBox = currentWall.boundingBox;
        
        //  It's sure that the ball is going to crash with the wall.
        //  Now have to check where are the ball and the wall
        //  for making the bound.
        if ([self isInsideOfObjectWithPosition:currentWall.position 
                                   boundingBox:wallBBox]) {
            
            if ([currentWall isADoor]) {
                return YES;
                break;
            }
            
            height = (wallBBox.max.x - wallBBox.min.x) / 2;
            width = (wallBBox.max.z - wallBBox.min.z) / 2;
            
            //  The Ball is under the wall.
            if ((self.position.x < currentWall.position.x - height) &&
                (self.position.z > currentWall.position.z - width) &&
                (self.position.z < currentWall.position.z + width)) {
                
                self.nextPosition = GLKVector3Make(currentWall.position.x - height - self.radius,
                                                   self.nextPosition.y,
                                                   self.nextPosition.z);
                self.velocity = GLKVector3Make(-self.velocity.x * BOUNDING_FACTOR,
                                               self.velocity.y,
                                               self.velocity.z);
            }
            
            //  The Ball is over the wall.
            if ((self.position.x > currentWall.position.x + height) &&
                (self.position.z > currentWall.position.z - width) &&
                (self.position.z < currentWall.position.z + width)) {
                
                self.nextPosition = GLKVector3Make(currentWall.position.x + height + self.radius,
                                                   self.nextPosition.y,
                                                   self.nextPosition.z);
                self.velocity = GLKVector3Make(-self.velocity.x * BOUNDING_FACTOR,
                                               self.velocity.y,
                                               self.velocity.z);
            }
            
            //  The Ball is on the left.
            if ((self.position.z < currentWall.position.z - width) &&
                (self.position.x > currentWall.position.x - height) &&
                (self.position.x < currentWall.position.x + height)) {
                
                self.nextPosition = GLKVector3Make(self.nextPosition.x,
                                                   self.nextPosition.y, 
                                                   currentWall.position.z - width - self.radius);
                self.velocity = GLKVector3Make(self.velocity.x,
                                               self.velocity.y,
                                               -self.velocity.z * BOUNDING_FACTOR);
            }
            
            //  The Ball is on the right.
            if ((self.position.z > currentWall.position.z + width) &&
                (self.position.x > currentWall.position.x - height) &&
                (self.position.x < currentWall.position.x + height)) {
                
                self.nextPosition = GLKVector3Make(self.nextPosition.x,
                                                   self.nextPosition.y, 
                                                   currentWall.position.z + width + self.radius);
                self.velocity = GLKVector3Make(self.velocity.x,
                                               self.velocity.y,
                                               -self.velocity.z * BOUNDING_FACTOR);
            }
        }
    }
    return NO;
}

- (BOOL)isInsideOfObjectWithPosition:(GLKVector3)position 
                         boundingBox:(AGLKAxisAllignedBoundingBox)borders 
{
    float xWidth = borders.max.x - borders.min.x;
    float zWidth = borders.max.z - borders.min.z;
    
    if (self.nextPosition.x < (position.x - self.radius - (xWidth / 2))) {
        return NO;
    }
    
    if (self.nextPosition.x > (position.x + self.radius + (xWidth / 2))) {
        return NO;
    }
    
    if (self.nextPosition.z < (position.z - self.radius - (zWidth / 2))) {
        return NO;
    }
    
    if (self.nextPosition.z > (position.z + self.radius + (zWidth / 2))) {
        return NO;
    }
    return YES;
}

@end
