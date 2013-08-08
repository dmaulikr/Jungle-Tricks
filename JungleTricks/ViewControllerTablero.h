//
//  ViewControllerTablero.h
//  JungleTricks v.1
//
//  Created by + on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BotonTablero.h"
#import "LogicRetoTablero.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioPlayer.h>



@interface ViewControllerTablero : UIViewController
{
    //SECCION DE ELEMENTOS GRAFICOS
    IBOutlet UIView *viewTablero;
    NSMutableArray *botonesGraficos; // Arreglo donde se almacenan los botones de la memoria
    NSMutableArray *imagenesBotones;
    IBOutlet UILabel *labelPuntuacionTablero;
    IBOutlet UILabel *labelTutorialTablero;
    IBOutlet UILabel *labelNivel;
    IBOutlet UIButton *botonInicio;
    IBOutlet UIButton *botonReInicio;
    IBOutlet UILabel *labelJugador;
    IBOutlet UIImageView *imagenBarra;
    IBOutlet UIImageView *imagenNivel;
    IBOutlet UIImageView *coco1;
    IBOutlet UIImageView *coco2;
    IBOutlet UIImageView *coco3;
    
    
    int tamanoNivel;
    int tamanoBarra;
    int movimientoBarraX;
    float posicionInicialNivel;
    
    
    int tamanoTablita;
    
   
    

    
    //SECCION DE ELEMENTOS LOGICOS
    LogicRetoTablero *juegoTablero;
    bool estadoJuego;
    int indexNivel;
    int repeticionesNivel;
    int puntuacion;
    int nivelNivel;
    int distanciaRepresentacionNivel;
    int cocos;
    
    //ELEMENTOS DE AUDIO
    
    NSString *audioFilePath;
    NSURL *audioFileURL;
    AVAudioPlayer* audioPlayer;
    
    
    
    
    
}

-(IBAction)iniciarJuego;
-(IBAction)reIniciarJuego;
-(IBAction)rePintarTablero:(bool)primero;
-(IBAction)actualizarTablero;
-(IBAction)validarJugada:(id)sender;
-(void)ocultarMarcados;
-(IBAction)terminarJuego;
-(IBAction)quitarCoco;



@property (nonatomic, retain) IBOutlet UIView *viewTablero;
@property (nonatomic, retain) NSMutableArray *botonesGraficos;
@property (nonatomic, retain) NSMutableArray *imagenesBotones;
@property (nonatomic, retain) LogicRetoTablero *juegoTablero;
@property (nonatomic) int indexNivel;
@property (nonatomic) int repeticionesNivel;
@property (nonatomic) int puntuacion;
@property (nonatomic) int nivelNivel;
@property (nonatomic) int distanciaRepresentacionNivel;
@property (nonatomic, retain) IBOutlet UILabel *labelPuntuacionTablero;
@property (nonatomic, retain) IBOutlet UILabel *labelTutorialTablero;
@property (nonatomic, retain) IBOutlet UILabel *labelNivel;
@property (nonatomic, retain) IBOutlet UILabel *labelJugador;
@property (nonatomic, retain) IBOutlet UIButton *botonInicio;
@property (nonatomic, retain) IBOutlet UIButton *botonReInicio;
@property (nonatomic, retain) IBOutlet UIImageView *imagenBarra;
@property (nonatomic, retain) IBOutlet UIImageView *imagenNivel;
@property (nonatomic, retain) IBOutlet UIImageView *coco1;
@property (nonatomic, retain) IBOutlet UIImageView *coco2;
@property (nonatomic, retain) IBOutlet UIImageView *coco3;

@property (nonatomic, retain) NSString *audioFilePath;
@property (nonatomic, retain) NSURL *audioFileURL;
@property (nonatomic, retain) AVAudioPlayer* audioPlayer;



@end
