//
//  LogicRetoTablero.m
//  JungleTricks v.1
//
//  Created by + on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LogicRetoTablero.h"
#import "BotonTablero.h"

@implementation LogicRetoTablero
@synthesize estadoDeJuego, botones, nivelActual;


/*********************************************************************************************************
 Nombre del Método: crearTablero
 Entradas:
 Salidas: 
 
 Lógica interna: 
 
 Procesos Importantes:
 
 1.
 *********************************************************************************************************/ 
-(void)crearTablero{
    vidas = 4;
    botones = [[NSMutableArray alloc] init];
    niveles = [[NSMutableArray alloc] init];
    
    
    nivelActual = [[NivelRetoTablero alloc] init];
    for (int i = 0; i < 36; i++){
        
            
        
        BotonTablero *botonTableroTemporal = [[BotonTablero alloc] init];

        botonTableroTemporal.identificador = 5;
        botonTableroTemporal.marcado = false;
        botonTableroTemporal.seleccionado = false;
        
        [botones addObject: botonTableroTemporal];
        //
        
        [self cargarNiveles];

    }
    
}
/*********************************************************************************************************
 Nombre del Método: nuevoTablero
 Entradas:(int) nivel 
 Salidas: (void) ninguna
 
 Lógica interna: El metodo toma un índice de nivel, que es evíado desde el view controller de la clase,
 a partir de este toma datos importantes como:
 
(int) sizeNivel: tamano de posiciones activas del tablero en el nivel
(int) min: el minimo de posiciones a ser marcadas
(int) max: el máximo de posiciones a ser marcadas
(int const) posicionesActivas: arreglo con los indices de las posiciones activas en el tablero
 
 Con los que genera otros datos como:
 (int) rangoPosicionesMarcadas: que indica un rango para marcar las posiciones aleatoriamenteñ
 (int) cantidadMarcados: a partir del rango, el mínimo y el máximo, elige un número aleatoriamente que será
                        la cantidad de posiciones marcadas en ese tablero en particular.
 
 (NSMutableArray) posicionesPorMarcar: copia las posiciones activas del nivel (posicionesActivas) en un 
                        arreglo dináminco, de forma que se puedan ir eliminando las posiciones a las que se les
                        ha asignado un valor.
 
 Procesos Importantes:
 
        1. Asignación de Variables.
        2. Asignación de valores a posiciones marcadas.
        3. Asignación de valores a posiciones restantes (sin marcar).
 
*********************************************************************************************************/ 

-(void)nuevoTablero:(int)nivel{
 
    /*------------------------- Asignación de Variables -------------------------*/
    nivelActual = [niveles objectAtIndex:nivel];
    int sizeNivel = nivelActual.size;
    int rangoPosicionesMarcadas = nivelActual.max - nivelActual.min;
    int cantidadMarcados = arc4random() %rangoPosicionesMarcadas;
    cantidadMarcados = cantidadMarcados + nivelActual.min;
    int cantidadNoMarcados = sizeNivel - cantidadMarcados;
    
    NSMutableArray *posicionesPorMarcar = [[NSMutableArray alloc] init];
    int temp;
    for (int cont = 0; cont < sizeNivel; cont++)
    {
        temp = nivelActual.posicionesActivas[cont];
        [posicionesPorMarcar addObject: [NSDecimalNumber numberWithInt: temp]];   
    }
    /*-----------------------------------------------------------------------------*/
    
    /*-----------------Asignación de valores a posiciones marcadas.-----------------*/
    for (int cont2 = 0; cont2 < cantidadMarcados; cont2++)
    {
        int sizePosicionesMarcadas = [posicionesPorMarcar count];
        int indexPosicionesMarcadas = arc4random() %sizePosicionesMarcadas;
        BotonTablero *botonTableroTemporal = [[BotonTablero alloc] init];
        botonTableroTemporal.marcado = true;
        botonTableroTemporal.identificador = arc4random() %4;
        int indexPosicion = [[posicionesPorMarcar objectAtIndex:indexPosicionesMarcadas]intValue];
        [botones replaceObjectAtIndex:indexPosicion withObject:botonTableroTemporal];
        [posicionesPorMarcar removeObjectAtIndex:indexPosicionesMarcadas];
   
    }
    /*-----------------------------------------------------------------------------*/
    /*-------------Asignación de valores a posiciones restantes (sin marcar).------*/
    int indexNoMarcados =0;    
    for (int cont3 = 0; cont3 < sizeNivel; cont3++) 
    {
        cantidadNoMarcados = [posicionesPorMarcar count];
        if (indexNoMarcados < cantidadNoMarcados) 
        {
            int indexPosicionesActivas = nivelActual.posicionesActivas[cont3];
            int indexMarcadas = [[posicionesPorMarcar objectAtIndex:indexNoMarcados]intValue];
            
            if (indexPosicionesActivas == indexMarcadas)
            {
                BotonTablero *botonTableroTemporal = [[BotonTablero alloc] init];
                botonTableroTemporal.marcado = false;
                botonTableroTemporal.identificador = 4;
                [botones replaceObjectAtIndex:indexPosicionesActivas withObject:botonTableroTemporal]; 
                id pos = [NSNumber numberWithInteger: indexPosicionesActivas];
                [posicionesPorMarcar removeObject:pos];
            }
        }
        else
        {
            break;
        }

    } 
     
}   

/*********************************************************************************************************
 Nombre del Método: revisarSeleccion
 Entradas:(int)identificador
 Salidas: (bool)revision
 
 Lógica interna: 
 
 Procesos Importantes:
 
 1.
 *********************************************************************************************************/ 
-(int)revisarSeleccion:(int)identificador{
    
    int revision;

    BotonTablero *botonTableroTemporal = [[BotonTablero alloc] init];
    
    botonTableroTemporal = [botones objectAtIndex:identificador];
    botonTableroTemporal.seleccionado = true;
    
    // La opción seleccionada no está marcada, es decir Falló
    if (botonTableroTemporal.marcado == false)
    {
        if ([self estaVivo] == true)
        {
            revision = 1;
        }
        else
            revision = 2;
        [self quitarVida];
    }
    else // La opción seleccionada está marcada, es decir Acertó
    {
        [botones replaceObjectAtIndex:identificador withObject:botonTableroTemporal];
        revision = 0;
    }
    return revision;
}

/*********************************************************************************************************
 Nombre del Método: verificarFinDeJuego
 Entradas:(void)ninguna
 Salidas: (bool)fin: determina si es el fin del juego o no.
 
 Lógica interna: Verificacion del juego (sigue porque la seleccion es correcta pero faltan botones por seleccionar, 
 se acaba se encontraron todos los correctos, o se acaba porque se selecciono un boton equivocado)
 
 Procesos Importantes:
 
 1.
 *********************************************************************************************************/ 
-(bool)verificarFinDeJuego{
    int i = 0;
    i++;
    
    bool fin = true;
    for (int cont = 0; cont < 36; cont++)
    {
        BotonTablero *botonTableroTemporal = [botones objectAtIndex:cont];

        bool marcado = botonTableroTemporal.marcado;
        bool seleccionado = botonTableroTemporal.seleccionado;
        
        if (marcado == true && seleccionado == false)
        {
            fin = false;
        }   
    }
    return fin;
}



/*********************************************************************************************************
 Nombre del Método: quitarVida
 *********************************************************************************************************/ 
-(void)quitarVida
{
    vidas = vidas-1;
}

-(bool)estaVivo
{
    bool respuesta;
    if (vidas > -1)
        respuesta = true;
    else
        respuesta = false;
    return respuesta;
}

-(void)resetearVidas
{
    vidas = 4;
}




/*********************************************************************************************************
 Nombre del Método: cargarNiveles
 Entradas:
 Salidas: 
 
 Lógica interna: 
 
 Procesos Importantes:
 
 1.
 *********************************************************************************************************/ 
-(void)cargarNiveles{
    
    int repeticiones = 3;
    float tiempo = 1.8;
    
    NivelRetoTablero *nivelTableroTemporal = [[NivelRetoTablero alloc] init];
    static const int temporal[4] = {14,15,20,21};
    nivelTableroTemporal.posicionesActivas = temporal;
    nivelTableroTemporal.repeticiones = repeticiones;
    nivelTableroTemporal.tiempo = tiempo;
    nivelTableroTemporal.puntos = 15;
    nivelTableroTemporal.max = 3;
    nivelTableroTemporal.min = 1;
    nivelTableroTemporal.size = 4;
    
    [niveles addObject:nivelTableroTemporal];
    
    NivelRetoTablero *nivelTableroTemporal2 = [[NivelRetoTablero alloc] init];
    static const int temporal2[8] = {8,14,15,16,19,20,21,27};
    nivelTableroTemporal2.posicionesActivas = temporal2;
    nivelTableroTemporal2.repeticiones = repeticiones+3;
    nivelTableroTemporal2.tiempo = tiempo+0.8;
    nivelTableroTemporal2.puntos = 30;
    nivelTableroTemporal2.max = 6;
    nivelTableroTemporal2.min = 4;
    nivelTableroTemporal2.size = 8;
    [niveles addObject:nivelTableroTemporal2];
    
    NivelRetoTablero *nivelTableroTemporal3 = [[NivelRetoTablero alloc] init];
    static const int temporal3[12] = {8,9,13,14,15,16,19,20,21,22,26,27};
    nivelTableroTemporal3.posicionesActivas = temporal3;
    nivelTableroTemporal3.repeticiones = repeticiones+3;
    nivelTableroTemporal3.tiempo = tiempo+0.8;
    nivelTableroTemporal3.puntos = 50;
    nivelTableroTemporal3.max = 10;
    nivelTableroTemporal3.min = 6;
     nivelTableroTemporal3.size = 12;
    [niveles addObject:nivelTableroTemporal3];
    
    NivelRetoTablero *nivelTableroTemporal4 = [[NivelRetoTablero alloc] init];
    static const int temporal4[16] = {2,8,9,13,14,15,16,17,18,19,20,21,22,26,27,33};
    nivelTableroTemporal4.posicionesActivas = temporal4;
    nivelTableroTemporal4.repeticiones = repeticiones+3;
    nivelTableroTemporal4.tiempo = tiempo+0.8;
    nivelTableroTemporal4.puntos = 65;
    nivelTableroTemporal4.max = 13;
    nivelTableroTemporal4.min = 8;
    nivelTableroTemporal4.size = 16;
    [niveles addObject:nivelTableroTemporal4];
    
    NivelRetoTablero *nivelTableroTemporal5 = [[NivelRetoTablero alloc] init];
    static const int temporal5[20] = {2,3,8,9,12,13,14,15,16,17,18,19,20,21,22,23,26,27,32,33};
    nivelTableroTemporal5.posicionesActivas = temporal5;
    nivelTableroTemporal5.repeticiones = repeticiones+3;
    nivelTableroTemporal5.tiempo = tiempo+1;
    nivelTableroTemporal5.puntos = 80;
    nivelTableroTemporal5.max = 17;
    nivelTableroTemporal5.min = 10;
    nivelTableroTemporal5.size = 20;
    [niveles addObject:nivelTableroTemporal5];
    
    NivelRetoTablero *nivelTableroTemporal6 = [[NivelRetoTablero alloc] init];
    static const int temporal6[24] = {2,3,7,8,9,10,12,13,14,15,16,17,18,19,20,21,22,23,25,26,27,28,32,33};
    nivelTableroTemporal6.posicionesActivas = temporal6;
    nivelTableroTemporal6.repeticiones = repeticiones+3;
    nivelTableroTemporal6.tiempo = tiempo+1.1;
    nivelTableroTemporal6.puntos = 95;
    nivelTableroTemporal6.max = 21;
    nivelTableroTemporal6.min = 12;
    nivelTableroTemporal6.size = 24;
    [niveles addObject:nivelTableroTemporal6];
    
    NivelRetoTablero *nivelTableroTemporal7 = [[NivelRetoTablero alloc] init];
    static const int temporal7[28] = {0,2,3,5,8,9,12,13,14,15,16,17,18,19,20,21,22,23,26,27,30,32,33,35};
    nivelTableroTemporal7.posicionesActivas = temporal7;
    nivelTableroTemporal7.repeticiones = repeticiones+3;
    nivelTableroTemporal7.tiempo = tiempo+1.3;
    nivelTableroTemporal7.puntos = 105;
    nivelTableroTemporal7.max = 24;
    nivelTableroTemporal7.min = 14;
    nivelTableroTemporal7.size = 28;
    [niveles addObject:nivelTableroTemporal7];
    
    NivelRetoTablero *nivelTableroTemporal8 = [[NivelRetoTablero alloc] init];    
    static const int temporal8[32] = {0,2,3,4,5,6,8,9,12,13,14,15,16,17,18,19,20,21,22,23,26,27,29,30,31,32,33,35};
    nivelTableroTemporal8.posicionesActivas = temporal8;
    nivelTableroTemporal8.repeticiones = repeticiones+3;
    nivelTableroTemporal8.tiempo = tiempo+1.5;
    nivelTableroTemporal8.puntos = 125;
    nivelTableroTemporal8.max = 28;
    nivelTableroTemporal8.min = 16;
    nivelTableroTemporal8.size = 32;
    [niveles addObject:nivelTableroTemporal8];
    
    NivelRetoTablero *nivelTableroTemporal9 = [[NivelRetoTablero alloc] init];  
    static const int temporal9[36] = {0,1,2,3,4,5,6,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,29,30,31,32,33,34,35};
    nivelTableroTemporal9.posicionesActivas = temporal9;
    nivelTableroTemporal9.repeticiones = repeticiones+3;
    nivelTableroTemporal9.tiempo = tiempo+0.8;
    nivelTableroTemporal9.puntos = 145;
    nivelTableroTemporal9.max = 32;
    nivelTableroTemporal9.min = 18;
     nivelTableroTemporal9.size = 36;
    [niveles addObject:nivelTableroTemporal9];


}



@end
