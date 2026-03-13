/*
Autor: Fabian Chacón
Módulo: multiplier_datapath

Descripción:
Datapath del multiplicador secuencial de 32 bits.

Contiene:
- registro multiplicand
- registro multiplier
- registro product
- ALU (sumador 32 bits)

La FSM controla cuándo sumar y cuándo desplazar.

Ejemplo de uso:

multiplier_datapath dp(
    .clk(clk),
    .reset(reset),
    .add(add),
    .shift(shift),
    .multiplicand(a),
    .multiplier(b),
    .product(result),
    .lsb(lsb)
);
*/

module multiplier_datapath(

    input clk,
    input reset,

    input add,
    input shift,

    input [31:0] multiplicand,
    input [31:0] multiplier,

    output [63:0] product,
    output lsb

);

wire [31:0] alu_sum;
wire carry;

reg [63:0] product_reg;
reg [31:0] multiplicand_reg;


// almacenar multiplicand
always @(posedge clk or posedge reset)
begin
    if(reset)
        multiplicand_reg <= 0;
    else
        multiplicand_reg <= multiplicand;
end


// registro producto
always @(posedge clk or posedge reset)
begin
    if(reset)
        product_reg <= {32'b0, multiplier};

    else if(add)
        product_reg[63:32] <= product_reg[63:32] + multiplicand_reg;

    else if(shift)
        product_reg <= product_reg >> 1;

end


assign product = product_reg;
assign lsb = product_reg[0];

endmodule