//
//  Ball.m
//  BallEscape
//
//  Created by Alberto Salido López on 08/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "Ball.h"

@interface Ball ()

@property (nonatomic) GLKVector3 position;
@property (nonatomic) GLKVector3 velocity;
@property (nonatomic) GLfloat radius;

//  Next position of the ball.
@property (nonatomic) GLKVector3 nextPosition;

//  This function checks if the ball has collisioned
//  with the borders of the board-game. The collisions
//  bounce of the ball from the borders.
- (void)bounceOffBorders:(AGLKAxisAllignedBoundingBox)borders;

//  This method detexts any collision between the ball
//  and the labyrinth walls.
//- (void)bounceOffWalls:(NSArray *)walls;

//  Checks if a position, represented as a |GLKvector3| is inside
//  of another object, represented by its Bounding Box.
- (BOOL)isInsideOfObjectWithPosition:(GLKVector3)position 
                         boundingBox:(AGLKAxisAllignedBoundingBox)borders;

@end

@implementation Ball

@synthesize position = _position;
@synthesize velocity = _velocity;
@synthesize radius = _radius;
@synthesize nextPosition = _nextPosition;

- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
           velocity:(GLKVector3)velocity
{
    if ((self = [super initWithModel:model position:position])
        != nil) {
        self.velocity = velocity;
        
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

- (void)updateWithController:(id<ObjectController>)controller
{
    NSTimeInterval elapsedTimeSeconds = 
    MIN(MAX([controller timeSinceLastUpdate], 0.1), 0.5);
        
    //  Updates the velocity using the motion controller.
    self.velocity = GLKVector3Add(self.velocity, 
                                    GLKVector3Make([controller getXVelocity],
                                                    0.0, 
                                                    [controller getZVelocity]));
    
    GLKVector3 traveledDistance = GLKVector3MultiplyScalar(self.velocity,
                                                           elapsedTimeSeconds);
    
    self.nextPosition = GLKVector3Add(self.position, traveledDistance);
    
    //  Detectes collisions.
    [self bounceOffBorders:[controller borders]];
//    [self bounceOffWalls:[controller labyrinth]];
    
    self.position = self.nextPosition;
}

- (void)bounceOffBorders:(AGLKAxisAllignedBoundingBox)borders
{
    // Detects collisions with the four borders.
    //  Updates the velocity, as the ball was hitten, and sets up the nextPosition.
    if ((borders.min.x + self.radius) > self.nextPosition.x) {
        self.nextPosition = GLKVector3Make(borders.min.x + self.radius,
                                           self.nextPosition.y, self.nextPosition.z);
        self.velocity = GLKVector3Make(-self.velocity.x, 
                                       self.velocity.y, self.velocity.z);
    } 
    /*if ((borders.max.x - BORDER_WIDTH - self.radius) < self.nextPosition.x) {
        self.nextPosition = GLKVector3Make(borders.max.x - BORDER_WIDTH - self.radius,
                                           self.nextPosition.y, self.nextPosition.z);
        self.velocity = GLKVector3Make(-self.velocity.x * BOUNDING_COEFFICIENT, 
                                       self.velocity.y, self.velocity.z);
    } 
    if ((borders.min.z + BORDER_WIDTH + self.radius) > self.nextPosition.z) {
        self.nextPosition = GLKVector3Make(self.nextPosition.x, self.nextPosition.y, 
                                           borders.min.z + BORDER_WIDTH + self.radius);
        self.velocity = GLKVector3Make(self.velocity.x, self.velocity.y,
                                       -self.velocity.z * BOUNDING_COEFFICIENT);
    }
    if ((borders.max.z - BORDER_WIDTH - self.radius) < self.nextPosition.z) {
        self.nextPosition = GLKVector3Make(self.nextPosition.x, self.nextPosition.y,
                                           borders.max.z - BORDER_WIDTH - self.radius);
        self.velocity = GLKVector3Make(self.velocity.x, self.velocity.y,
                                       -self.velocity.z * BOUNDING_COEFFICIENT);
    }*/
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
