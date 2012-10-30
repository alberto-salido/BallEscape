//
//  OpenGLViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "OpenGLViewController.h"

#pragma mark - Private API

@interface OpenGLViewController ()

//  The GLKView class simplifies the effort required to create 
//  an OpenGL ES application by providing a default implementation
//  of an OpenGL ES-aware view. A GLKView directly manages a 
//  framebuffer object on your application’s behalf; 
//  your application simply needs to draw into the framebuffer 
//  when the contents need to be updated.
@property (nonatomic, strong) GLKView *glView;

//  The GLKBaseEffect class provides shaders that mimic many of the
//  behaviors provided by the OpenGL ES 1.1 lighting and shading model,
//  including materials, lighting and texturing. The base effect 
//  allows up to three lights and two textures to be applied to a scene.
@property (nonatomic, strong) GLKBaseEffect *baseEffect;

//  The UtilityModelManager simplifies the load of models. This class
//  loads a unique Modelplist file with the entire model.
@property (nonatomic, strong) UtilityModelManager *modelManager;

//  The UtilityModel class stores a simple model. In this case, the 
//  boardgame model.
@property(nonatomic, strong) UtilityModel *boardModel;

//  Set of vectors with the information of the current point of view.
//  The first vector represent the postion of the "eye".
//  The second one, makes a target for the view.
/*
 * The last one, sets a ...
 */
@property GLKVector3 eyePosition;
@property GLKVector3 lookAtPosition;
@property GLKVector3 upVector;


//  Prototypes of auxiliary functions.
- (void)configureGLView;
- (void)configureEnviroment;
- (void)configurePointOfView;
- (void)loadModels;

@end


#pragma mark - Implementation

@implementation OpenGLViewController

//  Creates every "getter" and "setter" methods.
@synthesize glView = _glView;
@synthesize baseEffect = _baseEffect;
@synthesize modelManager = _modelManager;
@synthesize boardModel = _boardModel;
@synthesize eyePosition = _eyePosition;
@synthesize lookAtPosition = _lookAtPosition;
@synthesize upVector = _upVector;


//  Sent to the view controller when the app receives a memory warning.
//  Release any cached data, images, etc that aren't in use.
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle

//  This method is called after the view controller has loaded
//  its view hierarchy into memory.
- (void)viewDidLoad
{
    //  Loads any previous data from the father class.
    [super viewDidLoad];
    
    //  Sets the GLKView context.
    [self configureGLView];
    
    //  Sets the enviroment for the scene.
    [self configureEnviroment];
    
    //  Sets the initial point of view.
    [self configurePointOfView];
    
    //  Load the modelplist file and stores the meshes into
    //  its variables.
    [self loadModels];
    
    
    
}


//  Called when the controller’s view is released from memory.
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.glView = nil;
    [EAGLContext setCurrentContext:nil];
    
    self.baseEffect = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - GLKViewDelegate Protocol

//  Draws the view’s contents.
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    //  Erase any previous data.
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT];
    
    //  Calculates the aspect ratio.
    const GLfloat aspectRatio = (GLfloat)view.drawableWidth / (GLfloat)view.drawableHeight;
    
    self.baseEffect.transform.projectionMatrix = 
    GLKMatrix4MakePerspective(GLKMathDegreesToRadians(35.0), aspectRatio, 4.0, 20.0);
    
    //  Prepares the view for drawing and draws the models.
    [self.modelManager prepareToDraw];
    [self.baseEffect prepareToDraw];
    [self.boardModel draw];
}


#pragma mark - Auxiliary functions

//  Configures the current GLKView.
//  - Initializes a new one;
//  - Checks the type of the view;
//  - Sets the Z-Buffer;
//  - Sets the context.
- (void)configureGLView
{
    //  Verify the View's type, created by the interface builder 
    //  (storyboard), is GLKView.
    self.glView = (GLKView *)self.view;
    NSAssert([self.glView isKindOfClass:[GLKView class]],
             @"View controller's view is not a GLKView");
    
    //  Uses a 24bits Z-Buffer or Depth-Buffer.
    self.glView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    //  Creates a OpenGL ES 2.0 context and sets it as current context.
    //  The view uses this context as the place to create its underlying 
    //  framebuffer object and it also sets the context before calling 
    //  your drawing method. Never change the context from inside your 
    //  drawing method.
    self.glView.context = [[AGLKContext alloc] 
                      initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [AGLKContext setCurrentContext:self.glView.context];
    
    /*
     *  Documentar esta líena!
     */
    [((AGLKContext *)self.glView.context) enable:GL_DEPTH_TEST];
    [((AGLKContext *)self.glView.context) enable:GL_CULL_FACE];

}


//  Configures the enviroment for the scene.
//  - Sets the lights, color and direction;
//  - Sets the background.
- (void)configureEnviroment
{
    //  Creates a BaseEffect.
    self.baseEffect = [[GLKBaseEffect alloc] init];
    
    //  Enables the light.
    self.baseEffect.light0.enabled = GL_TRUE;
    
    //  Sets the light color (RGBA)
    self.baseEffect.light0.ambientColor = GLKVector4Make(0.8, 0.8, 0.8, 1.0);
    self.baseEffect.light0.diffuseColor = GLKVector4Make(1.0, 1.0, 1.0, 1.0);
    
    //  Sets the main position.
    self.baseEffect.light0.position = GLKVector4Make(1.0, 0.8, 0.4, 0.0);
    
    //  Sets the background color (RGBA).
    ((AGLKContext *)self.glView.context).clearColor = GLKVector4Make(0.0, 0.0, 0.0, 1.0);
}


//  Configures the point of view of the model. 
- (void)configurePointOfView
{
    self.eyePosition = GLKVector3Make(0.1, 15.0, 0.0);
    self.lookAtPosition = GLKVector3Make(0.0, 0.0, 0.0);
    self.upVector = GLKVector3Make(0.0, 10.0, 0.0);
    
    self.baseEffect.transform.modelviewMatrix = 
    GLKMatrix4MakeLookAt(self.eyePosition.x, self.eyePosition.y, self.eyePosition.z,
                         self.lookAtPosition.x, self.lookAtPosition.y, self.lookAtPosition.z, 
                         self.upVector.x, self.upVector.y, self.upVector.z);
}


//  Load the Modelplist file, which stores the complete model and
//  divide it saving each mesh into a variable.
- (void)loadModels
{
    //  Searches for the path and stores it.
    NSString *modelsPath = [[NSBundle bundleForClass:[self class]]
                            pathForResource:@"labyrinth" ofType:@"modelplist"];
    self.modelManager = [[UtilityModelManager alloc] initWithModelPath:modelsPath];
    
    //  Finds a specified mesh into the model and stores it.
    self.boardModel = [self.modelManager modelNamed:@"board"];
    
    //  Throws an exception if the model does not exist.
    NSAssert(self.boardModel != nil, @"Failed to load Board model");
}


@end
