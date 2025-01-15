`define N_NP_ADDR 12'h810
`define N_NP_DATA 32'h000f_0f00

`define HD_S_ADDR 12'h814
`define HD_S_DATA 32'h0001_0300
//////////////////////////////////////////////////////////////////////////////////
//     FileName: dac_204b_cfg_module.v                                                            
//     SvnProperties:                                                             
//         $URL: http://svn.hq.org/svn/PR1104/DEVELOP/03_FPGAPrj_for_VIVADO/HQGF_4_DRFMJ1G/V1/branches/interp12_960MSPS/src/inf/dac_cfg/dac_204b_cfg_module.v                                                                 
//         $Author: yujiahe $                                                     
//         $Revision:  16946                                                           
//         $Date: 2020-03-01                                                      
//                                                                                
//////////////////////////////////////////////////////////////////////////////////
module dac_204b_cfg_module(
	clk,
	rst,
	axi_awaddr,
	axi_awvalid,
	axi_awready,
	axi_wdata,
	axi_wstrb,
	axi_wvalid,
	axi_wready,
	axi_bresp,
	axi_bvalid,
	axi_bready,
	axi_araddr,
	axi_arvalid,
	axi_arready,
	axi_rdata,
	axi_rresp,
	axi_rvalid,
	axi_rready,
	cnt_timing
);

input                    clk                        ;
input                    rst                        ;

output reg     [15:0]           cnt_timing                 ; 

(* MARK_DEBUG = "true" *)
output  [11:0]           axi_awaddr                 ;
(* MARK_DEBUG = "true" *)
output                   axi_awvalid                ;
(* MARK_DEBUG = "true" *)
input                    axi_awready                ;
(* MARK_DEBUG = "true" *)
output  [31:0]           axi_wdata                  ;
(* MARK_DEBUG = "true" *)
output  [3:0]            axi_wstrb                  ;
(* MARK_DEBUG = "true" *)
output                   axi_wvalid                 ;
(* MARK_DEBUG = "true" *)
input                    axi_wready                 ;
(* MARK_DEBUG = "true" *)
input   [1:0]            axi_bresp                  ;
(* MARK_DEBUG = "true" *)
input                    axi_bvalid                 ;
(* MARK_DEBUG = "true" *)
output                   axi_bready                 ;
(* MARK_DEBUG = "true" *)
output  [11:0]           axi_araddr                 ;
(* MARK_DEBUG = "true" *)
output                   axi_arvalid                ;
(* MARK_DEBUG = "true" *)
input                    axi_arready                ;
(* MARK_DEBUG = "true" *)
input   [31:0]           axi_rdata                  ;
(* MARK_DEBUG = "true" *)
input   [1:0]            axi_rresp                  ;
(* MARK_DEBUG = "true" *)
input                    axi_rvalid                 ;
(* MARK_DEBUG = "true" *)
output                   axi_rready                 ;

reg     [11:0]           axi_awaddr                 ;
reg                      axi_awvalid                ;
reg     [31:0]           axi_wdata                  ;
reg     [3:0]            axi_wstrb                  ;
reg                      axi_wvalid                 ;
reg                      axi_bready                 ;
reg     [11:0]           axi_araddr                 ;
reg                      axi_arvalid                ;
reg                      axi_rready                 ;

reg                      err                        ;
(* MARK_DEBUG = "true" *)
reg     [31:0]           data_read                  ;
(* MARK_DEBUG = "true" *)
reg     [7:0]            state                      ;

always@(posedge clk or posedge rst)
begin
	if(rst)
	  err <= 0;
	else
	  err <= (axi_bvalid&&(|axi_bresp)) || (|axi_rresp);
end

parameter         ST_IDLE                    = 8'h00,

                  ST_WRITE00_GIVE_ADDR       = 8'h01,
                  ST_WRITE00_GIVE_DATA       = 8'h02,
                  ST_WRITE00_WAIT_RESP       = 8'h03,
                  ST_READE00_GIVE_ADDR       = 8'h04,
                  ST_READE00_GET_DATA        = 8'h05,
                  ST_READE00_GAP             = 8'h06,
                  
                  ST_WRITE01_GIVE_ADDR       = 8'h07,
                  ST_WRITE01_GIVE_DATA       = 8'h08,
                  ST_WRITE01_WAIT_RESP       = 8'h09,
                  ST_READE01_GIVE_ADDR       = 8'h0a,
                  ST_READE01_GET_DATA        = 8'h0b,
                  ST_READE01_GAP             = 8'h0c;
                         
always@(posedge clk or posedge rst)
begin
	if(rst)
	  begin
	  	axi_awaddr   <= 0;
      axi_awvalid  <= 0;
      axi_wdata    <= 0;
      axi_wstrb    <= 0;
      axi_wvalid   <= 0;
      axi_bready   <= 0;
      axi_araddr   <= 0;
      axi_arvalid  <= 0;
      axi_rready   <= 0;
      cnt_timing   <= 0;
      data_read    <= 0;
      //----------------//
      state <= ST_IDLE;
    end
  else
    begin
    	case(state[7:0])
    	ST_IDLE:
    	  begin
    	  	state <= ST_WRITE00_GIVE_ADDR;
    	  end
    	ST_WRITE00_GIVE_ADDR:
    	  begin
    	  	if(axi_awready&&axi_awvalid)
    	  	  begin
    	  	  	axi_awaddr <= `N_NP_ADDR;
    	  	  	axi_awvalid <= 1'b0;
    	  	  	//-----------------//
    	  	  	state <= ST_WRITE00_GIVE_DATA;
    	  	  end
    	  	else
    	  	  begin
    	  	  	axi_awaddr <= `N_NP_ADDR;
    	  	  	axi_awvalid <= 1'b1;
    	  	  end
    	  end
    	ST_WRITE00_GIVE_DATA:
    	  begin
    	  	if(axi_wready&&axi_wvalid)
    	  	  begin
    	  	    axi_wdata <= `N_NP_DATA;
    	  	    axi_wstrb <= 4'hf;
    	  	    axi_wvalid <= 0;
    	  	    //----------------//
    	  	    state <= ST_WRITE00_WAIT_RESP;
    	  	  end
    	  	else
    	  	  begin
    	  	  	axi_wdata <= `N_NP_DATA;
    	  	    axi_wstrb <= 4'hf;
    	  	    axi_wvalid <= 1;
    	  	    axi_bready <= 1;
    	  	  end
    	  end
    	ST_WRITE00_WAIT_RESP:
    	  begin
    	  	if(axi_bready&&axi_bvalid)
    	  	  state <= ST_READE00_GIVE_ADDR;
    	  end
    	ST_READE00_GIVE_ADDR:
    	  begin
    	  	if(axi_arvalid&&axi_arready)
    	  	  begin
    	  	  	axi_arvalid <= 0;
    	  	  	axi_araddr <= `N_NP_ADDR;
    	  	  	axi_rready <= 1;
    	  	  	//-------------//
    	  	  	state <= ST_READE00_GET_DATA;
    	  	  end
    	  	else
    	  	  begin
    	  	  	axi_arvalid <= 1;
    	  	  	axi_araddr <= `N_NP_ADDR; 
    	  	  	axi_rready <= 0;
    	  	  end
    	  end
    	ST_READE00_GET_DATA:
    	  begin
    	  	if(axi_rready&&axi_rvalid)
    	  	  begin
    	  	  	axi_rready <= 0;
    	  	  	data_read <= axi_rdata;
    	  	  	//-----------------//
    	  	  	state <= ST_READE00_GAP;
    	  	  end
    	  end
    	ST_READE00_GAP:
    	  begin
    	  	if(cnt_timing[1])
    	  	  begin
    	  	  	cnt_timing <= 0;
    	  	  	//------------//
    	  	  	state <= ST_WRITE01_GIVE_ADDR;
    	  	  end
    	  	else
    	  	  cnt_timing <= cnt_timing + 1;
    	  end	
    	ST_WRITE01_GIVE_ADDR:
    	  begin
    	  	if(axi_awready&&axi_awvalid)
    	  	  begin
    	  	  	axi_awaddr <= `HD_S_ADDR;
    	  	  	axi_awvalid <= 1'b0;
    	  	  	//-----------------//
    	  	  	state <= ST_WRITE01_GIVE_DATA;
    	  	  end
    	  	else
    	  	  begin
    	  	  	axi_awaddr <= `HD_S_ADDR;
    	  	  	axi_awvalid <= 1'b1;
    	  	  end
    	  end
    	ST_WRITE01_GIVE_DATA:
    	  begin
    	  	if(axi_wready&&axi_wvalid)
    	  	  begin
    	  	    axi_wdata <= `HD_S_DATA;
    	  	    axi_wstrb <= 4'hf;
    	  	    axi_wvalid <= 0;
    	  	    //----------------//
    	  	    state <= ST_WRITE01_WAIT_RESP;
    	  	  end
    	  	else
    	  	  begin
    	  	  	axi_wdata <= `HD_S_DATA;
    	  	    axi_wstrb <= 4'hf;
    	  	    axi_wvalid <= 1;
    	  	    axi_bready <= 1;
    	  	  end
    	  end
    	ST_WRITE01_WAIT_RESP:
    	  begin
    	  	if(axi_bready&&axi_bvalid)
    	  	  state <= ST_READE01_GIVE_ADDR;
    	  end
    	ST_READE01_GIVE_ADDR:
    	  begin
    	  	if(axi_arvalid&&axi_arready)
    	  	  begin
    	  	  	axi_arvalid <= 0;
    	  	  	axi_araddr <= `HD_S_ADDR;
    	  	  	axi_rready <= 1;
    	  	  	//-------------//
    	  	  	state <= ST_READE01_GET_DATA;
    	  	  end
    	  	else
    	  	  begin
    	  	  	axi_arvalid <= 1;
    	  	  	axi_araddr <= `HD_S_ADDR; 
    	  	  	axi_rready <= 0;
    	  	  end
    	  end
    	ST_READE01_GET_DATA:
    	  begin
    	  	if(axi_rready&&axi_rvalid)
    	  	  begin
    	  	  	axi_rready <= 0;
    	  	  	data_read <= axi_rdata;
    	  	  	//-----------------//
    	  	  	state <= ST_READE01_GAP;
    	  	  end
    	  end
    	ST_READE01_GAP:
    	  begin
    	  	if(cnt_timing[1])
    	  	  begin
    	  	  	cnt_timing <= 0;
    	  	  	//------------//
    	  	  	state <= state;
    	  	  end
    	  	else
    	  	  cnt_timing <= cnt_timing + 1;
    	  end	  
    	default:
    	  begin
    	  	state <= ST_IDLE;
    	  end
    	endcase
    end
end

endmodule    	