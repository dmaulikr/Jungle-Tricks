//
//  Jugador.h
//  JungleTricks v.1
//
//  Created by + on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jugador : NSObject

{
    NSString *nombre;
    int puntosCodigos;
    int puntosTablero;
    bool sonido;
    int volumen;
    bool idioma;
}


@property (nonatomic,retain)NSString *nombre;
@property (nonatomic) int puntosCodigos;
@property (nonatomic) int puntosTablero;
@property (nonatomic) bool sonido;
@property (nonatomic) int volumen;
@property (nonatomic) bool idioma;

-(void)setName;
-(NSString*)getName;






@end
