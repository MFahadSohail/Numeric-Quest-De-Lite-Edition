module main(
  input clock,
  input [3:0] input_bus, //switch 1 to 4
  input KEY,
  input KEY2,
  output [3:0] LED,
  output reg [3:0] LED2,
  output reg [6:0] HEX0,
  output reg [6:0] HEX1,
  output reg [6:0] HEX2,
  output reg [6:0] HEX3,
  output reg [6:0] HEX4,
  output reg [6:0] HEX5
);
	


	 reg [4:0] count; 
	 wire [3:0] tens, ones;
	 tensANDones(count, tens, ones); 
	assign LED = counter;
	
  //Saved values from P1 and P2
  reg [6:0] HEX0_saved_player1;
  reg [6:0] HEX1_saved_player1;
  reg [6:0] HEX0_saved_player2;
  reg [6:0] HEX1_saved_player2;
  

//States for both keys
  reg [3:0] counter = 4'b0001;
  reg [3:0] counter2 = 4'b0001;
  reg reachesZeo = 0;
  reg displaywon =0;
  reg checkStating=0;
  reg high=0;
  reg low = 0; 
  reg [2:0] lifeline = 3'b111;
  reg [2:0] store_lifeLine = 3'b111;
  
	reg [3:0] x;
	reg [3:0] y;
	
	reg HOT = 0;
	reg COLD = 0;
  
  
// KEY[0] to go from state 1 to 4


always @(negedge KEY) begin
		if(!KEY)begin

				counter<= {counter[2:0], counter[3]}; //1'b0			
	
		end	  
end
  
  always @(negedge KEY or posedge clock) begin
  
		if(!KEY)begin
		  count = 5'd20;
		end
			else begin
			if(counter == 4'b0100) begin
				if(count > 0) begin
				// If none of the above conditions, decrement count by 1 for the 20 sec timer.
				count <= count - 1;
					if(count == 0) begin
				     count <= 5'd0;	
					  reachesZeo <= 1;
					end
				end
			end
		end
  end
  
  
// KEY[1] to go from state 1 to 4 to check the answer
always @(negedge KEY2) begin
if(lifeline >= 0 ) begin
		if(!KEY2)begin
			if (HEX0_saved_player2 == HEX0_saved_player1 && HEX1_saved_player2 == HEX1_saved_player1) begin
				displaywon <= 1;
				lifeline = lifeline -1;
			end
		end
		//======   Go UP and DOWN    =======================
		if(x > y)begin
			high <=1;
			low <=0;
			lifeline = lifeline -1;
		end
		else if(y > x)begin
			high <=0;
			low <=1;
			lifeline = lifeline -1;
		end
		//======   Go HOT and COLD    =======================
		if(x-y <= 3 || y-x <= 3)begin
			HOT <= 1;
		end
		 if(x-y > 3 && y-x > 3)begin
			COLD <= 1;
		end
				counter2 <= {counter2[2:0], counter2[3]}; //1'b0			
		end
end
  
  
    always @(*) begin

	 //========================================   Player 1 =================================================================
    //*****************************************   State 1 ******************************************************************* 
	 if(counter == 4'b0001)begin
  
			HEX2 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX4 = 7'b1111001; // Display 1
			HEX5 = 7'b0001100; // Display P
			 //This is to get a number 0 to 15 from the player 2
			
         case(input_bus)
           // Display 0
           4'b0000    :
              begin
                HEX0 = 7'b1000000; // Display 0 on seg_bus
                HEX1 = 7'b1111111; // Display 0 on HEX2
              end
           // Display 1
           4'b0001    :
              begin
                HEX0 = 7'b1111001; // Display 1 on seg_bus
                HEX1 = 7'b1111111; // Display 0 on HEX2
              end
           // Display 2
           4'b0010    :
              begin
                HEX0 = 7'b0100100; // Display 2 on seg_bus
                HEX1 = 7'b1111111; // Display 0 on HEX2
              end
           // Display 3
           4'b0011    :
              begin
                HEX0 = 7'b0110000; // Display 3 on seg_bus
                HEX1 = 7'b1111111; // Display 0 on HEX2
              end
           // Display 4
           4'b0100    :
              begin
                HEX0 = 7'b0011001; // Display 4 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 5
           4'b0101    :
              begin
                HEX0 = 7'b0010010; // Display 5 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 6
           4'b0110    :
              begin
                HEX0 = 7'b0000010; // Display 6 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 7
           4'b0111    :
              begin
                HEX0 = 7'b1111000; // Display 7 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 8
           4'b1000    :
              begin
                HEX0 = 7'b0000000; // Display 8 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 9
           4'b1001    :
              begin
                HEX0 = 7'b0010000; // Display 9 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 10
           4'b1010    :
              begin
                HEX0 = 7'b1000000; // Display 0 on seg_bus
                HEX1 = 7'b1111001; // Display 1 on HEX2
              end
           // Display 11
           4'b1011    :
              begin
                HEX0 = 7'b1111001;  // Display 1 on seg_bus
                HEX1 = 7'b1111001; // Display 1 on HEX2
              end
           // Display 12
           4'b1100    :
              begin
                HEX0 = 7'b0100100;  // Display 2 on seg_bus
                HEX1 = 7'b1111001; // Display 1 on HEX2
              end
           // Display 13
           4'b1101    :
              begin
                HEX0 = 7'b0110000;   // Display 13 on seg_bus
                HEX1 = 7'b1111001; // Display 1 on HEX2
              end
           // Display 14
           4'b1110    :
              begin
                HEX0 = 7'b0011001; // Display 4 on seg_bus
                HEX1 = 7'b1111001; // Display 1 HEX2
              end
           // Display 15
           4'b1111    :
              begin
                HEX0 = 7'b0010010; // Display 5 on seg_bus
                HEX1 = 7'b1111001; // Display 1 on HEX2
              end
         endcase
				
		
		
					if(counter == 4'b0001) begin
			// Store the values of HEX0 and HEX1 for player 1
			  HEX0_saved_player1 = HEX0;
			  HEX1_saved_player1 = HEX1;
			  x=input_bus;
			  end

	end
//*****************************************   State 2 *******************************************************************
  else if(counter == 4'b0010) begin
		
		     HEX0 <= 7'b1111111;//HEX0;
			  HEX1 <= 7'b0100001; //d
			  HEX2 <= 7'b0000110; //E
			  HEX3 <= 7'b1000001; //v
			  HEX4 <= 7'b0001000; //A
			  HEX5 <= 7'b0010010; //S
  end
		  
//========================================== PLAYER 2 ==========================================================================
//*****************************************   State 3 *******************************************************************
		
//State 3
else if(counter == 4'b0100 && !reachesZeo ) begin

 case (lifeline)
      3'b111: LED2 = 4'b1111;
      3'b110: LED2 = 4'b1110;
      3'b101: LED2 = 4'b1100;
      default: LED2 = 4'b1000;
    endcase
	
		HEX2 = 7'b1111111; 
      HEX3 = 7'b1111111;
	
			  case(tens)
            // Start a case statement based on the value of the "digit" input.
            4'd0: HEX5 = 7'b1000000; // If "digit" is 0, set "outputDisplay" to 1000000 in binary.
            4'd1: HEX5 = 7'b1111001; // If "digit" is 1, set "outputDisplay" to 1111001 in binary.
            4'd2: HEX5 = 7'b0100100; // If "digit" is 2, set "outputDisplay" to 0100100 in binary.
            4'd3: HEX5 = 7'b0110000; // If "digit" is 3, set "outputDisplay" to 0110000 in binary.
            4'd4: HEX5 = 7'b0011001; // If "digit" is 4, set "outputDisplay" to 0011001 in binary.
            4'd5: HEX5 = 7'b0010010; // If "digit" is 5, set "outputDisplay" to 0010010 in binary.
            4'd6: HEX5 = 7'b0000010; // If "digit" is 6, set "outputDisplay" to 0000010 in binary.
            4'd7: HEX5 = 7'b1111000; // If "digit" is 7, set "outputDisplay" to 1111000 in binary.
            4'd8: HEX5 = 7'b0000000; // If "digit" is 8, set "outputDisplay" to 0000000 in binary.
            4'd9: HEX5 = 7'b0010000; // If "digit" is 9, set "outputDisplay" to 0010000 in binary.
				default: HEX5 = 7'b1111111;
        endcase
		  
		    case(ones)
            // Start a case statement based on the value of the "digit" input.
            4'd0: HEX4 = 7'b1000000; // If "digit" is 0, set "outputDisplay" to 1000000 in binary.
            4'd1: HEX4 = 7'b1111001; // If "digit" is 1, set "outputDisplay" to 1111001 in binary.
            4'd2: HEX4 = 7'b0100100; // If "digit" is 2, set "outputDisplay" to 0100100 in binary.
            4'd3: HEX4 = 7'b0110000; // If "digit" is 3, set "outputDisplay" to 0110000 in binary.
            4'd4: HEX4 = 7'b0011001; // If "digit" is 4, set "outputDisplay" to 0011001 in binary.
            4'd5: HEX4 = 7'b0010010; // If "digit" is 5, set "outputDisplay" to 0010010 in binary.
            4'd6: HEX4 = 7'b0000010; // If "digit" is 6, set "outputDisplay" to 0000010 in binary.
            4'd7: HEX4 = 7'b1111000; // If "digit" is 7, set "outputDisplay" to 1111000 in binary.
            4'd8: HEX4 = 7'b0000000; // If "digit" is 8, set "outputDisplay" to 0000000 in binary.
            4'd9: HEX4 = 7'b0010000; // If "digit" is 9, set "outputDisplay" to 0010000 in binary.
				default: HEX5 = 7'b1111111;
				
        endcase
		  
		  //This is to get a number 0 to 15 from the player 2
			case(input_bus)			
           // Display 0
           4'b0000    :
              begin
                HEX0 = 7'b1000000; // Display 0 on seg_bus
                HEX1 = 7'b1111111; // Display 0 on HEX2
              end
           // Display 1
           4'b0001    :
              begin
                HEX0 = 7'b1111001; // Display 1 on seg_bus
                HEX1 = 7'b1111111; // Display 0 on HEX2
              end
           // Display 2
           4'b0010    :
              begin
                HEX0 = 7'b0100100; // Display 2 on seg_bus
                HEX1 = 7'b1111111; // Display 0 on HEX2
              end
           // Display 3
           4'b0011    :
              begin
                HEX0 = 7'b0110000; // Display 3 on seg_bus
                HEX1 = 7'b1111111; // Display 0 on HEX2
              end
           // Display 4
           4'b0100    :
              begin
                HEX0 = 7'b0011001; // Display 4 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 5
           4'b0101    :
              begin
                HEX0 = 7'b0010010; // Display 5 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 6
           4'b0110    :
              begin
                HEX0 = 7'b0000010; // Display 6 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 7
           4'b0111    :
              begin
                HEX0 = 7'b1111000; // Display 7 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 8
           4'b1000    :
              begin
                HEX0 = 7'b0000000; // Display 8 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 9
           4'b1001    :
              begin
                HEX0 = 7'b0010000; // Display 9 on seg_bus
                HEX1 = 7'b1111111; // Display off on HEX2
              end
           // Display 10
           4'b1010    :
              begin
                HEX0 = 7'b1000000; // Display 0 on seg_bus
                HEX1 = 7'b1111001; // Display 1 on HEX2
              end
           // Display 11
           4'b1011    :
              begin
                HEX0 = 7'b1111001;  // Display 1 on seg_bus
                HEX1 = 7'b1111001; // Display 1 on HEX2
              end
           // Display 12
           4'b1100    :
              begin
                HEX0 = 7'b0100100;  // Display 2 on seg_bus
                HEX1 = 7'b1111001; // Display 1 on HEX2
              end
           // Display 13
           4'b1101    :
              begin
                HEX0 = 7'b0110000;   // Display 13 on seg_bus
                HEX1 = 7'b1111001; // Display 1 on HEX2
              end
           // Display 14
           4'b1110    :
              begin
                HEX0 = 7'b0011001; // Display 4 on seg_bus
                HEX1 = 7'b1111001; // Display 1 HEX2
              end
           // Display 15
           4'b1111    :
              begin
                HEX0 = 7'b0010010; // Display 5 on seg_bus
                HEX1 = 7'b1111001; // Display 1 on HEX2
              end
         endcase
	        HEX0_saved_player2 = HEX0;
           HEX1_saved_player2 = HEX1;
			  y = input_bus;
			  
	if(high == 0 && low == 1)begin  
				 HEX3 =  7'b0100001;   //GO UP   Display "U"
				   
	end
	if (high == 1 && low == 0)begin
				 HEX3 =  7'b1000001;    //GO DOWN    Display "d"
				
	end
//	
	if(HOT == 1 && COLD == 0)begin
		 HEX2 =  7'b0001001; //Dsiaply H
	end


	else if(COLD == 1 && HOT==0)begin
		 HEX2 =  7'b1000110;  //Display C
	end 

	 if(displaywon == 1)begin
//Display U WOn
			  HEX0 <= 7'b0101011;// Display n
			  HEX1 <= 7'b1000000;// Display O
			  HEX2 <= 7'b1100001;//Display half W
			  HEX3 <= 7'b1000011;//Display half W 
			  HEX4 <= 7'b1111111;
			  HEX5 <= 7'b1000001;//Display U	
	end


	else begin
			if (HEX5 == 7'b1000000 && HEX4 == 7'b1000000 || counter2 == 4'b1000) begin
//Display U LOSE
				HEX5 <= 7'b1000001;  // Display U
				HEX4 <= 7'b1111111;
				HEX3 <= 7'b1000111;  // Display L
				HEX2 <= 7'b1000000;  // Display O
				HEX1 <= 7'b0010010;  // Display S
				HEX0 <= 7'b0000110;  // Display E
			
			end
	end
			
	
		 
		   
end
//*****************************************************   State 4 *******************************************************************
//===================================================== THANKS MESSAGE ==============================================================
else if(counter == 4'b1000) begin
// display tHAnkS
			  HEX5 <= 7'b0000111; //t
			  HEX4 <= 7'b0001001; //H
			  HEX3 <= 7'b0001000; //A
			  HEX2 <= 7'b0101011; //n
			  HEX1 <= 7'b0001111; //k
			  HEX0 <= 7'b0010010; //S

end



end

endmodule


module tensANDones(number, ten, one);

	input [4:0] number;
	output [3:0] ten, one;
	assign ten = number / 10;
	assign one = number % 10;
	
endmodule


module ClockDivider(cin, cout);
 input cin;
 output reg cout;
 
 reg[32:0] count; 
 
 parameter D = 32'd25000000;
 
 always @(posedge cin)
 begin
	count <= count + 32'd1;
		if (count >= (D-1)) begin
			cout <= ~cout;
			count <= 32'd0;
		end
 end
 
endmodule


