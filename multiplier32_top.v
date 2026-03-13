/*
Autor: Fabian Chacón
Módulo: multiplier32_top

Descripción:
Módulo superior del multiplicador secuencial de 32 bits.

Conecta:
- FSM (control)
- Datapath (registros + ALU)

Entradas:
clk, reset, start
operandos a y b

Salidas:
result (producto 64 bits)
done (operación finalizada)

Ejemplo de uso:

multiplier32_top mult(
    .clk(clk),
    .reset(reset),
    .start(start),
    .a(opA),
    .b(opB),
    .result(product),
    .done(done)
);
*/

module multiplier32_top(

    input clk,
    input reset,
    input start,

    input [31:0] a,
    input [31:0] b,

    output [63:0] result,
    output done

);

wire add;
wire shift;
wire lsb;


// instancia del datapath
multiplier_datapath datapath(

    .clk(clk),
    .reset(reset),

    .add(add),
    .shift(shift),

    .multiplicand(a),
    .multiplier(b),

    .product(result),
    .lsb(lsb)

);


// instancia de la FSM
multiplier_fsm control(

    .clk(clk),
    .reset(reset),
    .start(start),

    .lsb(lsb),

    .add(add),
    .shift(shift),
    .done(done)

);

endmodule