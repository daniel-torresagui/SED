SED
===

Sistemas Electrónicos Digitales - Trabajo

Proyecto del laboratorio de SED implementado en ISE Design 14.7 - XILINX. Se trata de un contador Hexadecimal que raliza la cuenta ascendente o descendete de 00 a 2F. Tiene entradas de carga y reset asíncronas y un selector de cuenta acendente y descendente implementado con un FFSR que hace de circuito antirrebote. Tiene además protección contra una carga superior a 2F que pondra el contador a 00 en caso de que estemos en modo ascendnete o a 2F en caso contrario. Las salidas han sido convertidas directamente a 7 segmentos con una salida de overflow que tendrá un valor alto siempre que la cuenta haya sido reiniciada, es decir, haya llegado al limite y por tanto haya comenzado de nuevo, y solo se podrá poner a nivel bajo tras reiniciar con la entrada de reset el contador.
