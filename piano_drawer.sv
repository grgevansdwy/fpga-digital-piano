module piano_drawer(
    output logic [7:0] r, g, b,
    input logic c_note, d_note, e_note, f_note, g_note, a_note, b_note,
    input logic [9:0] x,
    input logic [8:0] y
);
	
	always_comb begin
			 // Default white background
			    r = 8'd255;
             g = 8'd255;
             b = 8'd255;


			 //Horizontal Line
			 if (((y >= 50 && y<= 52) || (y >= 400 && y<= 402)) && (x >= 56 && x <= 581)) begin
				  r = 8'h0;
				  g = 8'h0;
				  b = 8'h0;
			 end
			 
			 //Vertical Line
			if (((x >= 55 && x <= 57) || (x >= 130 && x <= 132) || 
                 (x >= 205 && x <= 207) || (x >= 280 && x <= 282) || 
                 (x >= 355 && x <= 357) || (x >= 430 && x <= 432) || 
                 (x >= 505 && x <= 507) || (x >= 580 && x <= 582)) &&
                (y >= 50 && y <= 400)) begin
                r = 8'd0;
                g = 8'd0;
                b = 8'd0;
          end 
			// Black Notes
			if (((x >= 106 && x <= 156) || (x >= 181 && x <= 231) || 
                 (x >= 331 && x <= 381) || (x >= 406 && x <= 456) || 
                 (x >= 481 && x <= 531) ) &&
                (y >= 50 && y <= 250)) begin
                r = 8'd0;
                g = 8'd0;
                b = 8'd0;
          end 
			
			// C Note Pressed
			if (c_note &&(((x >= 58 && x <= 105) && (y >= 53 && y <= 250)) || 
               ((x >= 58 && x <= 129) && (y >= 251 && y <= 400)))) begin
                r = 8'd255;
                g = 8'd255;
                b = 8'd0;
          end
			 
			// D Note Pressed
			if (d_note &&(((x >= 157 && x <= 180) && (y >= 53 && y <= 250)) || 
               ((x >= 133 && x <= 204) && (y >= 251 && y <= 400)))) begin
                r = 8'd255;
                g = 8'd255;
                b = 8'd0;
         end
			
			// E Note Pressed
			if (e_note &&(((x >= 231 && x <= 279) && (y >= 53 && y <= 250)) || 
               ((x >= 208 && x <= 279) && (y >= 251 && y <= 400)))) begin
                r = 8'd255;
                g = 8'd255;
                b = 8'd0;
         end
			
			// F Note Pressed
			if (f_note &&(((x >= 283 && x <= 330) && (y >= 53 && y <= 250)) || 
               ((x >= 283 && x <= 354) && (y >= 251 && y <= 400)))) begin
                r = 8'd255;
                g = 8'd255;
                b = 8'd0;
         end
 
			// G Note Pressed
			if (g_note &&(((x >= 382 && x <= 405) && (y >= 53 && y <= 250)) || 
               ((x >= 358 && x <= 429) && (y >= 251 && y <= 400)))) begin
                r = 8'd255;
                g = 8'd255;
                b = 8'd0;
         end
			
			// A Note Pressed
			if (a_note &&(((x >= 457 && x <= 480) && (y >= 53 && y <= 250)) || 
               ((x >= 433 && x <= 504) && (y >= 251 && y <= 400)))) begin
                r = 8'd255;
                g = 8'd255;
                b = 8'd0;
         end
			
			// B Note Pressed
			if (b_note &&(((x >= 532 && x <= 579) && (y >= 53 && y <= 250)) || 
               ((x >= 508 && x <= 579) && (y >= 251 && y <= 400)))) begin
                r = 8'd255;
                g = 8'd255;
                b = 8'd0;
         end

		end

endmodule