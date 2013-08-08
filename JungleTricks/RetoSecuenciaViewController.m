//
//  RetoSecuenciaViewController.m
//  Secuencia v
//
//  Created by Alejandra Monge Granados on 24/05/12.
//  Copyright (c) 2012 __Iniciativa GoTouch__. All rights reserved.
//

#import "RetoSecuenciaViewController.h"

@implementation RetoSecuenciaViewController
@synthesize _startButton,_trunksButtons,_viewRetoSecuencia,_imagenBarra,_imagenNivel,_level,_labelScore,_labelJugador;
/*
 Metodo randomNumber
 Funcion: genera un numero aleatorio entre 0 y un limite dado.
 Utilizado para desordenar la secuencia del juego
 */
-(int)randomNumber:(int)pLimit{
    int newNumber;
    newNumber = (arc4random() % pLimit);
    return newNumber;
}

/*
 Metodo showNext
 Funcion: muestra en pantalla el siguiente tronco en la secuencia*/
 -(void)showNext:(int)pPositionShown{
    int idPositionShown = [_logicRetoSecuencia getIdPosition:pPositionShown];
    UIButton *temporalButton = [_trunksButtons objectAtIndex:idPositionShown-1];
    [temporalButton setImage:[UIImage imageNamed:@"tronco-check.png"] forState:UIControlStateNormal];
 }

/*
 Metodo hideNext
 Funcion: ocultar el elemento que se esta mostrando
 */
-(void)hideNext{
    int idPositionShown = [_logicRetoSecuencia getIdPosition:_positionShown];
    UIButton *temporalButton = [_trunksButtons objectAtIndex:idPositionShown-1];
    [temporalButton setImage:[UIImage imageNamed:@"tronco.png"] forState:UIControlStateNormal];
}
/*
 Metodo showNextMove
 Funcion: muestra y oculta despues de unos segundos el siguiente tronco de la secuencia
 */
-(void)showNextMove{
    [self showNext:_positionShown];
    [self performSelector:@selector(hideNext) withObject:self afterDelay:1.8];
}
-(void)moverNivel{
    CGPoint center = _imagenNivel.center;
    center.x = center.x + 40;
    //[UIImageView animateWithDuration:0.2 animations:^{
    //    _imagenNivel.center = center;
    //} ];
    
    _imagenNivel.center = CGPointMake(_imagenNivel.center.x + _movimientoBarraX, _imagenNivel.center.y);
    //[_imagenNivel setImage:[UIImage imageNamed:@"tronco.png"]];
    
}
/*
 Metodo resetTrunks
 Funcion: desmarcar los troncos que el usuario ya ha marcado
 */
-(void)resetTrunks{
    for (int cont= 0;cont< [_trunksButtons count]; cont++) {
        UIButton *botonTemporal = [_trunksButtons objectAtIndex:cont];
        [botonTemporal setImage:[UIImage imageNamed:@"tronco.png"] forState:UIControlStateNormal];
    }
}
/*
 Metodo removeTrunks
 Funcion: eliminar las marcas de los troncos para inciar un nuevo subnivel o nivel
 */
-(void)removeTrunks{
    for (int cont= 0;cont< [_trunksButtons count]; cont++) {
        UIButton *botonTemporal = [_trunksButtons objectAtIndex:cont];
        [botonTemporal removeFromSuperview];
    }
}

/*
 Metodo trunkAction
 Funcion: accion que sucede cuando se selecciona un boton de tronco
 */
-(IBAction)trunkAction:(id)sender{
    int idActualTrunk; 
    int trunksAmount;
    trunksAmount = [_logicRetoSecuencia getElementsByLevel:[_logicRetoSecuencia getLevel]];
    idActualTrunk = (int) [sender tag];
    if([_logicRetoSecuencia verifyMovement:idActualTrunk]){
        
        [sender setImage:[UIImage imageNamed:@"tronco-check.png"] forState:UIControlStateNormal];
        int idActualPosition = [_logicRetoSecuencia getActualPositionIndex];
        if (_positionShown == idActualPosition) {
           [_logicRetoSecuencia set_actualPosition:0];
            _positionShown = _positionShown +1;
            if (trunksAmount==_positionShown) {
                [self performSelector:@selector(removeTrunks) withObject:self afterDelay:1.8];
                [self performSelector:@selector(nextLevel) withObject:self afterDelay:1.9];
                _movimientoBarraX = _tamanoBarra/_tamanoNivel;
            }
            else{
                [self moverNivel];
                [self performSelector:@selector(resetTrunks) withObject:self afterDelay:0.5];
                [self performSelector:@selector(showNextMove) withObject:self afterDelay:1.0];
                [_labelScore setText:[NSString stringWithFormat:@"%i",[_logicRetoSecuencia getScore]]];
            }
        }
        else{
             [_logicRetoSecuencia setActualPosition:(idActualPosition+1)];
        }
        [_labelScore setText:[NSString stringWithFormat:@"%i",[_logicRetoSecuencia getScore]]];
    }
    else{
        [self resetTrunks];
        [_logicRetoSecuencia setActualPosition:0];
        [_labelScore setText:[NSString stringWithFormat:@"%i",[_logicRetoSecuencia getScore]]];
    }
}
/*
 Metodo showTrunk
 Funcion: dibujar un boton en la pantalla de juego que dadas las coordenadas de ubicacion y su id
 correspondiente
 */
-(void)showTrunk:(int)pcoordinateX:(int)pcoordinateY:(int)idTrunkButton{
    UIButton *temporalTrunkButton = [UIButton buttonWithType: UIButtonTypeCustom];
    temporalTrunkButton.frame = CGRectMake(pcoordinateX,pcoordinateY, 112, 122); 
    [temporalTrunkButton setImage:[UIImage imageNamed:@"tronco.png"] forState:UIControlStateNormal];
    [temporalTrunkButton setTag:idTrunkButton];
    [temporalTrunkButton addTarget:self action:@selector(trunkAction:) forControlEvents:UIControlEventTouchDown];
    [_viewRetoSecuencia addSubview:temporalTrunkButton];  
    [_trunksButtons addObject:temporalTrunkButton];
}

/*
 Metodo showTrunks
 Funcion: dibujar los troncos para cada nivel
 */
-(void)showTrunks:(int)numberTrunks{
    /*int coordinateX = 100;
     int coordinateY = 100;
     for (int actualTrunk = 1; actualTrunk<=numberTrunks; actualTrunk++) {
     [self showTrunk:coordinateX :coordinateY :actualTrunk];
     coordinateX = coordinateX + 150;
     }*/
    int numeroAleatorioPosiciones;    // Indica el area en la que se va a ubicar el tronco
    int numeroAleatorio;              // Numero generado de manera aleatoria que se sumara a la posicion de x y de y con el fin de tener una variacion en la distribucion de los troncos
    //int cantidadTroncos = 9;          // cantidad de troncos que se deben dibujar   ---> esto va a aser un parametro de entrada de la funcion
    int coordenadaXAreaUno = 230;     // Coordenada x inicial para el area uno
    int coordenadaYAreaUno = 600;     // Coordenada y inicial para el area uno
    int coordenadaXAreaDos = 350;     // Coordenada x inicial para el area Dos
    int coordenadaYAreaDos = 520;     // Coordenada y inicial para el area Dos
    int coordenadaXAreaTres = 390;     // Coordenada x inicial para el area tres
    int coordenadaYAreaTres = 400;     // Coordenada y inicial para el area tres
    int anchoTronco = 112;            // Ancho  inicial de un tronco 
    int altoTronco = 122;             // Alto inicial de un trocno
    for (int contadorTroncos = 1; contadorTroncos<= numberTrunks; contadorTroncos++) {
        if (numberTrunks <10) {
            numeroAleatorioPosiciones = [self  randomNumber:3];
            if (numeroAleatorioPosiciones == 1){
                numeroAleatorio = [self randomNumber:30];
                coordenadaYAreaDos = coordenadaYAreaDos + numeroAleatorio;
                UIButton *boton = [UIButton buttonWithType: UIButtonTypeCustom];
                boton.frame = CGRectMake(coordenadaXAreaDos, coordenadaYAreaDos, altoTronco - 30, anchoTronco-30);
                [boton setImage:[UIImage imageNamed:@"tronco.png"] forState:UIControlStateNormal];
                [boton setTag:contadorTroncos];
                [boton addTarget:self action:@selector(trunkAction:) forControlEvents:UIControlEventTouchDown];
                [_viewRetoSecuencia addSubview:boton];  
                [_trunksButtons addObject:boton];
                coordenadaXAreaDos = coordenadaXAreaDos + 100;
                coordenadaYAreaDos = coordenadaYAreaDos - numeroAleatorio;
                
            }
            else if (numeroAleatorioPosiciones == 2){
                numeroAleatorio = [self randomNumber:20];
                coordenadaYAreaTres = coordenadaYAreaTres + numeroAleatorio;
                UIButton *boton = [UIButton buttonWithType: UIButtonTypeCustom];
                boton.frame = CGRectMake(coordenadaXAreaTres, coordenadaYAreaTres, altoTronco - 50, anchoTronco-50);
                [boton setImage:[UIImage imageNamed:@"tronco.png"] forState:UIControlStateNormal];
                [boton setTag:contadorTroncos];
                [boton addTarget:self action:@selector(trunkAction:) forControlEvents:UIControlEventTouchDown];
                [_viewRetoSecuencia addSubview:boton];   
                [_trunksButtons  addObject:boton];
                coordenadaXAreaTres = coordenadaXAreaTres + 90;
                coordenadaYAreaTres = coordenadaYAreaTres - numeroAleatorio;
            }
            else{
                numeroAleatorio = [self randomNumber:40];
                coordenadaYAreaUno = coordenadaYAreaUno + numeroAleatorio;
                UIButton *boton = [UIButton buttonWithType: UIButtonTypeCustom];
                boton.frame = CGRectMake(coordenadaXAreaUno, coordenadaYAreaUno, altoTronco, anchoTronco);
                [boton setImage:[UIImage imageNamed:@"tronco.png"] forState:UIControlStateNormal];
                [boton setTag:contadorTroncos];
                [boton addTarget:self action:@selector(trunkAction:) forControlEvents:UIControlEventTouchDown];
                [_viewRetoSecuencia addSubview:boton];  
                [_trunksButtons  addObject:boton];
                coordenadaXAreaUno = coordenadaXAreaUno + 115;
                coordenadaYAreaUno = coordenadaYAreaUno - numeroAleatorio;
            }
        }
    }
    
}
-(void)nextLevel{
    [_trunksButtons removeAllObjects]; 
    _positionShown = 0;
    [_logicRetoSecuencia levelUp];
    // Valor label Nivel
    [_level setText:[NSString stringWithFormat:@"%i",[_logicRetoSecuencia getLevel]]];
    [_labelScore setText:[NSString stringWithFormat:@"%i",[_logicRetoSecuencia getScore]]];
    [self showTrunks:[_logicRetoSecuencia getElementsByLevel:[_logicRetoSecuencia getLevel]]];
    [self showNextMove];
    _tamanoNivel = [_logicRetoSecuencia getElementsByLevel:[_logicRetoSecuencia getLevel]];
    _imagenNivel.center = CGPointMake(_posicionInicialNivel, _imagenNivel.center.y);
}

/*
 Metodo startGame
 Funcion: crea un nuevo juego de tipo RetoSecuencia
 */
-(IBAction)startGame:(id)sender{
    _positionShown = 0;
    _trunksButtons =[[NSMutableArray alloc] init];
    _logicRetoSecuencia = [[RetoSecuenciaLogic alloc] init];
    [_logicRetoSecuencia newGame];
    _tamanoNivel = [_logicRetoSecuencia getElementsByLevel:1];
    // Valor label Nivel
    [_level setText:[NSString stringWithFormat:@"%i",[_logicRetoSecuencia getLevel]]];
    // AQUI ESTAMOS 
    _movimientoBarraX = _tamanoBarra/_tamanoNivel;
    [self showTrunks:_tamanoNivel];
    [self showNextMove];
    
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    _posicionInicialNivel = _imagenNivel.center.x;
    _tamanoBarra = _imagenBarra.frame.size.width;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *nombreJugador = [defaults objectForKey:@"NombreJugador"];
    if (nombreJugador==NULL) {
        nombreJugador = @"Bienvenido ingresa tu nombre";
    }
    
    [_labelJugador setText:nombreJugador];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //_posicionInicialNivel = _imagenNivel.center.x;
    //_tamanoBarra = _imagenBarra.frame.size.width;
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
