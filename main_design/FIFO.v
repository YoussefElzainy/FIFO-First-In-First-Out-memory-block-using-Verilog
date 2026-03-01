module FIFO #(
    parameter fifo_width = 16,
    parameter fifo_depth = 512
) (
    input [fifo_width - 1 : 0] din_a, // data input
    input wen_a, // write enable
    input ren_b, // read enable
    input clk_a, // clk signal for port a
    input clk_b, // clk signal for port b
    input rst,
    output reg [fifo_width - 1 : 0] dout_b, // data output
    output reg full, // full flag
    output reg empty// empty flag
);
    reg [fifo_width - 1 : 0] fifo_mem [ 0: fifo_depth - 1];
    reg [8:0] rd_ptr, wr_ptr;
    
    always @(posedge clk_a or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            full <= 0;
        end
         else if (wen_a && !full) begin
            fifo_mem[wr_ptr] <= din_a;
            wr_ptr <= wr_ptr + 1;
            empty <= 0;

            if (wr_ptr + 1 == fifo_depth)
                full <= 1;
             
        end
        end
    

    always @(posedge clk_b or posedge rst) begin
        if (rst) begin
           rd_ptr <= 0;
           dout_b <= 0;
           empty <= 1;
        end
         else if (ren_b && !empty) begin
            dout_b <= fifo_mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            full <= 0; 
            if (rd_ptr + 1 == wr_ptr)
                empty <= 1;
        end
    end
endmodule