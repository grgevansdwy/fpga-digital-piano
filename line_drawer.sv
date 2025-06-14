/* Given two points on the screen this module draws a line between
 * those two points by coloring necessary pixels
 *
 * Inputs:
 *   clk    - should be connected to a 50 MHz clock
 *   reset  - resets the module and starts over the drawing process
 *	 x0 	- x coordinate of the first end point
 *   y0 	- y coordinate of the first end point
 *   x1 	- x coordinate of the second end point
 *   y1 	- y coordinate of the second end point
 *
 * Outputs:
 *   x 		- x coordinate of the pixel to color
 *   y 		- y coordinate of the pixel to color
 *   done	- flag that line has finished drawing
 *
 */
module line_drawer(clk, reset, x0, y0, x1, y1, x, y, done);
	input logic clk, reset;
	input logic [10:0]	x0, y0, x1, y1;
	output logic done;
	output logic [10:0]	x, y;
	
	// additional logic
	logic signed [11:0] error; // detect whether one of the variable should delay
	logic signed [11:0] deltaX, deltaY; // store the difference between points
	logic [10:0] x_out, y_out, x1_latch, y1_latch; // since input are unsigned, output won't be negative
	logic y_step, is_steep; // y_step is used to choose between negative / positive slope, is_steep is to choose whether the slope is more than 1
	logic testing;
	
	//assuming x1 is larger than x0, and assuming the slope <=1, assuming y1 is larger than y0, assuming input held long enough
	
	enum {s_pre_idle, s_idle, s_buffer, s_loop_buffer, s_idle_buffer, s_loop, s_done} ps, ns; // define state
	// control
	always_comb begin
		case(ps)
			s_pre_idle : ns = s_idle;
			s_idle : ns = s_buffer;
			s_buffer : ns = s_idle_buffer;
			s_idle_buffer : ns = s_loop_buffer;
			s_loop_buffer : ns = s_loop;
			s_loop : begin
							if(x_out >= x1_latch)
								ns = s_done;
							else
								ns = s_loop_buffer;
						end
			s_done : ns = s_pre_idle;
			default : ns = s_pre_idle;
		endcase
	end
	
	// datapath
	always_ff @(posedge clk) begin
		if(reset) begin
			ps<=s_pre_idle;
		end else begin
			ps <= ns;
			case(ps)
				s_pre_idle : begin
									deltaX <= x0 < x1 ? x1-x0 : x0-x1;
									deltaY <= y0 < y1 ? y1-y0 : y0-y1;
									testing <= 0;
									done <=0;
									is_steep<=0;
								 end
				s_idle : begin
								if(deltaY > deltaX) begin // case where slope > 1
									y_out <= x0;
									x_out <= y0;
									x1_latch <= y1;
									y1_latch <= x1;
									deltaX <= deltaY;
									deltaY <= deltaX;
									is_steep <= 1'b1;
								end else begin
									y_out <= y0;
									x_out <= x0;
									x1_latch <= x1;
									y1_latch <= y1;
									deltaX <= deltaX;
									deltaY <= deltaY;
								end
							end
				s_idle_buffer : begin
										error <= -(deltaX>>>1);
										if(x_out > x1_latch) begin // case x1 is smaller (swapped)
											y_out <= y1_latch;
											x_out <= x1_latch;
											x1_latch <= x_out;
											y1_latch <= y_out;
											deltaX <= deltaX;
											deltaY <= deltaY;
											y_step <= y1_latch < y_out ? 1'b1 :1'b0; 
											testing <= 1'b1;
										end else begin // case x0 is smaller (no swap)
											y_out <= y_out;
											x_out <= x_out;
											x1_latch <= x1_latch;
											y1_latch <= y1_latch;
											deltaX <= deltaX;
											deltaY <= deltaY;
											y_step <= y_out < y1_latch ? 1'b1 : 1'b0;
										end
									 end
				
				s_loop_buffer : begin
										if (is_steep) begin
										   y <= x_out;
										   x <= y_out;
										end else begin
											x <= x_out;
											y <= y_out;
										end
										 error <= error + deltaY;
									 end
				s_loop : begin
								x_out <= x_out+1;
								if(error >= 0) begin
									y_out <= y_step? y_out+1 : y_out-1; // if y_step true, positive slope, else negative slope
									error <= error - deltaX;
								end
							end
				s_done : done <= 1;
			endcase
		end
	end  // always_ff
	
endmodule  // line_drawer

module line_drawer_testbench;
	//Inputs
   logic clk, reset;
	logic [10:0]	x0, y0, x1, y1;
	// Outputs
	logic done;
	logic [10:0]	x, y;

    // Instantiate the input_fsm module
    line_drawer dut (
        .clk(clk),
        .reset(reset),
		  .x0,
		  .x1,
		  .y0,
		  .y1,
        .x,
        .y,
		  .done(done)
    );

      // Set up a simulated clock.
    parameter CLOCK_PERIOD=100;
    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
    end

    // Test procedure
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
		  
		  x0 = 11'd2;
		  y0 = 11'd6;
		  x1 = 11'd8;
		  y1 = 11'd9;

        // Apply reset and check initial state
        @(posedge clk);
        reset = 0;
		  @(posedge clk);
		  @(posedge clk);
		  //done =0, x = undefined, y = undefined

		  // Test case 1 : (2,6) and (8,9), not steep, x1>x0, y1>y0 (right up)
		  
		  
		  // cycle 1 --> 2,6
		  // cycle 1 --> 3,7
		  // cycle 1 --> 4,7
		  // cycle 1 --> 5,8
		  // cycle 1 --> 6,8
		  // cycle 1 --> 7,9
		  // cycle 1 --> 8,9
		  repeat (25) @(posedge clk);

		  
		  // Test case 2: (5,6) and (1,4), not steep, x1<x0, y1<y0 (left down)

		  // start from the back
		  // cycle 1 --> 1,4
		  // cycle 1 --> 2,5
		  // cycle 1 --> 3,5
		  // cycle 1 --> 4,6
		  // cycle 1 --> 5,6
		  x0 = 11'd5;
		  y0 = 11'd6;
		  x1 = 11'd1;
		  y1 = 11'd4;
		  repeat (25) @(posedge clk);
		  
		  // Test case 3 : (1,9) and (5,7), not steep, x1>x0, y1<y0 (right down)
		  // y_step should be 0 (substration)
		  // cycle 1 --> 1,9
		  // cycle 2 --> 2,8
		  // cycle 3 --> 3,8
		  // cycle 4 --> 4,7
		  // cycle 5 --> 5,7
		  x0 = 11'd1;
		  y0 = 11'd9;
		  x1 = 11'd5;
		  y1 = 11'd7;
		  repeat (25) @(posedge clk);
		  
		  // Test case 4 : (9,7) and (1,9), not steep, x1<x0, y1>y0 (left up)
		  // y_step should be 0 (substraction) and start from the back
		  // cycle 1 --> 1,9
		  // cycle 2 --> 2,9
		  // cycle 3 --> 3,8
		  // cycle 4 --> 4,8
		  // cycle 5 --> 5,8
		  // cycle 4 --> 6,8
		  // cycle 5 --> 7,7
		  // cycle 4 --> 8,7
		  // cycle 5 --> 9,7
		  x0 = 11'd9;
		  y0 = 11'd7;
		  x1 = 11'd1;
		  y1 = 11'd9;
		  repeat (25) @(posedge clk);
		  
		  
		  
		  // TEST FOR STEEP
		  // Test case 5 : (6,2) and (9,8), not steep, x1>x0, y1>y0 (right up)
		  // cycle 1 --> 6,2
		  // cycle 1 --> 7,3
		  // cycle 1 --> 7,4
		  // cycle 1 --> 8,5
		  // cycle 1 --> 8,6
		  // cycle 1 --> 9,7
		  // cycle 1 --> 9,8
		  x0 = 11'd6;
		  y0 = 11'd2;
		  x1 = 11'd9;
		  y1 = 11'd8;
		  repeat (25) @(posedge clk);
		  
		  // Test case 6: (6,5) and (4,1), steep, x1<x0, y1<y0 (left down)
		  // cycle 1 --> 4,1
		  // cycle 1 --> 5,2
		  // cycle 1 --> 5,3
		  // cycle 1 --> 6,4
		  // cycle 1 --> 6,5
		  x0 = 11'd6;
		  y0 = 11'd5;
		  x1 = 11'd4;
		  y1 = 11'd1;
		  repeat (30) @(posedge clk);
		  
		   
		  // Test case 3 : (9,1) and (7,5), steep, x1<x0, y1>y0 (left up)
		  // cycle 1 --> 9,1
		  // cycle 2 --> 8,2
		  // cycle 3 --> 8,3
		  // cycle 4 --> 7,4
		  // cycle 5 --> 7,5
		  x0 = 11'd9;
		  y0 = 11'd1;
		  x1 = 11'd7;
		  y1 = 11'd5;
		  repeat (25) @(posedge clk);
		  
		  // Test case 4 : (7,9) and (9,1), steep, x1>x0, y1<y0 (right down)
		  // cycle 1 --> 9,1
		  // cycle 2 --> 9,2
		  // cycle 3 --> 8,3
		  // cycle 4 --> 8,4
		  // cycle 5 --> 8,5
		  // cycle 4 --> 8,6
		  // cycle 5 --> 7,7
		  // cycle 4 --> 7,8
		  // cycle 5 --> 7,9
		  x0 = 11'd7;
		  y0 = 11'd9;
		  x1 = 11'd9;
		  y1 = 11'd1;
		  repeat (35) @(posedge clk);
		  $stop;
    end
endmodule