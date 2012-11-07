//
//  OpenGLViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "OpenGLViewController.h"

//  The OpenGLViewController () interface extends the previous one
//  (public) with some addtional mehtods and variables hidden.
//  The interface manages the |GLKView|, the models and the position
//  of the camera. Also has information about the level that is
// currently played and elements will be displayed in it.
//
@interface OpenGLViewController ()

//  The |GLKView| class simplifies the effort required to create 
//  an OpenGL ES application by providing a default implementation
//  of an OpenGL ES-aware view. A |GLKView| directly manages a 
//  framebuffer object on your application’s behalf; 
//  your application simply needs to draw into the framebuffer 
//  when the contents need to be updated.
@property (nonatomic, strong) GLKView *glView;

//  The |GLKBaseEffect| class provides shaders that mimic many of the
//  behaviors provided by the OpenGL ES 1.1 lighting and shading model,
//  including materials, lighting and texturing. The base effect 
//  allows up to three lights and two textures to be applied to a scene.
@property (nonatomic, strong) GLKBaseEffect *baseEffect;

//  The |UtilityModelManager| simplifies the load of models. This class
//  loads a unique Modelplist file with the entire model. This object has
//  the information about all the elements in the scene.
@property (nonatomic, strong) UtilityModelManager *modelManager;

//  The |UtilityModel| class stores a simple model. Each object in
//  the game are a instance of |UtilityModel|.
@property (nonatomic, strong) UtilityModel *gameModelFloor;
@property (nonatomic, strong) UtilityModel *gameModelBorders;
@property (nonatomic, strong) UtilityModel *gameModelWalls;

//  Vectors with the information of the current point of view.
//  The first vector represent the postion of the "eye".
//  The second one, makes a target for the view.
//  The last one, sets a vector that produces the same effect as tilting
//  onserver's head.
@property GLKVector3 eyePosition;
@property GLKVector3 lookAtPosition;
@property GLKVector3 upVector;

//  Variables for checking if the model view matrix 
//  has been altered since the last time. It usefull for not to waste CPU
//  cycles if the model hasn't been moved since the last time.
@property float previousXPosition;
@property float previousZPosition;

//  Vector with the elements to draw into the labyrinth. This proporty
//  stores |UtilityModel|, each one with one different element to be
//  draw into the game.
@property (nonatomic, strong) NSMutableArray *elements;

//  Manages the information about each level. Returns importat
//  data about the levels; number of levels in the game, current level
//  played and the position of every element into the game.
@property (nonatomic, strong) LevelManager *levelManager;


//  Configures the current GLKView.
//  - Initializes a new one;
//  - Checks the type of the view;
//  - Sets the Z-Buffer;
//  - Sets the context.
- (void)configureGLView;

//  Configures the enviroment for the scene.
//  - Sets the lights; color and direction;
//  - Sets the background.
- (void)configureEnviroment;

//  Configures the point of view of the model.
//  - Sets the vectors of the Eye and the LookAt into the 
//    scene.
//  - Creates the model view matrix with the previous vectors.
- (void)configurePointOfView;

//  Load the Modelplist file, which stores the complete model and
//  divide it, saving each mesh into a variable.
//  - Throws exception in case of error.
- (void)loadModels;

//  Stores the position of every element of the labyrinth into the vector.
//  - Creates the Walls.
//  - Creates the Ball.
//  - Creates the Monster.
//  - Stores it all.
- (void)storeElementsInArray;

@end


@implementation OpenGLViewController

//  Creates all "getter" and "setter" methods.
@synthesize glView = _glView;
@synthesize baseEffect = _baseEffect;
@synthesize modelManager = _modelManager;
@synthesize gameModelFloor = _gameModelFloor;
@synthesize gameModelBorders = _gameModelBorders;
@synthesize gameModelWalls = _gameModelWalls;
@synthesize eyePosition = _eyePosition;
@synthesize lookAtPosition = _lookAtPosition;
@synthesize upVector = _upVector;
@synthesize previousXPosition = _previousXPosition;
@synthesize previousZPosition = _previousZPosition;
@synthesize elements = _elements;
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
    
    [self storeElementsInArray];
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


#pragma mark - GLKViewDelegate protocol

//  Draws the view’s contents.
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    //  Erase any previous data.
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT];
    
    //  Calculates the aspect ratio.
    const GLfloat aspectRatio = (GLfloat)view.drawableWidth / (GLfloat)view.drawableHeight;
    
    //  Makes a first view of the scene.
    self.baseEffect.transform.projectionMatrix = 
    GLKMatrix4MakePerspective(GLKMathDegreesToRadians(35.0), aspectRatio, 4.0, 20.0);
    
    //  Prepares the view for drawing and draws the models.
    [self.modelManager prepareToDraw];
    [self.baseEffect prepareToDraw];
    
    //  Draw the boardgame.
    [self.gameModelFloor draw];
    [self.gameModelBorders draw];
    
    // Draw every element.
    [self.elements makeObjectsPerformSelector:@selector(drawWithBaseEffect:) 
                                withObject:self.baseEffect];
}


#pragma mark - Private methods

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

- (void)configurePointOfView
{
    //  Default view {0, 18, 0}.
    self.eyePosition = GLKVector3Make(0.0, 18.0, 0.0);
    self.lookAtPosition = GLKVector3Make(0.0, 0.0, 0.0);
    self.upVector = GLKVector3Make(1.0, 0.0, 0.0);
    
    //  Returns a 4x4 matrix that transforms world coordinates to eye coordinates.
    self.baseEffect.transform.modelviewMatrix = 
    GLKMatrix4MakeLookAt(self.eyePosition.x, self.eyePosition.y, self.eyePosition.z,
                         self.lookAtPosition.x, self.lookAtPosition.y, self.lookAtPosition.z, 
                         self.upVector.x, self.upVector.y, self.upVector.z);
}

- (void)loadModels
{
    //  Searches for the path and stores it.
    NSString *modelsPath = [[NSBundle bundleForClass:[self class]]
                            pathForResource:@"ballEscape" ofType:@"modelplist"];
    self.modelManager = [[UtilityModelManager alloc] initWithModelPath:modelsPath];
    
    //  Loads the floor.
    self.gameModelFloor = [self.modelManager modelNamed:@"floor"];
    NSAssert(self.gameModelFloor != nil, @"Failed to load floor model");
    
    //  Loads the borders.
    self.gameModelBorders = [self.modelManager modelNamed:@"borders"];
    NSAssert(self.gameModelBorders != nil, @"Failed to load borders model");
    
    //  Loads the walls.
    self.gameModelWalls = [self.modelManager modelNamed:@"walls"];
    NSAssert(self.gameModelWalls != nil, @"Failed to load walls");
    
    //  Load the textures.
    self.baseEffect.texture2d0.name = self.modelManager.textureInfo.name;
    self.baseEffect.texture2d0.target = self.modelManager.textureInfo.target;
}

- (void)storeElementsInArray
{
    self.levelManager = [[LevelManager alloc] initWithNumberOfLevels:1];
    
    //  Initializes the arrays.
    NSArray *positions = 
    [[NSArray alloc] initWithArray:[self.levelManager getNextLevelStructure]];
    
    self.elements = [[NSMutableArray alloc] init];
        
    for (int i = 0; i < positions.count; i = i+3) {
        [self.elements addObject:[[Wall alloc] 
                                  initWithModel:self.gameModelWalls 
                                  position:GLKVector3Make([[positions objectAtIndex:i] floatValue],
                                                          0.0,
                                                          [[positions objectAtIndex:i+1] floatValue])
                                  shouldRotate:[[positions objectAtIndex:i+2] boolValue]]];
    }
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
        self.baseEffect.transform.modelviewMatrix = 
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
