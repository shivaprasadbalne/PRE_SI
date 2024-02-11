/*module CONSUMER #(parameter DATA_WIDTH = 32)(
	input logic r_clk,rrst,rd_req,
	input logic [DATA_WIDTH-1:0]mem_data_out,
	input logic f_empty,
	output logic r_en,
	output logic [DATA_WIDTH-1:0]data_out
);

	logic [1:0] delay_cnt;
    always_ff @(posedge r_clk or negedge rrst) begin
        if (!rrst) delay_cnt <= 0;
        else begin 
			if(rd_req && delay_cnt < 2) begin
				delay_cnt <= delay_cnt + 1;
			end
		end	
    end
	
	always_ff @(posedge r_clk or negedge rrst) begin
		if(!rrst) begin
			r_en <= 0;
			data_out <= 'x;
		end
		else begin
			if(rd_req && f_empty && delay_cnt == 2) begin
				r_en <= 1;
				data_out <= mem_data_out; 
			end	
		end
	end
	
	
endmodule
*/

module CONSUMER #(parameter DATA_WIDTH = 32)(
    input logic r_clk, rrst, rd_req,
    input logic [DATA_WIDTH-1:0] mem_data_out,
    //input logic f_empty,
    output logic r_en,
    output logic [DATA_WIDTH-1:0] data_out
);

/*
    logic [1:0] delay_cnt;

    always_ff @(posedge r_clk or negedge rrst) begin
        if (!rrst) delay_cnt <= 0;
        else begin 
            if (rd_req) begin
                // Increment delay_cnt only on the rising edge of rd_req
                if (delay_cnt < 2) 
                    delay_cnt <= delay_cnt + 1;
            end
            else begin
                // Reset delay_cnt when there is no read request or the memory is not empty
                delay_cnt <= 0;
            end
        end
    end
 */   
	
	always_ff@(posedge r_clk or negedge rrst) begin
		if(!rrst) begin
			data_out <= 'z;
			r_en <= '0;
		end
		else
			if(rd_req)	begin
				r_en <= 1;
				data_out <= mem_data_out;
			end
			else begin
				r_en<= 0;
				data_out <= 'z;
			end
			
	end
/*
    always_ff @(posedge r_clk or negedge rrst) begin
        if (!rrst) begin
            r_en <= 0;
            data_out <= 'z;
        end
        else begin
            if (rd_req && f_empty && delay_cnt == 2) begin
                r_en <= 1;
                data_out <= mem_data_out; 
            end    
        end
    end  */
endmodule
