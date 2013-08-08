//
//  RetoSecuenciaViewController.h
//  Secuencia v
//
//  Created by Alejandra Monge Granados on 24/05/12.
//  Copyright (c) 2012 __Iniciativa GoTouch__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetoSecuenciaLogic.h"
@interface RetoSecuenciaViewController : UIViewController{
    IBOutlet UIView *_viewRetoSecuencia;
    IBOutlet UIImageView *_imagenBarra;
    IBOutlet UIImageView *_imagenNivel;
    IBOutlet UIButton *_startButton;
    IBOutlet UILabel *_level;
    IBOutlet UILabel *_labelScore;
    IBOutlet UILabel *_labelJugador;
    NSMutableArray *_trunksButtons;
    RetoSecuenciaLogic *_logicRetoSecuencia;
    int _positionShown;
    int _tamanoNivel;
    int _tamanoBarra;
    int _movimientoBarraX;
    float _posicionInicialNivel;
}
@property (nonatomic, retain) IBOutlet UIView *_viewRetoSecuencia;
@property (nonatomic, retain) IBOutlet UIImageView *_imagenBarra;
@property (nonatomic, retain) IBOutlet UIImageView *_imagenNivel;
@property (nonatomic, retain) IBOutlet UIButton *_startButton;
@property (nonatomic, retain) IBOutlet UILabel *_level;
@property (nonatomic, retain) IBOutlet UILabel *_labelScore;
@property (nonatomic, retain) IBOutlet UILabel *_labelJugador;
@property (nonatomic, retain) NSMutableArray *_trunksButtons;

-(IBAction)startGame:(id)sender;
-(IBAction)trunkAction:(id)sender;
@end
