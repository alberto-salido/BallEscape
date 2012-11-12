//
//  BoardGame+viewAdditions.m
//  BallEscape
//
//  Created by Alberto Salido López on 12/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "BoardGame+viewAdditions.h"

@implementation BoardGame (viewAdditions)

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
    
    // Draw the boardgame, floor (super.model) and borders.
    [self.model draw];
    [self.borders draw];
    
    // Restore saved attributes   
    baseEffect.transform.modelviewMatrix = savedModelviewMatrix;
    baseEffect.material.diffuseColor = savedDiffuseColor;
    baseEffect.material.ambientColor = savedAmbientColor;
}

@end
