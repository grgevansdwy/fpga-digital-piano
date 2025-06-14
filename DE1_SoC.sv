/* Top level module of the FPGA that takes the onboard resources 
 * as input and outputs the lines drawn from the VGA port using video_driver.
 */
module DE1_SoC (
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
    KEY, LEDR, SW, CLOCK_50,
    VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);

    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    output logic [9:0] LEDR;
    input logic [3:0] KEY;
    input logic [9:0] SW;
    input CLOCK_50;
    output [7:0] VGA_R, VGA_G, VGA_B;
    output VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS;

    // Control signals
    logic [9:0] x;
    logic [8:0] y;
    logic [7:0] r, g, b;
    logic reset, c_note, d_note, e_note, f_note, g_note, a_note, b_note;

    assign HEX0 = '1;
    assign HEX1 = '1;
    assign HEX2 = '1;
    assign HEX3 = '1;
    assign HEX4 = '1;
    assign HEX5 = '1;
    assign LEDR = SW;
    assign c_note = SW[1];
	 assign d_note = SW[2];
	 assign e_note = SW[3];
	 assign f_note = SW[4];
	 assign g_note = SW[5];
	 assign a_note = SW[6];
	 assign b_note = SW[7];
	 assign reset = SW[0];

    // Instantiate video_driver
    video_driver #(.WIDTH(640), .HEIGHT(480)) driver_inst (
        .CLOCK_50(CLOCK_50),
        .reset(reset),
        .x(x), .y(y),
        .r(r), .g(g), .b(b),
        .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B),
        .VGA_BLANK_N(VGA_BLANK_N), .VGA_CLK(VGA_CLK),
        .VGA_HS(VGA_HS), .VGA_SYNC_N(VGA_SYNC_N), .VGA_VS(VGA_VS)
    );
	 
	 piano_drawer(.r, .g, .b, .c_note, .d_note, .e_note, .f_note, .g_note, .a_note, .b_note, .x, .y);

endmodule
