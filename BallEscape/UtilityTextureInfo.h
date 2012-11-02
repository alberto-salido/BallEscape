//
//  UtilityTextureInfo.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  References Learning OpenGL ES for iOS, Erik M. Buck.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <GLKit/GLKit.h>

//  The UtilityTextureInfo class encapsulates raw texture
//  data stored within binary .modelplist files.
@interface UtilityTextureInfo : NSObject 
   <NSCoding>

@property (strong, nonatomic, readonly) NSDictionary *plist;
@property (strong, nonatomic, readwrite) id userInfo;

- (void)discardPlist;

@end
