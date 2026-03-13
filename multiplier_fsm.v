/*
Autor: Fabian Chacón
Módulo: multiplier_fsm

Descripción:
Máquina de estados que controla el multiplicador secuencial de 32 bits.

Algoritmo:
1. Espera señal start.
2. Repite 32 ciclos:
       si (lsb == 1) → add
       shift
3. Cuando termina → done = 1

Entradas:
- clk
- reset
- start
- lsb (bit menos significativo del producto)

Salidas:
- add
- shift
- done
*/

module multiplier_fsm(

    input clk,
    input reset,
    input start,
    input lsb,

    output reg add,
    output reg shift,
    output reg done

);

reg [5:0] count;   // cuenta hasta 32
reg state;

localparam IDLE = 0;
localparam RUN  = 1;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= IDLE;
        count <= 0;
        add   <= 0;
        shift <= 0;
        done  <= 0;
    end

    else
    begin

        case(state)

        IDLE:
        begin
            done <= 0;
            add  <= 0;
            shift <= 0;

            if(start)
            begin
                state <= RUN;
                count <= 0;
            end
        end

        RUN:
        begin
            add   <= lsb;     // sumar si el bit es 1
            shift <= 1;

            count <= count + 1;

            if(count == 31)
            begin
                state <= IDLE;
                done  <= 1;
            end
        end

        endcase

    end

end

endmodule