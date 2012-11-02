//
//  UtilityModelManager.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  References Learning OpenGL ES for iOS, Erik M. Buck.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <GLKit/GLKit.h>

@class UtilityModel;
@class UtilityMesh;

//  The UtilityModelManager class encapsulates a mesh, a texture,
//  and a collection of named 3D models that can be rendered using
//  portions of the mesh and the texture.
@interface UtilityModelManager : NSObject

@property (strong, nonatomic, readonly) GLKTextureInfo 
   *textureInfo;
@property (strong, nonatomic, readonly) UtilityMesh 
   *consolidatedMesh;

- (id)init;
- (id)initWithModelPath:(NSString *)aPath;

- (BOOL)readFromData:(NSData *)data 
   ofType:(NSString *)typeName 
   error:(NSError **)outError;

- (UtilityModel *)modelNamed:(NSString *)aName;
- (void)prepareToDraw;
- (void)prepareToPick;

@end

/////////////////////////////////////////////////////////////////
// Constants used to access model properties from a plist
// dictionary.
extern NSString *const UtilityModelManagerTextureImageInfo;
extern NSString *const UtilityModelManagerMesh;
extern NSString *const UtilityModelManagerModels;
