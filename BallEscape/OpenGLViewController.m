//
//  OpenGLViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "OpenGLViewController.h"

//  Constants with the information about the size of the boardgame.
//  Size of the board game in the X-Axis.
static float const BOARD_GAME_WIDTH = 10.0;
static float const BOARD_GAME_HEIGHT = 13.68;

//  Eye's hight.
static float const EYE_HEIGHT = 18.0;

//  Constants about the Modelpfile with the name of the models
//  inside.
static NSString *const MODELS_FILE = @"ballEscape";
static NSString *const MODEL_FLOOR_NAME = @"floor";
static NSString *const MODEL_BORDERS_NAME = @"borders";
static NSString *const MODEL_WALL_NAME = @"walls";
static NSString *const MODEL_BALL_NAME = @"ball";
static NSString *const MODEL_DOOR_NAME = @"door";

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

//  Objects to be drawn into the game.
@property (nonatomic, strong) BoardGame *boardGame;
@property (nonatomic, strong) NSMutableSet *labyrinth;
@property (nonatomic, strong) Ball *ball;

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

//  Properties with the slope of the boardgame.
//  Both variables are updated with the motion controller.
@property float xSlopeInGrades;
@property float zSlopeInGrades;

//  Property that indicates if the game is paused or not.
//  if the game is paused, no updates are made.
@property BOOL isPaused;

@property (nonatomic, strong) CMMotionManager *motionManager;

//  Configures the current GLKView.
//  - Initializes a new one;
//  - Checks the type of the view;
//  - Sets the Z-Buffer;
//  - Sets the context.
- (void)configureGLView;

//  Configures the Device Motion.
- (void)configureDeviceMotion;

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
//  divide it, saving each mesh into an object.
//  - Throws exception in case of error.
- (void)loadObjects;

//  Updates the slope of the boardgame using, for that propose, 
//  the gyroscope.
- (void)updateSlopeUsingMotionController;

@end

@implementation OpenGLViewController

//  Creates all "getter" and "setter" methods.
@synthesize glView = _glView;
@synthesize baseEffect = _baseEffect;
@synthesize modelManager = _modelManager;

@synthesize boardGame = _boardGame;
@synthesize labyrinth = _labyrinth;
@synthesize ball = _ball;

@synthesize eyePosition = _eyePosition;
@synthesize lookAtPosition = _lookAtPosition;
@synthesize upVector = _upVector;

@synthesize previousXPosition = _previousXPosition;
@synthesize previousZPosition = _previousZPosition;

@synthesize xSlopeInGrades = _xSlopeInGrades;
@synthesize zSlopeInGrades = _zSlopeInGrades;

@synthesize isPaused = _isPaused;

@synthesize time = _time;

@synthesize motionManager = _motionManager;

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
    
    //  Sets up the GLKView context.
    [self configureGLView];
    
    //  Sets up the Device Motion.
    [self configureDeviceMotion];
        
    //  Sets the enviroment for the scene.
    [self configureEnviroment];
    
    //  Sets the initial point of view.
    [self configurePointOfView];
    
    //  Load the modelplist file and stores the meshes into
    //  the objects. Also load the texture map for the models.
    [self loadObjects];
    
}

//  Called when the controller’s view is released from memory.
- (void)viewDidUnload
{
    [self setTime:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.glView = nil;
    self.baseEffect = nil;
    self.modelManager = nil;
    self.boardGame = nil;
    self.labyrinth = nil;
    self.ball = nil;
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

//  Notifies the view controller that its view is about to be removed
//  from a view hierarchy.
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
    //  Sends to the GameViewController the time used for complete the level.
    ((GameViewController *)self.presentingViewController).timeUsedInCompleteLevel
    = [self.time.text floatValue];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) && (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
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

    //  Draw the boardgame.
    [self.boardGame drawWithBaseEffect:self.baseEffect];
    
    //  Draw the labyrinth.
    [self.labyrinth makeObjectsPerformSelector:@selector(drawWithBaseEffect:) 
                                    withObject:self.baseEffect];
    
    //  Draw the ball.
    [self.ball drawWithBaseEffect:self.baseEffect];
}


#pragma mark - Controller's private methods.

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
    
    //  Sets the background color (RGBA).
    ((AGLKContext *)self.glView.context).clearColor = GLKVector4Make(0.0, 0.0, 0.0, 1.0);
}

- (void)configureDeviceMotion
{
   /* NSAssert((self.motionManager.gyroAvailable) || 
        (self.motionManager.accelerometerAvailable), 
             @"Device motion not available");*/
    [self.motionManager startDeviceMotionUpdates];
}

- (void)configureEnviroment
{
    //  Creates a BaseEffect.
    self.baseEffect = [[GLKBaseEffect alloc] init];
    
    //  Enables the light.
    self.baseEffect.light0.enabled = GL_TRUE;
    
    //  Sets the light color (RGBA)
    self.baseEffect.light0.ambientColor = GLKVector4Make(0.8, 0.8, 1.0, 1.0);
    self.baseEffect.light0.diffuseColor = GLKVector4Make(0.8, 0.8, 0.8, 1.0);
    
    //  Sets the main position.
    self.baseEffect.light0.position = GLKVector4Make(BOARD_GAME_WIDTH,
                                                     EYE_HEIGHT,
                                                     BOARD_GAME_HEIGHT,
                                                     0.0);
        
    //  Sets the background color (RGBA).
    ((AGLKContext *)self.glView.context).clearColor = GLKVector4Make(0.0, 0.0, 0.0, 1.0);
}

- (void)configurePointOfView
{
    //  Moves the eye position for viewing the entire boardgame.
    //  The board game is set to fit its lower-left corner, in the
    //  0.0 position.
    self.eyePosition = GLKVector3Make((BOARD_GAME_WIDTH / 2),
                                      EYE_HEIGHT,
                                      (BOARD_GAME_HEIGHT / 2));  
    self.lookAtPosition = GLKVector3Make((BOARD_GAME_WIDTH / 2),
                                         0.0,
                                         (BOARD_GAME_HEIGHT / 2));  
    self.upVector = GLKVector3Make(1.0, 0.0, 0.0);
    
    //  Returns a 4x4 matrix that transforms world coordinates to eye coordinates.
    self.baseEffect.transform.modelviewMatrix = 
    GLKMatrix4MakeLookAt(self.eyePosition.x, self.eyePosition.y, self.eyePosition.z,
                         self.lookAtPosition.x, self.lookAtPosition.y, self.lookAtPosition.z, 
                         self.upVector.x, self.upVector.y, self.upVector.z);
}

- (void)loadObjects
{
    //  Searches for the path and stores it.
    NSString *modelsPath = [[NSBundle bundleForClass:[self class]]
                            pathForResource:MODELS_FILE ofType:@"modelplist"];
    
    self.modelManager = [[UtilityModelManager alloc] initWithModelPath:modelsPath];
    
    //  Loads the floor.
    UtilityModel *gameModelFloor = [self.modelManager modelNamed:MODEL_FLOOR_NAME];
    NSAssert(gameModelFloor != nil, @"Failed to load floor model");
    
    //  Loads the borders.
    UtilityModel *gameModelBorders = [self.modelManager modelNamed:MODEL_BORDERS_NAME];
    NSAssert(gameModelBorders != nil, @"Failed to load borders model");
    
    //  Creates the board game.
    self.boardGame = [[BoardGame alloc] 
                      initBoardgameWithFloor:gameModelFloor 
                      andBorders:gameModelBorders
                      inPosition:GLKVector3Make((BOARD_GAME_WIDTH / 2),
                                                0.0,
                                                (BOARD_GAME_HEIGHT / 2))];    
    
    //  Loads the walls.
    UtilityModel *gameModelWalls = [self.modelManager modelNamed:MODEL_WALL_NAME];
    NSAssert(gameModelWalls != nil, @"Failed to load walls");
    
    //  Makes a reference to the GameViewController's property LevelManager.
    LevelManager *levelManager = ((GameViewController *)self.presentingViewController).levelManager;
        
    //  Creates the walls and stores them into a set, making the entire labyrinth.
    NSArray *coordinates = [[NSArray alloc] initWithArray:levelManager.getNextLevelStructure];
    self.labyrinth = [[NSMutableSet alloc] init];
    
    Wall *wallToAdd;
    GLKVector3 position;
    for (int i = 0; i < coordinates.count; i = i + 3) {
       position = GLKVector3Make([[coordinates objectAtIndex:i] floatValue],
                                             0.0,
                                             [[coordinates objectAtIndex:(i + 1)] floatValue]);
        wallToAdd = [[Wall alloc]
                           initWithModel:gameModelWalls
                           position:position
                           shouldRotate:[[coordinates objectAtIndex:(i + 2)] boolValue]];
        [self.labyrinth addObject:wallToAdd];
    }
    /* Constructor de laberintos.
     {
    Wall *oneWall = [[Wall alloc] initWithModel:gameModelWalls  
                                       position:GLKVector3Make(1.5, 0.0, 0.5) 
                                   shouldRotate:YES];
    [self.labyrinth addObject:oneWall];

    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                       position:GLKVector3Make(1.5, 0.0, 1.5) 
                                   shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(9.5, 0.0, 2.0) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(8.5, 0.0, 2) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(3.5, 0.0, 3.0) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(3.5, 0.0, 4.0) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(3.5, 0.0, 5.0) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(3.5, 0.0, 6.0) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(3.5, 0.0, 7.0) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(3.5, 0.0, 8.0) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(3.5, 0.0, 9.0) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(2.75, 0.0, 6.0) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];

    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(1.75, 0.0, 6.0) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(0.75, 0.0, 6.0) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(4.25, 0.0, 4.0) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(5.25, 0.0, 4.0) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(6.25, 0.0, 4.0) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(7.25, 0.0, 4.0) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(7.5, 0.0, 4.75) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(7.5, 0.0, 5.75) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(5.5, 0.0, 5.75) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(5.5, 0.0, 6.75) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(5.5, 0.0, 7.75) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(5.5, 0.0, 8.75) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(5.5, 0.0, 9.75) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(5.75, 0.0, 10.5) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(6.75, 0.0, 10.5) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(7.75, 0.0, 10.5) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(8.75, 0.0, 10.5) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(9.75, 0.0, 10.5) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(7.5, 0.0, 8.5) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(8.5, 0.0, 8.5) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(2.0, 0.0, 11.0) 
                             shouldRotate:NO];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(2.75, 0.0, 11.25) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    
    oneWall = [[Wall alloc] initWithModel:gameModelWalls 
                                 position:GLKVector3Make(2.75, 0.0, 12.25) 
                             shouldRotate:YES];
    [self.labyrinth addObject:oneWall];
    }*/
  
    //  Load the ball.
    UtilityModel *gameModelBall = [self.modelManager modelNamed:MODEL_BALL_NAME];
    NSAssert(gameModelBall != nil, @"Failed to load ball");
    
    //  Creates the ball object.
    self.ball = [[Ball alloc] initWithModel:gameModelBall
                                   position:GLKVector3Make(0.5, 0.0, 0.5) 
                                   velocity:GLKVector3Make(0.0, 0.0, 0.0)];
    
    //  Load the Door.
    UtilityModel *gameModelDoor = [self.modelManager modelNamed:MODEL_DOOR_NAME];
    NSAssert(gameModelDoor != nil, @"Failed to load door");
    
    //  Creates the door, a door is a kind of wall with other texture, and stores it.
    Wall *door = [[Wall alloc] initWithModel:gameModelDoor
                                    position:GLKVector3Make(0.0, 0.0, 7.0)
                                shouldRotate:NO];
    door.isADoor = YES;
    [self.labyrinth addObject:door];
    
    //  Load the textures.
    self.baseEffect.texture2d0.name = self.modelManager.textureInfo.name;
    self.baseEffect.texture2d0.target = self.modelManager.textureInfo.target;
}

#pragma mark - Animation

//  The controller’s –update method is called automatically at configurable
//  periodic rates (default 30 Hz). Immediately after –update,
//  the controller’s view redraws. 
- (void)update
{
    if (!self.isPaused) {
        //  Updates the time elapsed.
        double time = [self.time.text doubleValue] + 0.05;
        self.time.text = [NSString stringWithFormat:@"%.2f", time];
        
        //  Update the boardgame movement.
        if ((self.previousXPosition != self.eyePosition.x) ||
            (self.previousZPosition != self.eyePosition.z)) {
            //  If the position of the matrix has not been altered, 
            //  the calulation of the new model view matrix wont be done,
            //  saving CPU cycles.
            
            //[self updateSlopeUsingMotionController];
            
            //  Update vectors and update the matrix.
            //  ...
            
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
        
        //  Updates the ball movement.
        if ([self.ball updateWithController:self])
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (IBAction)pauseGame:(UIButton *)sender {
    self.isPaused = !self.isPaused;
}

#pragma mark - Protocol ObjectController

- (AGLKAxisAllignedBoundingBox)borders
{
    return self.boardGame.getBoardgameDimension;
}

- (float)getXSlope
{
    return self.xSlopeInGrades;
}

- (float)getZSlope
{
    return self.zSlopeInGrades;
}


#pragma mark - Motion Controller

- (void)updateSlopeUsingMotionController
{
    self.xSlopeInGrades = GLKMathDegreesToRadians(self.motionManager.gyroData.rotationRate.x);
    self.zSlopeInGrades = GLKMathDegreesToRadians(self.motionManager.gyroData.rotationRate.z);
}

/*
 *  Simuladores del sensor de movimiento.
 */
- (IBAction)tiltXAxis:(UISlider *)sender {
    self.xSlopeInGrades = sender.value;
    float xMovement = (BOARD_GAME_WIDTH / 2) + self.xSlopeInGrades;
    self.eyePosition = GLKVector3Make(xMovement, self.eyePosition.y, self.eyePosition.z);
}

- (IBAction)tiltZAxis:(UISlider *)sender {
    self.zSlopeInGrades = sender.value;
    float zMovement = (BOARD_GAME_HEIGHT / 2) + self.zSlopeInGrades;
    self.eyePosition = GLKVector3Make(self.eyePosition.x, self.eyePosition.y, zMovement);

}

@end
