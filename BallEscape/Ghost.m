//
//  Ghost.m
//  BallEscape
//
//  Created by Alberto Salido López on 28/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Ghost.h"

//  Far distance that the ghost can see.
static float const SEE_DISTANCE = 2.0;

//  Constants with the information about the size of the boardgame.
//  Size of the board game in the X-Axis.
static float const BOARD_GAME_WIDTH = 10.0;
static float const BOARD_GAME_HEIGHT = 13.68;

@interface Ghost ()

@property (nonatomic, strong) UtilityModel *model;
@property (nonatomic) GLKVector3 position;
@property (nonatomic) GLKVector3 velocity;
@property (nonatomic) GLKVector3 nextPosition;
@property (nonatomic) float yawRadians;

- (BOOL)canSeeTheBallAtPosition:(GLKVector3)position;

@end

@implementation Ghost

@synthesize model = _model;
@synthesize position = _position;
@synthesize velocity = _velocity;
@synthesize nextPosition = _nextPosition;
@synthesize shouldPassThrowTheWalls = _shouldPassThrowTheWalls;
@synthesize yawRadians = _yawRadians;

- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
           velocity:(GLKVector3)velocity
         throwWalls:(BOOL)throwWalls
{
    if ((self = [super initWithModel:model position:position velocity:velocity]) != nil) {
        self.shouldPassThrowTheWalls = throwWalls;
    }
    
    return self;
}

- (BOOL)updateWithController:(id <ObjectController>)controller
{
    NSTimeInterval elapsedTimeSeconds = MIN (MAX( [controller timeSinceLastUpdate], 0.1), 0.5);
    
    GLKVector3 traveledDistance = GLKVector3MultiplyScalar(self.velocity, elapsedTimeSeconds);
    
    self.nextPosition = GLKVector3Add(self.position, traveledDistance);
    
    //  Checks if the ball is in his view ratio. In this case, the ghost
    //  will follow him.
    BOOL gameOver = [self canSeeTheBallAtPosition:[controller getBallPosition]];
    
    if (!gameOver) {
        
        [self bounceOffBorders:[controller borders]];
        if (self.shouldPassThrowTheWalls) {
            //[self bounceOffBall:(Ball *)[controller ball]];
        } else {
            [self bounceOffWalls:[controller labyrinthByQuadrants]];
        }
        
        //  Accelerate if going slow
        if(0.1 > GLKVector3Length(self.velocity))
        {  
            //  Got so slow that direction is unreliable so
            //  launch in a new direction
            self.velocity = GLKVector3Make(
                                           (random() / (0.5f * RAND_MAX)) - 1.0f, // range -1 to 1
                                           0.0f,
                                           (random() / (0.5f * RAND_MAX)) - 1.0f);// range -1 to 1
        }
        else if(4 > GLKVector3Length(self.velocity))
        {  
            //  Speed up in current direction
            self.velocity = GLKVector3MultiplyScalar(self.velocity, 1.01f);
        }
        
        //  The dot product is the cos() of the angle between two
        //  vectors: in this case, the default orientation of the
        //  ghost model and the ghost's velocity vector.
        float dotProduct = GLKVector3DotProduct(
                                                GLKVector3Normalize(self.velocity),
                                                GLKVector3Make(0.0, 0, 1.0));
        
        //  Checks if the velocity is negative, the ghost is moving to the lower border, in this case, the 
        //  yaw angle sign must be changed to positive to simulate the rotation.
        if (self.velocity.x > 0) {
            self.yawRadians = acosf(dotProduct);
        } else {
            self.yawRadians = -acosf(dotProduct);
        }
        
        self.position = self.nextPosition;
        
    }
    return gameOver;
}

- (BOOL)canSeeTheBallAtPosition:(GLKVector3)position
{
    float distance = GLKVector3Distance(self.position, position);
    
    if (distance < (self.radius * 2)) {
        return YES;
    }
    
    if (distance < SEE_DISTANCE) {
        //  The ball has been detected by the ghost.
        GLKVector3 direction = GLKVector3Subtract(position, self.position);
        direction = GLKVector3Normalize(direction);
        self.velocity = direction;
    }
    return NO;
}

@end
