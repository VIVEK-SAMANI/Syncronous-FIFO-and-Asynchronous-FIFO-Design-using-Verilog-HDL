`timescale 1ns / 1ps

module Async_FIFO_Design(
    input Clr_bar, Write_clk, Read_clk, 
    input [7:0] data_in,
    output reg Empty, Full, 
    output reg [7:0] data_out 
    );
        
parameter fifo_depth = 4; // No. of locations 
parameter data_width = 8; // Width of fifo location ( In bits )

integer loc = 0;

reg [1:0] Read_ptr = 2'b0;
reg [1:0] Write_ptr = 2'b0;

reg [data_width-1:0] FIFO [fifo_depth-1:0];

// Block for handling "Clr" logic
always@(*)    
begin
    if(Clr_bar == 0)
    begin
        for(loc = 0 ; loc < fifo_depth ; loc = loc + 1)
        begin
            FIFO[loc] = 8'b0;
        end
        Read_ptr = 2'b00;
        Write_ptr = 2'b00;
        Full = 0;
        Empty = 1;
        data_out = 8'b0;
    end
end

// Block for handling Full & Empty Flag logic
always@(*)
begin
    Empty = (Write_ptr == Read_ptr == 0)? 1 : 0 ;
    Full  = (Write_ptr == 0 && Read_ptr == 0 && FIFO[3]!=8'b0)? 1: 0;
end 

// Block for handling "Writing" Operation to the FIFO
always@(negedge Write_clk)
begin
    if(Clr_bar == 0)
    begin
        for(loc = 0 ; loc < fifo_depth ; loc = loc + 1)
        begin
            FIFO[loc] = 8'b0;
        end
        Read_ptr = 2'b00;
        Write_ptr = 2'b00;
        data_out = 8'b0;
    end
    
    else if(Clr_bar == 1)
    begin
        // Check for empty location then perform Write operation
        FIFO[Write_ptr] <= (FIFO[Write_ptr] == 8'b0) ? data_in : FIFO[Write_ptr] ; 
        //Inc the Write pointer
        Write_ptr <= (FIFO[Write_ptr + 1] == 8'b0) ? Write_ptr + 1 : 2'b00 ;   
    end  
end

// Block for handling "Reading" Operation from the FIFO
always@(negedge Read_clk)
begin
    if(Clr_bar == 0)
    begin
        for(loc = 0 ; loc < fifo_depth ; loc = loc + 1)
        begin
            FIFO[loc] = 8'b0;
        end
        Read_ptr = 2'b00;
        Write_ptr = 2'b00;
        data_out = 8'b0;
    end
    
    else if(Clr_bar == 1)
    begin
        // Read & Clear location
        data_out <= FIFO[Read_ptr];
        FIFO[Read_ptr] <= 8'b0;
        // Inc the Read pointer if the next location has non zero value
        Read_ptr <= (FIFO[Read_ptr + 1] != 8'b0) ? Read_ptr + 1 : 2'b00 ;  
    end    
end

endmodule
