//
//  UtilityMesh+viewAdditions.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  References Learning OpenGL ES for iOS, Erik M. Buck.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "UtilityMesh.h"


/////////////////////////////////////////////////////////////////
// This type identifies the vertex attributes used to render 
// models, terrain, and billboard particles. Not all effects use
// all attributes.
typedef enum
{
    UtilityVertexAttribPosition = GLKVertexAttribPosition,
    UtilityVertexAttribNormal = GLKVertexAttribNormal,
    UtilityVertexAttribColor = GLKVertexAttribColor,
    UtilityVertexAttribTexCoord0 = GLKVertexAttribTexCoord0,
    UtilityVertexAttribTexCoord1 = GLKVertexAttribTexCoord1,
    UtilityVertexAttribOpacity,
    UtilityVertexAttribJointMatrixIndices,
    UtilityVertexAttribJointNormalizedWeights,
    UtilityVertexNumberOfAttributes,
} UtilityVertexAttribute;


//  The UtilityMesh (viewAdditions) category extends 
//  the UtilityMesh class from the Model subsystem.
@interface UtilityMesh (viewAdditions)

- (void)prepareToDraw;
- (void)prepareToPick;
- (void)drawCommandsInRange:(NSRange)aRange;
- (void)drawBoundingBoxStringForCommandsInRange:
   (NSRange)aRange;

@end
