//
//  Ghost+viewAdditions.m
//  BallEscape
//
//  Created by Alberto Salido López on 28/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "Ghost+viewAdditions.h"

@implementation Ghost (viewAdditions)

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
    
    // Rotate to match model's yaw angle (rotation about Y)
    baseEffect.transform.modelviewMatrix = 
    GLKMatrix4Rotate(baseEffect.transform.modelviewMatrix,
                     self.yawRadians,
                     0.0, 1.0, 0.0);
    
    [baseEffect prepareToDraw];
    
    // Draw the model
    [self.model draw];
    
    // Restore saved attributes   
    baseEffect.transform.modelviewMatrix = savedModelviewMatrix;
    baseEffect.material.diffuseColor = savedDiffuseColor;
    baseEffect.material.ambientColor = savedAmbientColor;
}

@end
