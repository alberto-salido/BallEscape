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

@end


@implementation Ball

@synthesize position = _position;
@synthesize velocity = _velocity;
@synthesize radius = _radius;
@synthesize nextPosition = _nextPosition;

- (id)initWithModel:(UtilityModel *)model position:(GLKVector3)position velocity:(GLKVector3)velocity
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
    NSTimeInterval elapsedTimeSeconds = MIN(MAX([controller timeSinceLastUpdate], 0.1), 0.5);
    
    NSLog(@"x:%f y:%f", [controller getXVelocity], [controller getYVelocity]);

    //  Updates the velocity using the motion controller.
    if ((self.velocity.x != [controller getXVelocity]) || (self.velocity.y != [controller getYVelocity])) {
        self.velocity = GLKVector3Make([controller getXVelocity], 0.0, [controller getYVelocity]);
    }
    
    GLKVector3 traveledDistance = GLKVector3MultiplyScalar(self.velocity, elapsedTimeSeconds);
    
    self.nextPosition = GLKVector3Add(self.position, traveledDistance);
    
    self.position = self.nextPosition;
}

- (void)drawWithBaseEffect:(GLKBaseEffect *)baseEffect
{
    // Save effect attributes that will be changed
    GLKMatrix4  savedModelviewMatrix = 
    baseEffect.transform.modelviewMatrix;
    GLKVector4  savedDiffuseColor = 
    baseEffect.material.diffuseColor;
    GLKVector4  savedAmbientColor = 
    baseEffect.material.ambientColor;
    
    // Translate to the model's position
    baseEffect.transform.modelviewMatrix = 
    GLKMatrix4Translate(savedModelviewMatrix,
                        self.position.x, self.position.y, self.position.z);
    
    [baseEffect prepareToDraw];
    
    // Draw the model
    [self.model draw];
    
    // Restore saved attributes   
    baseEffect.transform.modelviewMatrix = savedModelviewMatrix;
    baseEffect.material.diffuseColor = savedDiffuseColor;
    baseEffect.material.ambientColor = savedAmbientColor;
}


@end
