//
//  JungleTricksViewController.m
//  JungleTricks
//
//  Created by Jeff Schmidt on 30/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JungleTricksViewController.h"

@implementation JungleTricksViewController

@synthesize viewSonido, botonControl, labelNombreJugador, botonNombre, botonOkNombre, textBoxNombre, audioPlayer, audioFileURL, audioFilePath, mono;

-(void)sonido{
    
    if(sonido == FALSE){             
        [botonControl setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
        
        sonido = TRUE;
        [audioPlayer play];
        
        
    }
    else{
        sonido = FALSE;
        [audioPlayer stop];
        [botonControl setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
}


-(void)mostrarIngresarNombre{
    
    textBoxNombre.hidden = FALSE;
    botonOkNombre.hidden = FALSE;
}


-(IBAction)obtenerNombre:(id)sender{
    NSString *nombreJugador = [textBoxNombre text];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nombreJugador forKey: @"NombreJugador"];
    [defaults synchronize];
    textBoxNombre.hidden = TRUE;
    botonOkNombre.hidden = TRUE;
    /*nombreJugador = [[NSString alloc] initWithFormat:@"%@%@%@", @"Hola ",nombreJugador,@"!"];*/
    [botonNombre setTitle:nombreJugador forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    botonControl = [[UIButton alloc]init];
        sonido = TRUE;
        audioFilePath = [[NSBundle mainBundle] pathForResource:@"musica" ofType:@"wav"];
        
        audioFileURL = [NSURL fileURLWithPath:audioFilePath];
        
        
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:NULL];
        
        
        [audioPlayer prepareToPlay];
        [audioPlayer setNumberOfLoops:-1]; // -1 significa que son repeticiones continuas.
        [audioPlayer setVolume:2.3];
    
    /*
        NSUserDefaults *settingSonido = [NSUserDefaults standardUserDefaults];
        NSString *switchSonido = [settingSonido objectForKey:@"on"];
        if (switchSonido==NULL) {
              [audioPlayer play]; 
        }
    */
    
       [audioPlayer play];
    
    

    // Nombre Jugador
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *nombreJugador = [defaults objectForKey:@"NombreJugador"];
    if (nombreJugador==NULL) {
        nombreJugador = @"Bienvenido ingresa tu nombre";
    }
    

    [botonNombre setTitle:nombreJugador forState:UIControlStateNormal];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //Animacion Mono
    NSArray *animacionMono = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"movimientoMono 00.png"],
                              [UIImage imageNamed:@"movimientoMono 01.png"],
                              [UIImage imageNamed:@"movimientoMono 02.png"],
                              [UIImage imageNamed:@"movimientoMono 02.png"],
                              [UIImage imageNamed:@"movimientoMono 03.png"],
                              [UIImage imageNamed:@"movimientoMono 04.png"],
                              nil]; 
    mono.animationImages = animacionMono;
    mono.animationDuration = 0.8;
    mono.animationRepeatCount = 0;
    
    


    
    [mono startAnimating];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
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
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}

@end
