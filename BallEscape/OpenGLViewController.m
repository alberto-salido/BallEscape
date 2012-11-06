//
//  OpenGLViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "OpenGLViewController.h"
#import "LevelManager.h"

#pragma mark - Private API

@interface OpenGLViewController ()

//  The GLKView class simplifies the effort required to create 
//  an OpenGL ES application by providing a default implementation
//  of an OpenGL ES-aware view. A GLKView directly manages a 
//  framebuffer object on your application’s behalf; 
//  your application simply needs to draw into the framebuffer 
//  when the contents need to be updated.
@property (nonatomic, strong) GLKView *glView;

//  Set of vectors with the information of the current point of view.
//  The first vector represent the postion of the "eye".
//  The second one, makes a target for the view.
//  The last one, sets a vector that produces the same effect as tilting
//  onserver's head.
@property GLKVector3 eyePosition;
@property GLKVector3 lookAtPosition;
@property GLKVector3 upVector;

//  Variables for checking if the model view matrix 
//  has been altered since the last time.
@property float previousXPosition;
@property float previousZPosition;

@property (nonatomic, strong) LevelManager *levelManager;


//  Prototypes of auxiliary functions.
- (void)configureGLView;
- (void)configureEnviroment;
- (void)configurePointOfView;
- (void)loadModels;

@end


#pragma mark - Implementation

@implementation OpenGLViewController

//  Creates all "getter" and "setter" methods.
@synthesize glView = _glView;
@synthesize eyePosition = _eyePosition;
@synthesize lookAtPosition = _lookAtPosition;
@synthesize upVector = _upVector;
@synthesize previousXPosition = _previousXPosition;
@synthesize previousZPosition = _previousZPosition;
@synthesize levelManager = _levelManager;


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
    //  its variables. Also load the texture map for the models.
    [self loadModels];
    
    [self.levelManager prepareLevelStructure];
    
    
    
}


//  Called when the controller’s view is released from memory.
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.glView = nil;
    [EAGLContext setCurrentContext:nil];
    
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
    
    self.levelManager.baseEffect.transform.projectionMatrix = 
    GLKMatrix4MakePerspective(GLKMathDegreesToRadians(35.0), aspectRatio, 4.0, 20.0);
    
    [self.levelManager prepareViewAndDrawScene];

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
    //  (storyboard), is GLKView, otherwise rise an exception.
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
    
    //  The GL_DEPTH_TEST constant makes only renderizable the faces
    //  the model that are shown. Not rendering the faces in depth.
    //  The GL_CULL_FACE constant render both face of each 
    //  triangle. It's an optimization when render. 
    [((AGLKContext *)self.glView.context) enable:GL_DEPTH_TEST];
    //[((AGLKContext *)self.glView.context) enable:GL_CULL_FACE];

}


//  Configures the enviroment for the scene.
//  - Sets the lights; color and direction;
//  - Sets the background.
- (void)configureEnviroment
{
    //  Enables the light.
    self.levelManager.baseEffect.light0.enabled = GL_TRUE;
    
    //  Sets the light color (RGBA)
    self.levelManager.baseEffect.light0.ambientColor = GLKVector4Make(0.8, 0.8, 0.8, 1.0);
    self.levelManager.baseEffect.light0.diffuseColor = GLKVector4Make(1.0, 1.0, 1.0, 1.0);
    
    //  Sets the main position.
    self.levelManager.baseEffect.light0.position = GLKVector4Make(1.0, 0.8, 0.4, 0.0);
    
    //  Sets the background color (RGBA).
    ((AGLKContext *)self.glView.context).clearColor = GLKVector4Make(0.0, 0.0, 0.0, 1.0);
}


//  Configures the point of view of the model.
//  - Sets the vectors of the Eye and the LookAt in the 
//    scene.
//  - Creates the model view matrix with the previous vectors.
- (void)configurePointOfView
{
    //  Default view {0, 19, 0}.
    self.eyePosition = GLKVector3Make(0.0, 18.0, 0.0);
    self.lookAtPosition = GLKVector3Make(0.0, 0.0, 0.0);
    self.upVector = GLKVector3Make(1.0, 0.0, 0.0);
    
    //  Returns a 4x4 matrix that transforms world coordinates to eye coordinates.
    self.levelManager.baseEffect.transform.modelviewMatrix = 
    GLKMatrix4MakeLookAt(self.eyePosition.x, self.eyePosition.y, self.eyePosition.z,
                         self.lookAtPosition.x, self.lookAtPosition.y, self.lookAtPosition.z, 
                         self.upVector.x, self.upVector.y, self.upVector.z);
}


//  Load the Modelplist file, which stores the complete model and
//  divide it, saving each mesh into a variable.
//  - Throws exception in case of error.
- (void)loadModels
{
    [self.levelManager loadModelsFromPath:@"ballEscape"];
}

//  Stores the position of every element in the labyrinth into the vector.
//  - Creates the Wall.
//  - Creates the Ball.
//  - Creates the Monster.
//  - Stores it all.
- (void)storeElementsInArray
{
 
    
    









    
}



#pragma mark - Animation

//  The controller’s –update method is called automatically at configurable
//  periodic rates (default 30 Hz). Immediately after –update,
//  the controller’s view redraws. 
- (void)update
{
    //  If the position of the matrix has not been altered, the calulation of the new
    //  model view matrix wont be done, saving CPU cycles.
    if ((self.previousXPosition != self.eyePosition.x) ||
        (self.previousZPosition != self.eyePosition.z)) {
       
        //  Update de matrix
        self.levelManager.baseEffect.transform.modelviewMatrix = 
        GLKMatrix4MakeLookAt(self.eyePosition.x,
                             self.eyePosition.y,
                             self.eyePosition.z,
                             self.lookAtPosition.x,
                             self.lookAtPosition.y,
                             self.lookAtPosition.z, 
                             self.upVector.x,
                             self.upVector.y, 
                             self.upVector.z);
        
        //  Update the variables.
        self.previousXPosition = self.eyePosition.x;
        self.previousZPosition = self.eyePosition.z;
    }

}


/*
 *  Simuladores del sensor de movimiento.
 */
- (IBAction)tiltXAxis:(UISlider *)sender {
    self.eyePosition = GLKVector3Make(sender.value, self.eyePosition.y, self.eyePosition.z);
}

- (IBAction)tiltYAxis:(UISlider *)sender {
    self.eyePosition = GLKVector3Make(self.eyePosition.x, self.eyePosition.y, sender.value);

}
@end
