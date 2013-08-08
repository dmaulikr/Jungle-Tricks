//
//  LogicRetoTablero.h
//  JungleTricks v.1
//
//  Created by + on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BotonTablero.h"
#import "NivelRetoTablero.h"

@interface LogicRetoTablero : NSObject
{
    bool estadoDeJuego;      // Determina el estado del juego
    NSMutableArray *botones; // Arreglo donde se almacenan los botones de la memoria
    NSMutableArray *niveles;
    
    int indexNivelActual;
    NivelRetoTablero *nivelActual;
    int vidas;
    
    
    
    
    //Variable temporal para manejar el primer nivel;
    const int *nivelUno;
    
    


}

@property (nonatomic) bool estadoDeJuego;
@property (nonatomic,retain)NSMutableArray *botones;
@property (nonatomic,retain)NSMutableArray *nivel1;
@property (nonatomic,retain)NivelRetoTablero *nivelActual;
@property (nonatomic) int vidas;
//@property (nonatomic,retain)NSMutableArray *niveles;

-(void)crearTablero;
-(void)nuevoTablero:(int)nivel;
-(int)revisarSeleccion:(int)identificador;
-(bool)verificarFinDeJuego;
-(void)cargarNiveles;
-(void)quitarVida;
-(bool)estaVivo;
-(void)resetearVidas;
//-(bool)buscarEnNivel: (int)posicion;






@end
