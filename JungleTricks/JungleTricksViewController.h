//
//  JungleTricksViewController.h
//  JungleTricks
//
//  Created by Jeff Schmidt on 30/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "Jugador.h"

@interface JungleTricksViewController : UIViewController{
    
    
    
    IBOutlet UIView *viewSonido;
    IBOutlet UIButton *botonControl;
    
    Jugador *jugador;
    
    bool sonido;
    
    NSString *audioFilePath;
    NSURL *audioFileURL;
    AVAudioPlayer *audioPlayer;
    
    
    IBOutlet UIButton *labelNombreJugador;    
    IBOutlet UIButton *botonNombre;
    IBOutlet UITextField *textBoxNombre;
    IBOutlet UIButton *botonOkNombre; 
    
    
    UIImageView *mono;
    
    
    
    
    
    
    
}


-(IBAction)sonido;
-(IBAction)obtenerNombre;
-(IBAction)mostrarIngresarNombre; 

@property (nonatomic, retain) IBOutlet UIView *viewSonido;
@property (nonatomic, retain) IBOutlet UIButton *botonControl;

@property (nonatomic, retain) IBOutlet UIButton *labelNombreJugador;
@property (nonatomic, retain) IBOutlet UIButton *botonNombre;
@property (nonatomic, retain) IBOutlet UITextField *textBoxNombre;
@property (nonatomic, retain) IBOutlet UIButton *botonOkNombre;

@property (nonatomic, retain) NSString *audioFilePath;
@property (nonatomic, retain) NSURL *audioFileURL;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

@property (nonatomic, retain) IBOutlet UIImageView *mono;
@end
