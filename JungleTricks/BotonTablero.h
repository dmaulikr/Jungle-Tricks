//
//  BotonTablero.h
//  JungleTricks v.1
//
//  Created by + on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BotonTablero: NSObject{
    bool marcado;                  // El boton es una de las repuestas
    bool seleccionado;             // El boton ya fue seleccionado por el jugador
    int identificador;             // id del boton
    
    
}
@property(nonatomic)bool marcado;
@property(nonatomic)bool seleccionado;
@property(nonatomic)int identificador;

@end

