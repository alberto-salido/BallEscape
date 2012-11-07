//
//  Wall.m
//  BallEscape
//
//  Created by Alberto Salido López on 04/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "Wall.h"

@implementation Wall

@synthesize shouldRotate = _shouldRotate;


- (id)initWithModel:(UtilityModel *)model position:(GLKVector3)position shouldRotate:(BOOL)rotate
{
    if ((self = [super initWithModel:model position:position]) != nil) {
        self.shouldRotate = rotate;
    }
    return self;
}

- (void) drawWithBaseEffect:(GLKBaseEffect *)baseEffect
{
    // Save effect attributes that will be changed
    GLKMatrix4  savedModelviewMatrix = baseEffect.transform.modelviewMatrix;
    GLKVector4  savedDiffuseColor = baseEffect.material.diffuseColor;
    GLKVector4  savedAmbientColor = baseEffect.material.ambientColor;
    
    // Translate to the model's position
    baseEffect.transform.modelviewMatrix = 
    GLKMatrix4Translate(savedModelviewMatrix,
                        self.position.x, self.position.y, self.position.z);
    
    // Rotate model if necesary (rotation about Y)
    if (self.shouldRotate) {
        baseEffect.transform.modelviewMatrix = 
        GLKMatrix4Rotate(baseEffect.transform.modelviewMatrix, 
                         GLKMathDegreesToRadians(90), 0.0, 1.0, 0.0);
    }
    
    [baseEffect prepareToDraw];
    
    // Draw the model
    [self.model draw];
    
    // Restore saved attributes   
    baseEffect.transform.modelviewMatrix = savedModelviewMatrix;
    baseEffect.material.diffuseColor = savedDiffuseColor;
    baseEffect.material.ambientColor = savedAmbientColor;
}

@end
