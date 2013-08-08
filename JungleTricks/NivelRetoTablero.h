//
//  NivelRetoTablero.h
//  JungleTricks v.1
//
//  Created by + on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NivelRetoTablero : NSObject{
    
    const int *posicionesActivas;
    int repeticiones;
    int puntos;
    float tiempo;
    int max;
    int min;
    int size;
    
}

@property (nonatomic) const int *posicionesActivas;
@property (nonatomic) int puntos;
@property (nonatomic) int repeticiones;
@property (nonatomic) float tiempo;
@property (nonatomic) int max;
@property (nonatomic) int min;
@property (nonatomic) int size;


@end
