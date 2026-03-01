module FIFO_tb ();
    reg [15:0] din_a;
    reg wen_a;
    reg ren_b;
    reg clk_a;
    reg clk_b;
    reg rst;
    wire [15:0] dout_b;
    wire full;
    wire empty;

    FIFO dut (
        .din_a(din_a),
        .wen_a(wen_a),
        .ren_b(ren_b),
        .clk_a(clk_a),
        .clk_b(clk_b),
        .rst(rst),
        .dout_b(dout_b),
        .full(full),
        .empty(empty)
    );

    initial begin
        clk_a = 0;
        forever begin
            #1 clk_a = ~clk_a;
        end
    end


    initial begin
        clk_b = 0;
        forever begin
            #3 clk_b = ~clk_b;
        end
    end

    initial begin
        rst = 1;
        wen_a = 0;
        ren_b = 0;
        din_a = 0;

        @ (negedge clk_b);
        rst = 0; 

         repeat (10) begin
            @(negedge clk_a);
            din_a = $random;
            wen_a = 1;
        end
        @(negedge clk_a) wen_a = 0;

        @(negedge clk_b);

        repeat (10) begin
            @(negedge clk_b);
            ren_b = 1;
        end
        @(negedge clk_b);
        $stop;
    end
    
endmodule