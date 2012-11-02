//
//  UtilityModel.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  References Learning OpenGL ES for iOS, Erik M. Buck.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "AGLKAxisAllignedBoundingBox.h"

@class UtilityMesh;

//  Each instance of UtilityModel stores a mesh property defining 
//  the geometry for one or more 3D models. UtilityModel also stores
//  a name property to identify the specific subset of the mesh
//  needed by the 3D model. The computed axisAlignedBoundingBox property
//  provides a bounding box containing all the mesh vertices included in
//  a model. The doesRequireLighting property indicates whether to render
//  the 3D model with or without using OpenGL ES lighting calculations 
//  on a case-by-case basis.
@interface UtilityModel : NSObject
{
   NSUInteger indexOfFirstCommand_;
   NSUInteger numberOfCommands_;
}

@property (copy, nonatomic, readonly) NSString
   *name;
@property (strong, nonatomic, readonly) UtilityMesh
   *mesh;
@property (assign, nonatomic, readonly) NSUInteger
   indexOfFirstCommand;
@property (assign, nonatomic, readonly) NSUInteger
   numberOfCommands;
@property (assign, nonatomic, readonly) 
   AGLKAxisAllignedBoundingBox axisAlignedBoundingBox;
@property (assign, nonatomic, readonly) 
   BOOL doesRequireLighting;
   
- (id)initWithName:(NSString *)aName 
   mesh:(UtilityMesh *)aMesh
   indexOfFirstCommand:(NSUInteger)aFirstIndex
   numberOfCommands:(NSUInteger)count
   axisAlignedBoundingBox:(AGLKAxisAllignedBoundingBox)
      aBoundingBox;
      
- (id)initWithPlistRepresentation:(NSDictionary *)aDictionary
   mesh:(UtilityMesh *)aMesh;

@end

/////////////////////////////////////////////////////////////////
// Constants used to access model properties from a plist
// dictionary.
extern NSString *const UtilityModelName;
extern NSString *const UtilityModelIndexOfFirstCommand;
extern NSString *const UtilityModelNumberOfCommands;
extern NSString *const UtilityModelAxisAlignedBoundingBox;
extern NSString *const UtilityModelDrawingCommand; 
