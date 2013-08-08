//
//  RetoSecuenciaLogic.h
//  Secuencia v
//
//  Created by Alejandra Monge Granados on 24/05/12.
//  Copyright (c) 2012 __Iniciativa GoTouch__. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
    Esta clase representa la logica del reto Secuencia
*/
@interface RetoSecuenciaLogic : NSObject{
    NSMutableArray *_sequence;   // Arreglo que indica el orden en el cual se deben seleccionar los elementos
    NSUInteger _actualPosition;  // Indica la posicion en la cual esta dentro del arreglo _secuencia
    NSUInteger _level;           // Representa el nivel de dificultad de juego
    NSUInteger _score;
}
@property (nonatomic,retain) NSMutableArray *_sequence;
@property (nonatomic) NSUInteger _actualPosition;
@property (nonatomic) NSUInteger _level;


-(int)getElementsByLevel:(int) pLevel;
-(NSMutableArray*)newSequence:(int) pSequenceSize;
-(NSMutableArray*)disarraySequence:(NSMutableArray*) pSequence;
-(int)getActualPosition;
-(int)getIdPosition:(int)pPosition;
-(BOOL)verifyMovement:(int)idPosition;
-(void)levelUp;
-(void)newGame;
-(void)setActualPosition:(int)pNewPosition;
-(int) getActualPositionIndex;
-(int) getLevel;
-(int) getScore;
@end
