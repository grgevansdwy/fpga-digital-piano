module piano_game(reset, note_sw, start, hex0, hex1);
	input logic [2:0] note_sw;
	input logic start, reset;
	output logic [7:0] hex1, hex0;
	
	
	//additional logic
	logic i, i_max;
	
	//state
	enum {s_idle, s_note, s_zero, s_lose, s_win} ps, ns;
	
	//control
	always_comb begin
		case(ps)
			s_idle : begin
							if(start)
								ns = s_note;
							else
								ns = s_idle;
						end
			s_note : begin
							if(note_sw == 3'b000)
								ns = s_note;
							else begin
								if(note_sw == rom[i]) 
									ns = s_zero;
								else
									ns = s_lose;
							end
						end
			s_zero : begin
							if(note_sw != 3'b000)
								ns = s_zero;
							else if(i < i_max)
								ns = s_note;
							else
								ns = s_win;
						end
			s_win : ns = s_win;
			s_lose : ns = s_lose;
			default : ns= idle;
		endcase
	end
	always_ff @(posedge clk) begin
		if(reset) begin
			ps<=s_idle;
		end else begin
			ps <= ns;
			case(ps)
				s_idle : begin
								if(start) begin
									i_max <= 28;
									i <= 0;
									hex0 <= 3'b000;
									hex0 <= 3'b000;
								end
							end
				s_note : hex0 <= note_sw;
				s_zero : begin
								if(i < i_max)
									i = i+1;
							end
				s_win : hex1 <= 7'b0111111;
				s_lose : hex1 <= 7'b1001111
			endcase
		end
	end
	
endmodule