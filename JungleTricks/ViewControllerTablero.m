//
//  ViewControllerTablero.m
//  JungleTricks v.1
//
//  Created by + on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerTablero.h"

@implementation ViewControllerTablero

@synthesize botonesGraficos, viewTablero, imagenesBotones, juegoTablero, indexNivel, nivelNivel, repeticionesNivel, distanciaRepresentacionNivel, labelPuntuacionTablero, labelTutorialTablero,puntuacion, audioFilePath, audioFileURL, audioPlayer, imagenBarra, imagenNivel,labelJugador, coco1, coco2, coco3;

/*********************************************************************************************************
 Nombre del Método: iniciarJuego
 Entradas:(IBAction)llamada a partir 
 Salidas: (bool)fin: determina si es el fin del juego o no.
 
 Lógica interna: Verificacion del juego (sigue porque la seleccion es correcta pero faltan botones por seleccionar, 
 se acaba se encontraron todos los correctos, o se acaba porque se selecciono un boton equivocado)
 
 Procesos Importantes: 
 1.
 /*********************************************************************************************************/
-(IBAction)iniciarJuego
{
    botonesGraficos = [[NSMutableArray alloc] init];
    imagenesBotones = [[NSMutableArray alloc] init];
    
   
    [imagenesBotones addObject:@"sandia.png"];
    [imagenesBotones addObject:@"kiwi.png"];
    [imagenesBotones addObject:@"bananos.png"];
    [imagenesBotones addObject:@"naranja.png"];
    [imagenesBotones addObject:@"tablita.png"];
    [imagenesBotones addObject:@"sandiaError.png"];
    [imagenesBotones addObject:@"kiwiError.png"];
    [imagenesBotones addObject:@"bananosError.png"];
    [imagenesBotones addObject:@"naranjaError.png"];
    [imagenesBotones addObject:@"tablitaError.png"];
    
    juegoTablero = [[LogicRetoTablero alloc] init];
    [juegoTablero crearTablero];
   
    
    int indexBotones = 0;
    int posicionXBoton = 258;
    int posicionYBoton = 15;
    int tamanoTabla;
    indexNivel = 0;
    repeticionesNivel = 0;
    puntuacion = 0;
    estadoJuego = NO;
    cocos = 3;
    
    

        
    labelTutorialTablero.text = @"Fijate bien y espera";
    
    //--------------------------------------------------------------------------------
    /*Reproduccion del archivo de Audio
    
    audioFilePath = [[NSBundle mainBundle] pathForResource:@"musica" ofType:@"wav"];
    audioFileURL = [NSURL fileURLWithPath:audioFilePath];
    audioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:NULL]; 
    

    [audioPlayer prepareToPlay];
    [audioPlayer setNumberOfLoops:-1];
    [audioPlayer setVolume:2.3];
    [audioPlayer play]; 
    
    //--------------------------------------------------------------------------------*/

    
     [juegoTablero nuevoTablero:indexNivel];
    
    movimientoBarraX = tamanoBarra/juegoTablero.nivelActual.repeticiones;
  
    
    for (int cont = 0; cont < 6; cont ++)
    {
        for (int cont2 = 0; cont2 < 6; cont2++)
        {
            
            BotonTablero *botonTableroTemporal = [[BotonTablero alloc] init];
            
            botonTableroTemporal = [juegoTablero.botones objectAtIndex:indexBotones];
            
            UIButton *botonTemporal = [UIButton buttonWithType: UIButtonTypeCustom];
            botonTemporal.frame = CGRectMake(posicionXBoton, posicionYBoton, 122, 112);
            int valorBoton = botonTableroTemporal.identificador;
            
            
            NSString *imagen = [imagenesBotones objectAtIndex:valorBoton];
            
            [botonTemporal setImage:[UIImage imageNamed:imagen] forState:UIControlStateNormal];
            
            
            
            [botonTemporal setTag: indexBotones];
            [botonTemporal addTarget:self action:@selector(validarJugada:) forControlEvents:UIControlEventTouchDown];
            [botonesGraficos addObject:botonTemporal];
            [viewTablero addSubview:botonTemporal];
            
            if (valorBoton == 5)
            {
                [botonTemporal setHidden: YES];
            }
            
            posicionXBoton = posicionXBoton + 122;
            indexBotones = indexBotones +1;
        }
        posicionYBoton = posicionYBoton +112;
        posicionXBoton = 258; 
    }
    
    [labelTutorialTablero setHidden:NO];
    [botonInicio setHidden:YES];
    
    //representacionNivel.x = 100;
    
    [self performSelector:@selector(ocultarMarcados) withObject:self afterDelay:1.8];    
    
}

   

-(void) reIniciarJuego{
    
    indexNivel = 0;
    repeticionesNivel = 0;
    puntuacion = 0;
    estadoJuego = NO;
     [coco1 setHidden: false];
     [coco2 setHidden: false];
     [coco3 setHidden: false];
    [juegoTablero resetearVidas];
    cocos = 3;
    
    
    labelTutorialTablero.text = @"Fijate bien y espera";
    int nivelMostrar = indexNivel + 1;
    labelNivel.text = [NSString stringWithFormat:@"%i",nivelMostrar];

    for (int cont = 0; cont < 36; cont++)
    {
        
        BotonTablero *botonTableroTemporal = [[BotonTablero alloc] init];
        botonTableroTemporal.identificador = 5;
        botonTableroTemporal.marcado = false;
        botonTableroTemporal.seleccionado = true;
        
        [juegoTablero.botones replaceObjectAtIndex:cont withObject:botonTableroTemporal];
    }
    
    CGPoint center = imagenNivel.center;
    center.x = imagenBarra.frame.origin.x - 10;
    [UIImageView animateWithDuration:0.2 animations:^{imagenNivel.center = center;} ];
    
    [self rePintarTablero:true];
    

    
}
  
    

// Ocultamiento de todos los elementos marcados;
-(void)ocultarMarcados{
    
    estadoJuego = YES;
    labelTutorialTablero.text = @"¿Dónde estaban las frutas?";

    
    BotonTablero *botonTemporalArreglo;
    
     UIButton *botonGraficoTemporal = [[UIButton alloc] init];
    
    
    botonTemporalArreglo = [[BotonTablero alloc] init];
    for (int cont = 0; cont< [juegoTablero.botones count]; cont++) {
       
        botonTemporalArreglo = [juegoTablero.botones objectAtIndex:cont];
        botonGraficoTemporal = [botonesGraficos objectAtIndex:cont];
        [botonGraficoTemporal setImage:[UIImage imageNamed:@"tablita.png"] forState:UIControlStateNormal];
        
        [botonesGraficos replaceObjectAtIndex:cont withObject:botonGraficoTemporal];
        
    }
}
 


-(IBAction)validarJugada:(id)sender{
    
    if (estadoJuego == YES)
    {
        int index = [sender tag];
        if ([juegoTablero revisarSeleccion: index] == 0)
        {
            if (indexNivel == 0)
            {
                labelTutorialTablero.text = @"Fijate bien y espera";
            }
            
            BotonTablero *botonActual = [juegoTablero.botones objectAtIndex:[sender tag]];
            int indexImagen = botonActual.identificador;
            [sender setImage:[UIImage imageNamed:[imagenesBotones objectAtIndex:indexImagen]] forState:UIControlStateNormal];
            
            
            if ([juegoTablero verificarFinDeJuego] == true)
            {
                [self rePintarTablero:false];  
            }
            
        }
        else
        {
            if ([juegoTablero revisarSeleccion: index] == 1)
            {
                 [sender setImage:[UIImage imageNamed:[imagenesBotones objectAtIndex:9]] forState:UIControlStateNormal];
            }
            else
                [self terminarJuego];
            [self quitarCoco];
        }

        
    }
}

-(IBAction)quitarCoco{
    if (cocos == 3)
    {
        [coco3 setHidden: TRUE];
        cocos = cocos-1;
    }
    else 
    {
        if (cocos ==  2)
        {
            [coco2 setHidden: TRUE];
            cocos = cocos-1;
        }else
        {
            [coco1 setHidden: TRUE];
            cocos = cocos-1;
        }
    }
}

-(IBAction)terminarJuego{
    estadoJuego = NO;
    BotonTablero *botonTemporalArreglo;
    
    UIButton *botonGraficoTemporal = [[UIButton alloc] init];
    
    botonTemporalArreglo = [[BotonTablero alloc] init];
    for (int cont = 0; cont< [juegoTablero.botones count]; cont++) {
        
        botonTemporalArreglo = [juegoTablero.botones objectAtIndex:cont];
        botonGraficoTemporal = [botonesGraficos objectAtIndex:cont];
        
        if (botonTemporalArreglo.marcado == true)
        {
            if (botonTemporalArreglo.seleccionado == true)
            {
                NSString *imagen = [imagenesBotones objectAtIndex:botonTemporalArreglo.identificador];
                [botonGraficoTemporal setImage:[UIImage imageNamed:imagen] forState:UIControlStateNormal];
            }
            else
            {
                int indexError = botonTemporalArreglo.identificador+5;
                NSString *imagen = [imagenesBotones objectAtIndex:indexError];
                [botonGraficoTemporal setImage:[UIImage imageNamed:imagen] forState:UIControlStateNormal];
                
            }
        }
        else
        {
            if (botonTemporalArreglo.seleccionado == true)
            {
            
                [botonGraficoTemporal setImage:[UIImage imageNamed:@"tablitaError.png"] forState:UIControlStateNormal];
            }
            else
            {
                [botonGraficoTemporal setImage:[UIImage imageNamed:@"tablita.png"] forState:UIControlStateNormal];
            }

        }

            

        
        
        [botonesGraficos replaceObjectAtIndex:cont withObject:botonGraficoTemporal];
        [botonReInicio setHidden:NO];
        
    }
}



-(IBAction)rePintarTablero:(bool)primero{
     estadoJuego = NO;
    
    if (primero == true)
    {
        //puntuacion = 2000;
        labelPuntuacionTablero.text = @"00";
    }
    else
    {
        repeticionesNivel++;
        
        //AVANZA EL MONO DE LA BARRA
        
        CGPoint center = imagenNivel.center;
        center.x = center.x + movimientoBarraX;
        [UIImageView animateWithDuration:0.2 animations:^{imagenNivel.center = center;} ];
        
        
        puntuacion = puntuacion+ juegoTablero.nivelActual.puntos;
        labelPuntuacionTablero.text = [NSString stringWithFormat:@"%i",puntuacion];
        if (repeticionesNivel == juegoTablero.nivelActual.repeticiones)
        {
            
            
            
            
            
            //VUELVE AL INICIO EL MONO DE LA BARRA
            
            indexNivel++;
            
           
            
            CGPoint center = imagenNivel.center;
            center.x = imagenBarra.frame.origin.x - 10;
            
            [UIImageView animateWithDuration:0.2 animations:^{imagenNivel.center = center;} ];
            
            repeticionesNivel=0;
            posicionInicialNivel = imagenNivel.center.x;
            
                   }
        int nivelMostrar = indexNivel + 1;
        
        
        
        //NSString *nivelLabel = [NSString stringWithFormat:@"%i",indexNivel];
        labelNivel.text = [NSString stringWithFormat:@"%i",nivelMostrar];

        
    }

    if (indexNivel > 0)
    {
        [labelTutorialTablero setHidden:YES];
    }
    
    
    
    [juegoTablero nuevoTablero:indexNivel];
     movimientoBarraX = tamanoBarra/juegoTablero.nivelActual.repeticiones;
    
    UIButton *botonGraficoTemporal = [[UIButton alloc] init];
    
    for (int cont = 0; cont < 36;cont++)
    {
        BotonTablero *botonTableroTemporal = [[BotonTablero alloc] init];
        botonTableroTemporal = [juegoTablero.botones objectAtIndex:cont];
        
        botonGraficoTemporal = [botonesGraficos objectAtIndex:cont];
        
        int valorBoton = botonTableroTemporal.identificador;
        
        NSString *imagen = [imagenesBotones objectAtIndex:valorBoton];
        
        [botonGraficoTemporal setImage:[UIImage imageNamed:imagen] forState:UIControlStateNormal];
        [botonesGraficos replaceObjectAtIndex:cont withObject:botonGraficoTemporal];
        
        if (valorBoton != 5)
        {
            [botonGraficoTemporal setHidden: NO];
        }
        else
        {
            [botonGraficoTemporal setHidden: YES];
        }
    }
    [self performSelector:@selector(ocultarMarcados) withObject:self afterDelay:juegoTablero.nivelActual.tiempo];   
}

   

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    posicionInicialNivel = imagenNivel.center.x;
    tamanoBarra = imagenBarra.frame.size.width;
    //UIImage tablita = new
    //tamanoTablita = 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *nombreJugador = [defaults objectForKey:@"NombreJugador"];
    if (nombreJugador==NULL) {
        nombreJugador = @"Nombre";
    }
    [labelJugador setText:nombreJugador];
    // Do any additional setup after loading the view from its nib.
    //[self pintarTablero];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
     

@end
