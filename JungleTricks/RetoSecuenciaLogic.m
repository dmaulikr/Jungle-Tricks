//
//  RetoSecuenciaLogic.m
//  Secuencia v
//
//  Created by Alejandra Monge Granados on 24/05/12.
//  Copyright (c) 2012 __Iniciativa GoTouch__. All rights reserved.
//

#import "RetoSecuenciaLogic.h"

@implementation RetoSecuenciaLogic
@synthesize _sequence,_actualPosition,_level;

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
 Metodo getElementsByLevel
 Funcion: indica el numero de elementos que va a tener la secuencia dependiendo el nivel que se indica
 */
-(int)getElementsByLevel:(int) pLevel{
    int elements = 3;
    elements = 3+pLevel;
    return elements;
}
/*
 Metodo newSequence
 Funcion: crea una nueva secuencia que representa la cantidad de elementos que tiene un nivel
 */
-(NSMutableArray*)newSequence:(int)pSequenceSize{
    NSMutableArray *sequence =[NSMutableArray array];
    for (int elementIndex= 1; elementIndex <= pSequenceSize; elementIndex++) {
        [sequence addObject:[NSDecimalNumber numberWithInt: elementIndex]];
    }
    return sequence;
    _actualPosition = 0;
}
/*
 Metodo disarraySequence
 Funcion: desordena los elementos del array dado, es utilizado para generar de manera aleatoria el orden en el cual se deben seleccionar los elementos
 */
-(NSMutableArray*)disarraySequence:(NSMutableArray*) pSequence{
    int arraySize;
    int randomIndexValue;
    int actualValue;
    int randomIndex;
    arraySize = [pSequence count]-1;
    while (arraySize >0) {
        randomIndex = [self randomNumber:[pSequence count]];
        randomIndexValue = [[pSequence objectAtIndex:randomIndex]intValue]; 
        actualValue = [[pSequence objectAtIndex:arraySize]intValue];
        [pSequence replaceObjectAtIndex:arraySize withObject:[NSDecimalNumber numberWithInt: randomIndexValue]];
        [pSequence replaceObjectAtIndex:randomIndex withObject:[NSDecimalNumber numberWithInt:actualValue]];
        arraySize = arraySize -1;
    }
    return pSequence;
}
/*
 Metodo getActualPosition
 Funcion: retorna el id del elemento en actual
 */
-(int)getActualPosition{
     return [[_sequence objectAtIndex:_actualPosition]intValue];
}
 
/*
  Metodo setActualPosition
 Funcion: modifica el puntero a la posicion actual 
  */
-(void)setActualPosition:(int)pNewPosition{
    _actualPosition = pNewPosition;
}
 
/*
 Metodo getActualPositionIndex
 Funcion: retorna el puntero a la posicion actual 
*/
-(int) getActualPositionIndex{
    return _actualPosition;
}
  
/*
 Metodo getIdPosition
 Funcion: retorna el id del elemento que se indica
*/
-(int)getIdPosition:(int)pPosition{
    return [[_sequence objectAtIndex:pPosition]intValue];
}
  
/*
 Metodo verifyMovement
 Funcion: dado un id de Elemento indica si es correcto en la secuencia o no lo es
 */
-(BOOL)verifyMovement:(int)idPosition{
    if ([[_sequence objectAtIndex:_actualPosition]intValue]== idPosition) {
        _score = _score+10;
        return TRUE;
        //CAMBIO
        //_actualPosition = _actualPosition+1;
    }
    else {
        if (_score >=10) {
            _score =_score-10;
        }
        else{
            _score =0;
        }
        //_actualPosition = 0;
        return FALSE;
    }
}

/*
 Metodo levelUp
 Funcion: subir de nivel
 */
-(void)levelUp{
    //_actualPosition =0;
    _level++;
    NSMutableArray *temporalSequence = [NSMutableArray array];
    temporalSequence = [self newSequence:[self getElementsByLevel:_level]];
    _sequence = [self disarraySequence:temporalSequence];
    _score = _score + (100*_level);
}
/*
 Metodo newGame
 Funcion: crear una nueva logica de juego
 */
-(void)newGame{
    //_actualPosition = 0;
    _level = 1;
    NSMutableArray *temporalSequence = [NSMutableArray array];
    temporalSequence = [self newSequence:[self getElementsByLevel:_level]];
    _sequence = [self disarraySequence:temporalSequence];
    _score = 0;
}
/*
 Metodo getLevel
 */
-(int) getLevel{
    return _level;
}
/*
 Metodo getLevel
 */
-(int) getScore{
    return _score;
}
@end
