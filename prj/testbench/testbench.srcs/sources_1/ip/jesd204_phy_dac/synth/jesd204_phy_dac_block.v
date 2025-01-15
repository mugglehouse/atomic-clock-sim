//----------------------------------------------------------------------------
// Title : JESD204 PHY Block
// Project : JESD204 PHY
//----------------------------------------------------------------------------
// File : jesd204_phy_dac_block.v
//----------------------------------------------------------------------------
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//----------------------------------------------------------------------------

`timescale 1ns / 1ps

//***********************************Entity Declaration************************

(* DowngradeIPIdentifiedWarnings="yes" *)
module jesd204_phy_dac_block (
  output              gt0_txresetdone_out,
  output              gt0_rxresetdone_out,

  // CPLL Ports
  output              gt0_cplllock_out,

  // RX Margin Analysis Ports
  output              gt0_eyescandataerror_out,
  input               gt0_eyescantrigger_in,
  input               gt0_eyescanreset_in,

  // TX Pattern Checker ports
  input               gt0_txprbsforceerr_in,

  // TX Initialization
  input               gt0_txpcsreset_in,
  input               gt0_txpmareset_in,

  // TX Buffer Ports
  output [1:0]        gt0_txbufstatus_out,

  // Rx CDR Ports
  input               gt0_rxcdrhold_in,

  // RX Pattern Checker ports
  output              gt0_rxprbserr_out,
  input  [2:0]        gt0_rxprbssel_in,
  input               gt0_rxprbscntreset_in,

  // RX Buffer Bypass Ports
  input               gt0_rxbufreset_in,
  output [2:0]        gt0_rxbufstatus_out,
  output [2:0]        gt0_rxstatus_out,

  // RX Byte and Word Alignment Ports
  output              gt0_rxbyteisaligned_out,
  output              gt0_rxbyterealign_out,
  output              gt0_rxcommadet_out,

  // Digital Monitor Ports
  output [7:0]        gt0_dmonitorout_out,

  // Receive Ports - RX Equalizer Ports
  output [6:0]        gt0_rxmonitorout_out,
  input  [1:0]        gt0_rxmonitorsel_in,

  // RX Initialization and Reset Ports
  input               gt0_rxpcsreset_in,
  input               gt0_rxpmareset_in,
  input               gt0_rxlpmen_in,
  input               gt0_rxdfelpmreset_in,

  output              gt1_txresetdone_out,
  output              gt1_rxresetdone_out,

  // CPLL Ports
  output              gt1_cplllock_out,

  // RX Margin Analysis Ports
  output              gt1_eyescandataerror_out,
  input               gt1_eyescantrigger_in,
  input               gt1_eyescanreset_in,

  // TX Pattern Checker ports
  input               gt1_txprbsforceerr_in,

  // TX Initialization
  input               gt1_txpcsreset_in,
  input               gt1_txpmareset_in,

  // TX Buffer Ports
  output [1:0]        gt1_txbufstatus_out,

  // Rx CDR Ports
  input               gt1_rxcdrhold_in,

  // RX Pattern Checker ports
  output              gt1_rxprbserr_out,
  input  [2:0]        gt1_rxprbssel_in,
  input               gt1_rxprbscntreset_in,

  // RX Buffer Bypass Ports
  input               gt1_rxbufreset_in,
  output [2:0]        gt1_rxbufstatus_out,
  output [2:0]        gt1_rxstatus_out,

  // RX Byte and Word Alignment Ports
  output              gt1_rxbyteisaligned_out,
  output              gt1_rxbyterealign_out,
  output              gt1_rxcommadet_out,

  // Digital Monitor Ports
  output [7:0]        gt1_dmonitorout_out,

  // Receive Ports - RX Equalizer Ports
  output [6:0]        gt1_rxmonitorout_out,
  input  [1:0]        gt1_rxmonitorsel_in,

  // RX Initialization and Reset Ports
  input               gt1_rxpcsreset_in,
  input               gt1_rxpmareset_in,
  input               gt1_rxlpmen_in,
  input               gt1_rxdfelpmreset_in,

  output              gt2_txresetdone_out,
  output              gt2_rxresetdone_out,

  // CPLL Ports
  output              gt2_cplllock_out,

  // RX Margin Analysis Ports
  output              gt2_eyescandataerror_out,
  input               gt2_eyescantrigger_in,
  input               gt2_eyescanreset_in,

  // TX Pattern Checker ports
  input               gt2_txprbsforceerr_in,

  // TX Initialization
  input               gt2_txpcsreset_in,
  input               gt2_txpmareset_in,

  // TX Buffer Ports
  output [1:0]        gt2_txbufstatus_out,

  // Rx CDR Ports
  input               gt2_rxcdrhold_in,

  // RX Pattern Checker ports
  output              gt2_rxprbserr_out,
  input  [2:0]        gt2_rxprbssel_in,
  input               gt2_rxprbscntreset_in,

  // RX Buffer Bypass Ports
  input               gt2_rxbufreset_in,
  output [2:0]        gt2_rxbufstatus_out,
  output [2:0]        gt2_rxstatus_out,

  // RX Byte and Word Alignment Ports
  output              gt2_rxbyteisaligned_out,
  output              gt2_rxbyterealign_out,
  output              gt2_rxcommadet_out,

  // Digital Monitor Ports
  output [7:0]        gt2_dmonitorout_out,

  // Receive Ports - RX Equalizer Ports
  output [6:0]        gt2_rxmonitorout_out,
  input  [1:0]        gt2_rxmonitorsel_in,

  // RX Initialization and Reset Ports
  input               gt2_rxpcsreset_in,
  input               gt2_rxpmareset_in,
  input               gt2_rxlpmen_in,
  input               gt2_rxdfelpmreset_in,

  output              gt3_txresetdone_out,
  output              gt3_rxresetdone_out,

  // CPLL Ports
  output              gt3_cplllock_out,

  // RX Margin Analysis Ports
  output              gt3_eyescandataerror_out,
  input               gt3_eyescantrigger_in,
  input               gt3_eyescanreset_in,

  // TX Pattern Checker ports
  input               gt3_txprbsforceerr_in,

  // TX Initialization
  input               gt3_txpcsreset_in,
  input               gt3_txpmareset_in,

  // TX Buffer Ports
  output [1:0]        gt3_txbufstatus_out,

  // Rx CDR Ports
  input               gt3_rxcdrhold_in,

  // RX Pattern Checker ports
  output              gt3_rxprbserr_out,
  input  [2:0]        gt3_rxprbssel_in,
  input               gt3_rxprbscntreset_in,

  // RX Buffer Bypass Ports
  input               gt3_rxbufreset_in,
  output [2:0]        gt3_rxbufstatus_out,
  output [2:0]        gt3_rxstatus_out,

  // RX Byte and Word Alignment Ports
  output              gt3_rxbyteisaligned_out,
  output              gt3_rxbyterealign_out,
  output              gt3_rxcommadet_out,

  // Digital Monitor Ports
  output [7:0]        gt3_dmonitorout_out,

  // Receive Ports - RX Equalizer Ports
  output [6:0]        gt3_rxmonitorout_out,
  input  [1:0]        gt3_rxmonitorsel_in,

  // RX Initialization and Reset Ports
  input               gt3_rxpcsreset_in,
  input               gt3_rxpmareset_in,
  input               gt3_rxlpmen_in,
  input               gt3_rxdfelpmreset_in,

  output              gt4_txresetdone_out,
  output              gt4_rxresetdone_out,

  // CPLL Ports
  output              gt4_cplllock_out,

  // RX Margin Analysis Ports
  output              gt4_eyescandataerror_out,
  input               gt4_eyescantrigger_in,
  input               gt4_eyescanreset_in,

  // TX Pattern Checker ports
  input               gt4_txprbsforceerr_in,

  // TX Initialization
  input               gt4_txpcsreset_in,
  input               gt4_txpmareset_in,

  // TX Buffer Ports
  output [1:0]        gt4_txbufstatus_out,

  // Rx CDR Ports
  input               gt4_rxcdrhold_in,

  // RX Pattern Checker ports
  output              gt4_rxprbserr_out,
  input  [2:0]        gt4_rxprbssel_in,
  input               gt4_rxprbscntreset_in,

  // RX Buffer Bypass Ports
  input               gt4_rxbufreset_in,
  output [2:0]        gt4_rxbufstatus_out,
  output [2:0]        gt4_rxstatus_out,

  // RX Byte and Word Alignment Ports
  output              gt4_rxbyteisaligned_out,
  output              gt4_rxbyterealign_out,
  output              gt4_rxcommadet_out,

  // Digital Monitor Ports
  output [7:0]        gt4_dmonitorout_out,

  // Receive Ports - RX Equalizer Ports
  output [6:0]        gt4_rxmonitorout_out,
  input  [1:0]        gt4_rxmonitorsel_in,

  // RX Initialization and Reset Ports
  input               gt4_rxpcsreset_in,
  input               gt4_rxpmareset_in,
  input               gt4_rxlpmen_in,
  input               gt4_rxdfelpmreset_in,

  output              gt5_txresetdone_out,
  output              gt5_rxresetdone_out,

  // CPLL Ports
  output              gt5_cplllock_out,

  // RX Margin Analysis Ports
  output              gt5_eyescandataerror_out,
  input               gt5_eyescantrigger_in,
  input               gt5_eyescanreset_in,

  // TX Pattern Checker ports
  input               gt5_txprbsforceerr_in,

  // TX Initialization
  input               gt5_txpcsreset_in,
  input               gt5_txpmareset_in,

  // TX Buffer Ports
  output [1:0]        gt5_txbufstatus_out,

  // Rx CDR Ports
  input               gt5_rxcdrhold_in,

  // RX Pattern Checker ports
  output              gt5_rxprbserr_out,
  input  [2:0]        gt5_rxprbssel_in,
  input               gt5_rxprbscntreset_in,

  // RX Buffer Bypass Ports
  input               gt5_rxbufreset_in,
  output [2:0]        gt5_rxbufstatus_out,
  output [2:0]        gt5_rxstatus_out,

  // RX Byte and Word Alignment Ports
  output              gt5_rxbyteisaligned_out,
  output              gt5_rxbyterealign_out,
  output              gt5_rxcommadet_out,

  // Digital Monitor Ports
  output [7:0]        gt5_dmonitorout_out,

  // Receive Ports - RX Equalizer Ports
  output [6:0]        gt5_rxmonitorout_out,
  input  [1:0]        gt5_rxmonitorsel_in,

  // RX Initialization and Reset Ports
  input               gt5_rxpcsreset_in,
  input               gt5_rxpmareset_in,
  input               gt5_rxlpmen_in,
  input               gt5_rxdfelpmreset_in,

  output              gt6_txresetdone_out,
  output              gt6_rxresetdone_out,

  // CPLL Ports
  output              gt6_cplllock_out,

  // RX Margin Analysis Ports
  output              gt6_eyescandataerror_out,
  input               gt6_eyescantrigger_in,
  input               gt6_eyescanreset_in,

  // TX Pattern Checker ports
  input               gt6_txprbsforceerr_in,

  // TX Initialization
  input               gt6_txpcsreset_in,
  input               gt6_txpmareset_in,

  // TX Buffer Ports
  output [1:0]        gt6_txbufstatus_out,

  // Rx CDR Ports
  input               gt6_rxcdrhold_in,

  // RX Pattern Checker ports
  output              gt6_rxprbserr_out,
  input  [2:0]        gt6_rxprbssel_in,
  input               gt6_rxprbscntreset_in,

  // RX Buffer Bypass Ports
  input               gt6_rxbufreset_in,
  output [2:0]        gt6_rxbufstatus_out,
  output [2:0]        gt6_rxstatus_out,

  // RX Byte and Word Alignment Ports
  output              gt6_rxbyteisaligned_out,
  output              gt6_rxbyterealign_out,
  output              gt6_rxcommadet_out,

  // Digital Monitor Ports
  output [7:0]        gt6_dmonitorout_out,

  // Receive Ports - RX Equalizer Ports
  output [6:0]        gt6_rxmonitorout_out,
  input  [1:0]        gt6_rxmonitorsel_in,

  // RX Initialization and Reset Ports
  input               gt6_rxpcsreset_in,
  input               gt6_rxpmareset_in,
  input               gt6_rxlpmen_in,
  input               gt6_rxdfelpmreset_in,

  output              gt7_txresetdone_out,
  output              gt7_rxresetdone_out,

  // CPLL Ports
  output              gt7_cplllock_out,

  // RX Margin Analysis Ports
  output              gt7_eyescandataerror_out,
  input               gt7_eyescantrigger_in,
  input               gt7_eyescanreset_in,

  // TX Pattern Checker ports
  input               gt7_txprbsforceerr_in,

  // TX Initialization
  input               gt7_txpcsreset_in,
  input               gt7_txpmareset_in,

  // TX Buffer Ports
  output [1:0]        gt7_txbufstatus_out,

  // Rx CDR Ports
  input               gt7_rxcdrhold_in,

  // RX Pattern Checker ports
  output              gt7_rxprbserr_out,
  input  [2:0]        gt7_rxprbssel_in,
  input               gt7_rxprbscntreset_in,

  // RX Buffer Bypass Ports
  input               gt7_rxbufreset_in,
  output [2:0]        gt7_rxbufstatus_out,
  output [2:0]        gt7_rxstatus_out,

  // RX Byte and Word Alignment Ports
  output              gt7_rxbyteisaligned_out,
  output              gt7_rxbyterealign_out,
  output              gt7_rxcommadet_out,

  // Digital Monitor Ports
  output [7:0]        gt7_dmonitorout_out,

  // Receive Ports - RX Equalizer Ports
  output [6:0]        gt7_rxmonitorout_out,
  input  [1:0]        gt7_rxmonitorsel_in,

  // RX Initialization and Reset Ports
  input               gt7_rxpcsreset_in,
  input               gt7_rxpmareset_in,
  input               gt7_rxlpmen_in,
  input               gt7_rxdfelpmreset_in,

  // System Reset Inputs for each direction
  input               tx_sys_reset,
  input               rx_sys_reset,
  
  // Reset Inputs for each direction
  input               tx_reset_gt,
  input               rx_reset_gt,

  // Reset Done for each direction
  output              tx_reset_done,
  output              rx_reset_done,

  // Refclk input pads
  input               cpll_refclk,

  // GT Common inputs
  input               common0_qpll_clk_in,
  input               common0_qpll_refclk_in,
  input               common1_qpll_clk_in,
  input               common1_qpll_refclk_in,

  input               rxencommaalign,

  // Clocks
  input               tx_core_clk,
  output              txoutclk,
  input               rx_core_clk,
  output              rxoutclk,
  input               drpclk,

  // Loopback
  input  [2:0]        gt0_loopback_in,

  // Power Down Ports
  input  [1:0]        gt0_rxpd_in,
  input  [1:0]        gt0_txpd_in,

  // GT Tx Control
  input  [4:0]        gt0_txpostcursor_in,
  input  [4:0]        gt0_txprecursor_in,
  input  [3:0]        gt0_txdiffctrl_in,
  input               gt0_txpolarity_in,
  input               gt0_txinhibit_in,

  // Rx Polarity Port
  input               gt0_rxpolarity_in,

  // DRP Ports
  input  [8:0]        gt0_drpaddr,
  input  [15:0]       gt0_drpdi,
  input               gt0_drpen,
  input               gt0_drpwe,
  output [15:0]       gt0_drpdo,
  output              gt0_drprdy,

  // Loopback
  input  [2:0]        gt1_loopback_in,

  // Power Down Ports
  input  [1:0]        gt1_rxpd_in,
  input  [1:0]        gt1_txpd_in,

  // GT Tx Control
  input  [4:0]        gt1_txpostcursor_in,
  input  [4:0]        gt1_txprecursor_in,
  input  [3:0]        gt1_txdiffctrl_in,
  input               gt1_txpolarity_in,
  input               gt1_txinhibit_in,

  // Rx Polarity Port
  input               gt1_rxpolarity_in,

  // DRP Ports
  input  [8:0]        gt1_drpaddr,
  input  [15:0]       gt1_drpdi,
  input               gt1_drpen,
  input               gt1_drpwe,
  output [15:0]       gt1_drpdo,
  output              gt1_drprdy,

  // Loopback
  input  [2:0]        gt2_loopback_in,

  // Power Down Ports
  input  [1:0]        gt2_rxpd_in,
  input  [1:0]        gt2_txpd_in,

  // GT Tx Control
  input  [4:0]        gt2_txpostcursor_in,
  input  [4:0]        gt2_txprecursor_in,
  input  [3:0]        gt2_txdiffctrl_in,
  input               gt2_txpolarity_in,
  input               gt2_txinhibit_in,

  // Rx Polarity Port
  input               gt2_rxpolarity_in,

  // DRP Ports
  input  [8:0]        gt2_drpaddr,
  input  [15:0]       gt2_drpdi,
  input               gt2_drpen,
  input               gt2_drpwe,
  output [15:0]       gt2_drpdo,
  output              gt2_drprdy,

  // Loopback
  input  [2:0]        gt3_loopback_in,

  // Power Down Ports
  input  [1:0]        gt3_rxpd_in,
  input  [1:0]        gt3_txpd_in,

  // GT Tx Control
  input  [4:0]        gt3_txpostcursor_in,
  input  [4:0]        gt3_txprecursor_in,
  input  [3:0]        gt3_txdiffctrl_in,
  input               gt3_txpolarity_in,
  input               gt3_txinhibit_in,

  // Rx Polarity Port
  input               gt3_rxpolarity_in,

  // DRP Ports
  input  [8:0]        gt3_drpaddr,
  input  [15:0]       gt3_drpdi,
  input               gt3_drpen,
  input               gt3_drpwe,
  output [15:0]       gt3_drpdo,
  output              gt3_drprdy,

  // Loopback
  input  [2:0]        gt4_loopback_in,

  // Power Down Ports
  input  [1:0]        gt4_rxpd_in,
  input  [1:0]        gt4_txpd_in,

  // GT Tx Control
  input  [4:0]        gt4_txpostcursor_in,
  input  [4:0]        gt4_txprecursor_in,
  input  [3:0]        gt4_txdiffctrl_in,
  input               gt4_txpolarity_in,
  input               gt4_txinhibit_in,

  // Rx Polarity Port
  input               gt4_rxpolarity_in,

  // DRP Ports
  input  [8:0]        gt4_drpaddr,
  input  [15:0]       gt4_drpdi,
  input               gt4_drpen,
  input               gt4_drpwe,
  output [15:0]       gt4_drpdo,
  output              gt4_drprdy,

  // Loopback
  input  [2:0]        gt5_loopback_in,

  // Power Down Ports
  input  [1:0]        gt5_rxpd_in,
  input  [1:0]        gt5_txpd_in,

  // GT Tx Control
  input  [4:0]        gt5_txpostcursor_in,
  input  [4:0]        gt5_txprecursor_in,
  input  [3:0]        gt5_txdiffctrl_in,
  input               gt5_txpolarity_in,
  input               gt5_txinhibit_in,

  // Rx Polarity Port
  input               gt5_rxpolarity_in,

  // DRP Ports
  input  [8:0]        gt5_drpaddr,
  input  [15:0]       gt5_drpdi,
  input               gt5_drpen,
  input               gt5_drpwe,
  output [15:0]       gt5_drpdo,
  output              gt5_drprdy,

  // Loopback
  input  [2:0]        gt6_loopback_in,

  // Power Down Ports
  input  [1:0]        gt6_rxpd_in,
  input  [1:0]        gt6_txpd_in,

  // GT Tx Control
  input  [4:0]        gt6_txpostcursor_in,
  input  [4:0]        gt6_txprecursor_in,
  input  [3:0]        gt6_txdiffctrl_in,
  input               gt6_txpolarity_in,
  input               gt6_txinhibit_in,

  // Rx Polarity Port
  input               gt6_rxpolarity_in,

  // DRP Ports
  input  [8:0]        gt6_drpaddr,
  input  [15:0]       gt6_drpdi,
  input               gt6_drpen,
  input               gt6_drpwe,
  output [15:0]       gt6_drpdo,
  output              gt6_drprdy,

  // Loopback
  input  [2:0]        gt7_loopback_in,

  // Power Down Ports
  input  [1:0]        gt7_rxpd_in,
  input  [1:0]        gt7_txpd_in,

  // GT Tx Control
  input  [4:0]        gt7_txpostcursor_in,
  input  [4:0]        gt7_txprecursor_in,
  input  [3:0]        gt7_txdiffctrl_in,
  input               gt7_txpolarity_in,
  input               gt7_txinhibit_in,

  // Rx Polarity Port
  input               gt7_rxpolarity_in,

  // DRP Ports
  input  [8:0]        gt7_drpaddr,
  input  [15:0]       gt7_drpdi,
  input               gt7_drpen,
  input               gt7_drpwe,
  output [15:0]       gt7_drpdo,
  output              gt7_drprdy,

  // PRBS mode
  input  [2:0]        gt_prbssel,

  // Tx Ports
  // Lane 0
  input  [31:0]       gt0_txdata,
  input  [3:0]        gt0_txcharisk,

  // Lane 1
  input  [31:0]       gt1_txdata,
  input  [3:0]        gt1_txcharisk,

  // Lane 2
  input  [31:0]       gt2_txdata,
  input  [3:0]        gt2_txcharisk,

  // Lane 3
  input  [31:0]       gt3_txdata,
  input  [3:0]        gt3_txcharisk,

  // Lane 4
  input  [31:0]       gt4_txdata,
  input  [3:0]        gt4_txcharisk,

  // Lane 5
  input  [31:0]       gt5_txdata,
  input  [3:0]        gt5_txcharisk,

  // Lane 6
  input  [31:0]       gt6_txdata,
  input  [3:0]        gt6_txcharisk,

  // Lane 7
  input  [31:0]       gt7_txdata,
  input  [3:0]        gt7_txcharisk,

  // Rx Ports
  // Lane 0
  output [31:0]       gt0_rxdata,
  output [3:0]        gt0_rxcharisk,
  output [3:0]        gt0_rxdisperr,
  output [3:0]        gt0_rxnotintable,

  // Lane 1
  output [31:0]       gt1_rxdata,
  output [3:0]        gt1_rxcharisk,
  output [3:0]        gt1_rxdisperr,
  output [3:0]        gt1_rxnotintable,

  // Lane 2
  output [31:0]       gt2_rxdata,
  output [3:0]        gt2_rxcharisk,
  output [3:0]        gt2_rxdisperr,
  output [3:0]        gt2_rxnotintable,

  // Lane 3
  output [31:0]       gt3_rxdata,
  output [3:0]        gt3_rxcharisk,
  output [3:0]        gt3_rxdisperr,
  output [3:0]        gt3_rxnotintable,

  // Lane 4
  output [31:0]       gt4_rxdata,
  output [3:0]        gt4_rxcharisk,
  output [3:0]        gt4_rxdisperr,
  output [3:0]        gt4_rxnotintable,

  // Lane 5
  output [31:0]       gt5_rxdata,
  output [3:0]        gt5_rxcharisk,
  output [3:0]        gt5_rxdisperr,
  output [3:0]        gt5_rxnotintable,

  // Lane 6
  output [31:0]       gt6_rxdata,
  output [3:0]        gt6_rxcharisk,
  output [3:0]        gt6_rxdisperr,
  output [3:0]        gt6_rxnotintable,

  // Lane 7
  output [31:0]       gt7_rxdata,
  output [3:0]        gt7_rxcharisk,
  output [3:0]        gt7_rxdisperr,
  output [3:0]        gt7_rxnotintable,

  // Serial ports
  input  [7:0]        rxn_in,
  input  [7:0]        rxp_in,
  output [7:0]        txn_out,
  output [7:0]        txp_out
);

  //pll_sel = 0: CPLL is in use
  //pll_sel = 3: QPLL is in use
  localparam tx_pll_sel = 0;
  localparam rx_pll_sel = 0;
  
//************************** Register Declarations ****************************
  wire            gt0_cplllock_i;

  wire            gt0_rxresetdone_i;
  wire            gt0_txresetdone_i;

  wire            gt1_cplllock_i;

  wire            gt1_rxresetdone_i;
  wire            gt1_txresetdone_i;

  wire            gt2_cplllock_i;

  wire            gt2_rxresetdone_i;
  wire            gt2_txresetdone_i;

  wire            gt3_cplllock_i;

  wire            gt3_rxresetdone_i;
  wire            gt3_txresetdone_i;

  wire            gt4_cplllock_i;

  wire            gt4_rxresetdone_i;
  wire            gt4_txresetdone_i;

  wire            gt5_cplllock_i;

  wire            gt5_rxresetdone_i;
  wire            gt5_txresetdone_i;

  wire            gt6_cplllock_i;

  wire            gt6_rxresetdone_i;
  wire            gt6_txresetdone_i;

  wire            gt7_cplllock_i;

  wire            gt7_rxresetdone_i;
  wire            gt7_txresetdone_i;

  wire            gt_txfsmdone;
  wire            gt_rxfsmdone;

  wire [7:0]      rxoutclk_bus;
  wire [7:0]      txoutclk_bus;
  
  wire            qplllock_i;
  wire            common0_qpll_reset_i;
  wire            common1_qpll_reset_i;
  wire            common2_qpll_reset_i;

  wire            cpll_lock;
  reg             cpll_lock_r;
 
  
  wire            tx_pll_lock;
  reg             tx_pll_lock_i;
  wire            rx_pll_lock;
  reg             rx_pll_lock_i;

  wire            tx_pll_lock_sync;
  wire            rx_pll_lock_sync;

  wire  [7:0]     cpllpd_i;
  wire  [1:0]     gt0_txsysclksel_i;
  wire  [1:0]     gt0_rxsysclksel_i;
  wire  [1:0]     gt1_txsysclksel_i;
  wire  [1:0]     gt1_rxsysclksel_i;
  wire  [1:0]     gt2_txsysclksel_i;
  wire  [1:0]     gt2_rxsysclksel_i;
  wire  [1:0]     gt3_txsysclksel_i;
  wire  [1:0]     gt3_rxsysclksel_i;
  wire  [1:0]     gt4_txsysclksel_i;
  wire  [1:0]     gt4_rxsysclksel_i;
  wire  [1:0]     gt5_txsysclksel_i;
  wire  [1:0]     gt5_rxsysclksel_i;
  wire  [1:0]     gt6_txsysclksel_i;
  wire  [1:0]     gt6_rxsysclksel_i;
  wire  [1:0]     gt7_txsysclksel_i;
  wire  [1:0]     gt7_rxsysclksel_i;

  reg             gt_txreset;
  reg             gt_rxreset;
  
  wire            tx_rst_gt_data_sync;
  wire            rx_rst_gt_data_sync;
  wire            tx_rst_all_sync;
  wire            rx_rst_all_sync;
  
  wire            tx_chan_rst_done;
  wire            rx_chan_rst_done;
  wire            tx_chan_rst_done_sync;
  wire            rx_chan_rst_done_sync;
  reg             tx_chan_rst_done_r;
  reg             rx_chan_rst_done_r;
  reg             tx_reset_done_r;
  reg             rx_reset_done_r; 


  
  // Assign sysclksel based on PLL selection
  assign gt0_txsysclksel_i   = 2'b00;
  assign gt0_rxsysclksel_i   = 2'b00;
  // Assign sysclksel based on PLL selection
  assign gt1_txsysclksel_i   = 2'b00;
  assign gt1_rxsysclksel_i   = 2'b00;
  // Assign sysclksel based on PLL selection
  assign gt2_txsysclksel_i   = 2'b00;
  assign gt2_rxsysclksel_i   = 2'b00;
  // Assign sysclksel based on PLL selection
  assign gt3_txsysclksel_i   = 2'b00;
  assign gt3_rxsysclksel_i   = 2'b00;
  // Assign sysclksel based on PLL selection
  assign gt4_txsysclksel_i   = 2'b00;
  assign gt4_rxsysclksel_i   = 2'b00;
  // Assign sysclksel based on PLL selection
  assign gt5_txsysclksel_i   = 2'b00;
  assign gt5_rxsysclksel_i   = 2'b00;
  // Assign sysclksel based on PLL selection
  assign gt6_txsysclksel_i   = 2'b00;
  assign gt6_rxsysclksel_i   = 2'b00;
  // Assign sysclksel based on PLL selection
  assign gt7_txsysclksel_i   = 2'b00;
  assign gt7_rxsysclksel_i   = 2'b00;

  
  // Assign cpllpd based on PLL selection
  assign cpllpd_i        = {8{1'b0}};
  
  //Synchronize gt_reset_in to drpclk domain
  jesd204_phy_dac_sync_block #(
    .TYPE (1)
  ) sync_tx_reset_data 
  (
    .clk             (drpclk),
    .data_in         (tx_reset_gt),
    .data_out        (tx_rst_gt_data_sync)
  );

  jesd204_phy_dac_sync_block #(
    .TYPE (1)
  ) sync_rx_reset_data 
  (
    .clk             (drpclk),
    .data_in         (rx_reset_gt),
    .data_out        (rx_rst_gt_data_sync)
  );  
  
  jesd204_phy_dac_sync_block #(
    .TYPE (1)
  ) sync_tx_reset_all 
  (
    .clk             (drpclk),
    .data_in         (tx_sys_reset),
    .data_out        (tx_rst_all_sync)
  );

  jesd204_phy_dac_sync_block #(
    .TYPE (1)
  ) sync_rx_reset_all 
  (
    .clk             (drpclk),
    .data_in         (rx_sys_reset),
    .data_out        (rx_rst_all_sync)
  );    

  //***********************************************************************//
  //                                                                       //
  //--------------------------- The GT Wrapper ----------------------------//
  //                                                                       //
  //***********************************************************************//

  jesd204_phy_dac_gt
  jesd204_phy_dac_gt (

    .sysclk_in                   (drpclk),
    .soft_reset_rx_in            (gt_rxreset),
    .soft_reset_tx_in            (gt_txreset),
    .dont_reset_on_data_error_in (1'b0),
    .gt_tx_fsm_reset_done_out    (gt_txfsmdone),
    .gt_rx_fsm_reset_done_out    (gt_rxfsmdone),

    //_________________________________________________________________________
    //GT0  (X1Y0)
    //____________________________CHANNEL PORTS________________________________
    .gt0_data_valid_in         (1'b1),
    //------------------------------- CPLL Ports -------------------------------
    .gt0_cpllfbclklost_out     (),
    .gt0_cplllock_out          (gt0_cplllock_i),
    .gt0_cplllockdetclk_in     (1'b0),
    .gt0_cpllpd_in             (cpllpd_i[0]),
    .gt0_cpllreset_in          (1'b0),
    //------------------------ Channel - Clocking Ports ------------------------
    .gt0_gtnorthrefclk0_in     (1'b0),
    .gt0_gtnorthrefclk1_in     (1'b0),
    .gt0_gtrefclk0_in          (cpll_refclk),
    .gt0_gtrefclk1_in          (1'b0),
    .gt0_gtsouthrefclk0_in     (1'b0),
    .gt0_gtsouthrefclk1_in     (1'b0),
    //-------------------------- Channel - DRP Ports  --------------------------
    .gt0_drpaddr_in            (gt0_drpaddr),
    .gt0_drpclk_in             (drpclk),
    .gt0_drpdi_in              (gt0_drpdi),
    .gt0_drpdo_out             (gt0_drpdo),
    .gt0_drpen_in              (gt0_drpen),
    .gt0_drprdy_out            (gt0_drprdy),
    .gt0_drpwe_in              (gt0_drpwe),
    //----------------------------- Clocking Ports -----------------------------
    .gt0_rxsysclksel_in        (gt0_rxsysclksel_i),
    .gt0_txsysclksel_in        (gt0_txsysclksel_i),
    //------------------------- Digital Monitor Ports --------------------------
    .gt0_dmonitorout_out       (gt0_dmonitorout_out),
    //----------------------------- Loopback Ports -----------------------------
    .gt0_loopback_in           (gt0_loopback_in),
    //---------------------------- Power-Down Ports ----------------------------
    .gt0_rxpd_in               (gt0_rxpd_in),
    .gt0_txpd_in               (gt0_txpd_in),
    //------------------- RX Initialization and Reset Ports --------------------
    .gt0_eyescanreset_in       (gt0_eyescanreset_in),
    .gt0_rxuserrdy_in          (1'b1),
    //------------------------ RX Margin Analysis Ports ------------------------
    .gt0_eyescandataerror_out  (gt0_eyescandataerror_out),
    .gt0_eyescantrigger_in     (gt0_eyescantrigger_in),
    //----------------------- Receive Ports - CDR Ports ------------------------
    .gt0_rxcdrhold_in          (gt0_rxcdrhold_in),
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    .gt0_rxusrclk_in           (rx_core_clk),
    .gt0_rxusrclk2_in          (rx_core_clk),
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .gt0_rxdata_out            (gt0_rxdata),
    //----------------- Receive Ports - Pattern Checker Ports ------------------
    .gt0_rxprbserr_out         (gt0_rxprbserr_out),
    .gt0_rxprbssel_in          (gt0_rxprbssel_in),
    //----------------- Receive Ports - Pattern Checker ports ------------------
    .gt0_rxprbscntreset_in     (gt0_rxprbscntreset_in),
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    .gt0_rxdisperr_out         (gt0_rxdisperr),
    .gt0_rxnotintable_out      (gt0_rxnotintable),
    //------------------------- Receive Ports - RX AFE -------------------------
    .gt0_gtxrxp_in             (rxp_in[0]),
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .gt0_gtxrxn_in             (rxn_in[0]),
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    .gt0_rxbufreset_in         (gt0_rxbufreset_in),
    .gt0_rxbufstatus_out       (gt0_rxbufstatus_out),
    .gt0_rxstatus_out          (gt0_rxstatus_out),
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    .gt0_rxbyteisaligned_out   (gt0_rxbyteisaligned_out),
    .gt0_rxbyterealign_out     (gt0_rxbyterealign_out),
    .gt0_rxcommadet_out        (gt0_rxcommadet_out),
    .gt0_rxmcommaalignen_in    (rxencommaalign),
    .gt0_rxpcommaalignen_in    (rxencommaalign),
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    .gt0_rxdfelpmreset_in      (gt0_rxdfelpmreset_in),
    .gt0_rxmonitorout_out      (gt0_rxmonitorout_out),
    .gt0_rxmonitorsel_in       (gt0_rxmonitorsel_in),
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    .gt0_rxoutclk_out          (rxoutclk_bus[0]),
    .gt0_rxoutclkfabric_out    (),
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    .gt0_gtrxreset_in          (rx_rst_gt_data_sync),
    .gt0_rxpcsreset_in         (gt0_rxpcsreset_in),
    .gt0_rxpmareset_in         (gt0_rxpmareset_in),
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    .gt0_rxlpmen_in            (gt0_rxlpmen_in),
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    .gt0_rxpolarity_in         (gt0_rxpolarity_in),
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    .gt0_rxchariscomma_out     (),
    .gt0_rxcharisk_out         (gt0_rxcharisk),
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .gt0_rxresetdone_out       (gt0_rxresetdone_i),
    //---------------------- TX Configurable Driver Ports ----------------------
    .gt0_txpostcursor_in       (gt0_txpostcursor_in),
    .gt0_txprecursor_in        (gt0_txprecursor_in),
    //------------------- TX Initialization and Reset Ports --------------------
    .gt0_gttxreset_in          (tx_rst_gt_data_sync),
    .gt0_txuserrdy_in          (1'b1),
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .gt0_txusrclk_in           (tx_core_clk),
    .gt0_txusrclk2_in          (tx_core_clk),
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
    .gt0_txprbsforceerr_in     (gt0_txprbsforceerr_in),
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    .gt0_txbufstatus_out       (gt0_txbufstatus_out),
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    .gt0_txdiffctrl_in         (gt0_txdiffctrl_in),
    .gt0_txinhibit_in          (gt0_txinhibit_in),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .gt0_txdata_in             (gt0_txdata),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .gt0_gtxtxn_out            (txn_out[0]),
    .gt0_gtxtxp_out            (txp_out[0]),
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    .gt0_txoutclk_out          (txoutclk_bus[0]),
    .gt0_txoutclkfabric_out    (),
    .gt0_txoutclkpcs_out       (),
    //------------------- Transmit Ports - TX Gearbox Ports --------------------
    .gt0_txcharisk_in          (gt0_txcharisk),
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    .gt0_txpcsreset_in         (gt0_txpcsreset_in),
    .gt0_txpmareset_in         (gt0_txpmareset_in),
    .gt0_txresetdone_out       (gt0_txresetdone_i),
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    .gt0_txpolarity_in         (gt0_txpolarity_in),
    //---------------- Transmit Ports - pattern Generator Ports ----------------
    .gt0_txprbssel_in          (gt_prbssel),

    //GT1  (X1Y1)
    //____________________________CHANNEL PORTS________________________________
    .gt1_data_valid_in         (1'b1),
    //------------------------------- CPLL Ports -------------------------------
    .gt1_cpllfbclklost_out     (),
    .gt1_cplllock_out          (gt1_cplllock_i),
    .gt1_cplllockdetclk_in     (1'b0),
    .gt1_cpllpd_in             (cpllpd_i[1]),
    .gt1_cpllreset_in          (1'b0),
    //------------------------ Channel - Clocking Ports ------------------------
    .gt1_gtnorthrefclk0_in     (1'b0),
    .gt1_gtnorthrefclk1_in     (1'b0),
    .gt1_gtrefclk0_in          (cpll_refclk),
    .gt1_gtrefclk1_in          (1'b0),
    .gt1_gtsouthrefclk0_in     (1'b0),
    .gt1_gtsouthrefclk1_in     (1'b0),
    //-------------------------- Channel - DRP Ports  --------------------------
    .gt1_drpaddr_in            (gt1_drpaddr),
    .gt1_drpclk_in             (drpclk),
    .gt1_drpdi_in              (gt1_drpdi),
    .gt1_drpdo_out             (gt1_drpdo),
    .gt1_drpen_in              (gt1_drpen),
    .gt1_drprdy_out            (gt1_drprdy),
    .gt1_drpwe_in              (gt1_drpwe),
    //----------------------------- Clocking Ports -----------------------------
    .gt1_rxsysclksel_in        (gt1_rxsysclksel_i),
    .gt1_txsysclksel_in        (gt1_txsysclksel_i),
    //------------------------- Digital Monitor Ports --------------------------
    .gt1_dmonitorout_out       (gt1_dmonitorout_out),
    //----------------------------- Loopback Ports -----------------------------
    .gt1_loopback_in           (gt1_loopback_in),
    //---------------------------- Power-Down Ports ----------------------------
    .gt1_rxpd_in               (gt1_rxpd_in),
    .gt1_txpd_in               (gt1_txpd_in),
    //------------------- RX Initialization and Reset Ports --------------------
    .gt1_eyescanreset_in       (gt1_eyescanreset_in),
    .gt1_rxuserrdy_in          (1'b1),
    //------------------------ RX Margin Analysis Ports ------------------------
    .gt1_eyescandataerror_out  (gt1_eyescandataerror_out),
    .gt1_eyescantrigger_in     (gt1_eyescantrigger_in),
    //----------------------- Receive Ports - CDR Ports ------------------------
    .gt1_rxcdrhold_in          (gt1_rxcdrhold_in),
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    .gt1_rxusrclk_in           (rx_core_clk),
    .gt1_rxusrclk2_in          (rx_core_clk),
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .gt1_rxdata_out            (gt1_rxdata),
    //----------------- Receive Ports - Pattern Checker Ports ------------------
    .gt1_rxprbserr_out         (gt1_rxprbserr_out),
    .gt1_rxprbssel_in          (gt1_rxprbssel_in),
    //----------------- Receive Ports - Pattern Checker ports ------------------
    .gt1_rxprbscntreset_in     (gt1_rxprbscntreset_in),
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    .gt1_rxdisperr_out         (gt1_rxdisperr),
    .gt1_rxnotintable_out      (gt1_rxnotintable),
    //------------------------- Receive Ports - RX AFE -------------------------
    .gt1_gtxrxp_in             (rxp_in[1]),
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .gt1_gtxrxn_in             (rxn_in[1]),
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    .gt1_rxbufreset_in         (gt1_rxbufreset_in),
    .gt1_rxbufstatus_out       (gt1_rxbufstatus_out),
    .gt1_rxstatus_out          (gt1_rxstatus_out),
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    .gt1_rxbyteisaligned_out   (gt1_rxbyteisaligned_out),
    .gt1_rxbyterealign_out     (gt1_rxbyterealign_out),
    .gt1_rxcommadet_out        (gt1_rxcommadet_out),
    .gt1_rxmcommaalignen_in    (rxencommaalign),
    .gt1_rxpcommaalignen_in    (rxencommaalign),
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    .gt1_rxdfelpmreset_in      (gt1_rxdfelpmreset_in),
    .gt1_rxmonitorout_out      (gt1_rxmonitorout_out),
    .gt1_rxmonitorsel_in       (gt1_rxmonitorsel_in),
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    .gt1_rxoutclk_out          (rxoutclk_bus[1]),
    .gt1_rxoutclkfabric_out    (),
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    .gt1_gtrxreset_in          (rx_rst_gt_data_sync),
    .gt1_rxpcsreset_in         (gt1_rxpcsreset_in),
    .gt1_rxpmareset_in         (gt1_rxpmareset_in),
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    .gt1_rxlpmen_in            (gt1_rxlpmen_in),
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    .gt1_rxpolarity_in         (gt1_rxpolarity_in),
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    .gt1_rxchariscomma_out     (),
    .gt1_rxcharisk_out         (gt1_rxcharisk),
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .gt1_rxresetdone_out       (gt1_rxresetdone_i),
    //---------------------- TX Configurable Driver Ports ----------------------
    .gt1_txpostcursor_in       (gt1_txpostcursor_in),
    .gt1_txprecursor_in        (gt1_txprecursor_in),
    //------------------- TX Initialization and Reset Ports --------------------
    .gt1_gttxreset_in          (tx_rst_gt_data_sync),
    .gt1_txuserrdy_in          (1'b1),
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .gt1_txusrclk_in           (tx_core_clk),
    .gt1_txusrclk2_in          (tx_core_clk),
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
    .gt1_txprbsforceerr_in     (gt1_txprbsforceerr_in),
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    .gt1_txbufstatus_out       (gt1_txbufstatus_out),
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    .gt1_txdiffctrl_in         (gt1_txdiffctrl_in),
    .gt1_txinhibit_in          (gt1_txinhibit_in),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .gt1_txdata_in             (gt1_txdata),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .gt1_gtxtxn_out            (txn_out[1]),
    .gt1_gtxtxp_out            (txp_out[1]),
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    .gt1_txoutclk_out          (txoutclk_bus[1]),
    .gt1_txoutclkfabric_out    (),
    .gt1_txoutclkpcs_out       (),
    //------------------- Transmit Ports - TX Gearbox Ports --------------------
    .gt1_txcharisk_in          (gt1_txcharisk),
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    .gt1_txpcsreset_in         (gt1_txpcsreset_in),
    .gt1_txpmareset_in         (gt1_txpmareset_in),
    .gt1_txresetdone_out       (gt1_txresetdone_i),
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    .gt1_txpolarity_in         (gt1_txpolarity_in),
    //---------------- Transmit Ports - pattern Generator Ports ----------------
    .gt1_txprbssel_in          (gt_prbssel),

    //GT2  (X1Y2)
    //____________________________CHANNEL PORTS________________________________
    .gt2_data_valid_in         (1'b1),
    //------------------------------- CPLL Ports -------------------------------
    .gt2_cpllfbclklost_out     (),
    .gt2_cplllock_out          (gt2_cplllock_i),
    .gt2_cplllockdetclk_in     (1'b0),
    .gt2_cpllpd_in             (cpllpd_i[2]),
    .gt2_cpllreset_in          (1'b0),
    //------------------------ Channel - Clocking Ports ------------------------
    .gt2_gtnorthrefclk0_in     (1'b0),
    .gt2_gtnorthrefclk1_in     (1'b0),
    .gt2_gtrefclk0_in          (cpll_refclk),
    .gt2_gtrefclk1_in          (1'b0),
    .gt2_gtsouthrefclk0_in     (1'b0),
    .gt2_gtsouthrefclk1_in     (1'b0),
    //-------------------------- Channel - DRP Ports  --------------------------
    .gt2_drpaddr_in            (gt2_drpaddr),
    .gt2_drpclk_in             (drpclk),
    .gt2_drpdi_in              (gt2_drpdi),
    .gt2_drpdo_out             (gt2_drpdo),
    .gt2_drpen_in              (gt2_drpen),
    .gt2_drprdy_out            (gt2_drprdy),
    .gt2_drpwe_in              (gt2_drpwe),
    //----------------------------- Clocking Ports -----------------------------
    .gt2_rxsysclksel_in        (gt2_rxsysclksel_i),
    .gt2_txsysclksel_in        (gt2_txsysclksel_i),
    //------------------------- Digital Monitor Ports --------------------------
    .gt2_dmonitorout_out       (gt2_dmonitorout_out),
    //----------------------------- Loopback Ports -----------------------------
    .gt2_loopback_in           (gt2_loopback_in),
    //---------------------------- Power-Down Ports ----------------------------
    .gt2_rxpd_in               (gt2_rxpd_in),
    .gt2_txpd_in               (gt2_txpd_in),
    //------------------- RX Initialization and Reset Ports --------------------
    .gt2_eyescanreset_in       (gt2_eyescanreset_in),
    .gt2_rxuserrdy_in          (1'b1),
    //------------------------ RX Margin Analysis Ports ------------------------
    .gt2_eyescandataerror_out  (gt2_eyescandataerror_out),
    .gt2_eyescantrigger_in     (gt2_eyescantrigger_in),
    //----------------------- Receive Ports - CDR Ports ------------------------
    .gt2_rxcdrhold_in          (gt2_rxcdrhold_in),
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    .gt2_rxusrclk_in           (rx_core_clk),
    .gt2_rxusrclk2_in          (rx_core_clk),
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .gt2_rxdata_out            (gt2_rxdata),
    //----------------- Receive Ports - Pattern Checker Ports ------------------
    .gt2_rxprbserr_out         (gt2_rxprbserr_out),
    .gt2_rxprbssel_in          (gt2_rxprbssel_in),
    //----------------- Receive Ports - Pattern Checker ports ------------------
    .gt2_rxprbscntreset_in     (gt2_rxprbscntreset_in),
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    .gt2_rxdisperr_out         (gt2_rxdisperr),
    .gt2_rxnotintable_out      (gt2_rxnotintable),
    //------------------------- Receive Ports - RX AFE -------------------------
    .gt2_gtxrxp_in             (rxp_in[2]),
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .gt2_gtxrxn_in             (rxn_in[2]),
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    .gt2_rxbufreset_in         (gt2_rxbufreset_in),
    .gt2_rxbufstatus_out       (gt2_rxbufstatus_out),
    .gt2_rxstatus_out          (gt2_rxstatus_out),
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    .gt2_rxbyteisaligned_out   (gt2_rxbyteisaligned_out),
    .gt2_rxbyterealign_out     (gt2_rxbyterealign_out),
    .gt2_rxcommadet_out        (gt2_rxcommadet_out),
    .gt2_rxmcommaalignen_in    (rxencommaalign),
    .gt2_rxpcommaalignen_in    (rxencommaalign),
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    .gt2_rxdfelpmreset_in      (gt2_rxdfelpmreset_in),
    .gt2_rxmonitorout_out      (gt2_rxmonitorout_out),
    .gt2_rxmonitorsel_in       (gt2_rxmonitorsel_in),
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    .gt2_rxoutclk_out          (rxoutclk_bus[2]),
    .gt2_rxoutclkfabric_out    (),
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    .gt2_gtrxreset_in          (rx_rst_gt_data_sync),
    .gt2_rxpcsreset_in         (gt2_rxpcsreset_in),
    .gt2_rxpmareset_in         (gt2_rxpmareset_in),
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    .gt2_rxlpmen_in            (gt2_rxlpmen_in),
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    .gt2_rxpolarity_in         (gt2_rxpolarity_in),
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    .gt2_rxchariscomma_out     (),
    .gt2_rxcharisk_out         (gt2_rxcharisk),
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .gt2_rxresetdone_out       (gt2_rxresetdone_i),
    //---------------------- TX Configurable Driver Ports ----------------------
    .gt2_txpostcursor_in       (gt2_txpostcursor_in),
    .gt2_txprecursor_in        (gt2_txprecursor_in),
    //------------------- TX Initialization and Reset Ports --------------------
    .gt2_gttxreset_in          (tx_rst_gt_data_sync),
    .gt2_txuserrdy_in          (1'b1),
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .gt2_txusrclk_in           (tx_core_clk),
    .gt2_txusrclk2_in          (tx_core_clk),
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
    .gt2_txprbsforceerr_in     (gt2_txprbsforceerr_in),
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    .gt2_txbufstatus_out       (gt2_txbufstatus_out),
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    .gt2_txdiffctrl_in         (gt2_txdiffctrl_in),
    .gt2_txinhibit_in          (gt2_txinhibit_in),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .gt2_txdata_in             (gt2_txdata),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .gt2_gtxtxn_out            (txn_out[2]),
    .gt2_gtxtxp_out            (txp_out[2]),
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    .gt2_txoutclk_out          (txoutclk_bus[2]),
    .gt2_txoutclkfabric_out    (),
    .gt2_txoutclkpcs_out       (),
    //------------------- Transmit Ports - TX Gearbox Ports --------------------
    .gt2_txcharisk_in          (gt2_txcharisk),
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    .gt2_txpcsreset_in         (gt2_txpcsreset_in),
    .gt2_txpmareset_in         (gt2_txpmareset_in),
    .gt2_txresetdone_out       (gt2_txresetdone_i),
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    .gt2_txpolarity_in         (gt2_txpolarity_in),
    //---------------- Transmit Ports - pattern Generator Ports ----------------
    .gt2_txprbssel_in          (gt_prbssel),

    //GT3  (X1Y3)
    //____________________________CHANNEL PORTS________________________________
    .gt3_data_valid_in         (1'b1),
    //------------------------------- CPLL Ports -------------------------------
    .gt3_cpllfbclklost_out     (),
    .gt3_cplllock_out          (gt3_cplllock_i),
    .gt3_cplllockdetclk_in     (1'b0),
    .gt3_cpllpd_in             (cpllpd_i[3]),
    .gt3_cpllreset_in          (1'b0),
    //------------------------ Channel - Clocking Ports ------------------------
    .gt3_gtnorthrefclk0_in     (1'b0),
    .gt3_gtnorthrefclk1_in     (1'b0),
    .gt3_gtrefclk0_in          (cpll_refclk),
    .gt3_gtrefclk1_in          (1'b0),
    .gt3_gtsouthrefclk0_in     (1'b0),
    .gt3_gtsouthrefclk1_in     (1'b0),
    //-------------------------- Channel - DRP Ports  --------------------------
    .gt3_drpaddr_in            (gt3_drpaddr),
    .gt3_drpclk_in             (drpclk),
    .gt3_drpdi_in              (gt3_drpdi),
    .gt3_drpdo_out             (gt3_drpdo),
    .gt3_drpen_in              (gt3_drpen),
    .gt3_drprdy_out            (gt3_drprdy),
    .gt3_drpwe_in              (gt3_drpwe),
    //----------------------------- Clocking Ports -----------------------------
    .gt3_rxsysclksel_in        (gt3_rxsysclksel_i),
    .gt3_txsysclksel_in        (gt3_txsysclksel_i),
    //------------------------- Digital Monitor Ports --------------------------
    .gt3_dmonitorout_out       (gt3_dmonitorout_out),
    //----------------------------- Loopback Ports -----------------------------
    .gt3_loopback_in           (gt3_loopback_in),
    //---------------------------- Power-Down Ports ----------------------------
    .gt3_rxpd_in               (gt3_rxpd_in),
    .gt3_txpd_in               (gt3_txpd_in),
    //------------------- RX Initialization and Reset Ports --------------------
    .gt3_eyescanreset_in       (gt3_eyescanreset_in),
    .gt3_rxuserrdy_in          (1'b1),
    //------------------------ RX Margin Analysis Ports ------------------------
    .gt3_eyescandataerror_out  (gt3_eyescandataerror_out),
    .gt3_eyescantrigger_in     (gt3_eyescantrigger_in),
    //----------------------- Receive Ports - CDR Ports ------------------------
    .gt3_rxcdrhold_in          (gt3_rxcdrhold_in),
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    .gt3_rxusrclk_in           (rx_core_clk),
    .gt3_rxusrclk2_in          (rx_core_clk),
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .gt3_rxdata_out            (gt3_rxdata),
    //----------------- Receive Ports - Pattern Checker Ports ------------------
    .gt3_rxprbserr_out         (gt3_rxprbserr_out),
    .gt3_rxprbssel_in          (gt3_rxprbssel_in),
    //----------------- Receive Ports - Pattern Checker ports ------------------
    .gt3_rxprbscntreset_in     (gt3_rxprbscntreset_in),
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    .gt3_rxdisperr_out         (gt3_rxdisperr),
    .gt3_rxnotintable_out      (gt3_rxnotintable),
    //------------------------- Receive Ports - RX AFE -------------------------
    .gt3_gtxrxp_in             (rxp_in[3]),
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .gt3_gtxrxn_in             (rxn_in[3]),
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    .gt3_rxbufreset_in         (gt3_rxbufreset_in),
    .gt3_rxbufstatus_out       (gt3_rxbufstatus_out),
    .gt3_rxstatus_out          (gt3_rxstatus_out),
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    .gt3_rxbyteisaligned_out   (gt3_rxbyteisaligned_out),
    .gt3_rxbyterealign_out     (gt3_rxbyterealign_out),
    .gt3_rxcommadet_out        (gt3_rxcommadet_out),
    .gt3_rxmcommaalignen_in    (rxencommaalign),
    .gt3_rxpcommaalignen_in    (rxencommaalign),
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    .gt3_rxdfelpmreset_in      (gt3_rxdfelpmreset_in),
    .gt3_rxmonitorout_out      (gt3_rxmonitorout_out),
    .gt3_rxmonitorsel_in       (gt3_rxmonitorsel_in),
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    .gt3_rxoutclk_out          (rxoutclk_bus[3]),
    .gt3_rxoutclkfabric_out    (),
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    .gt3_gtrxreset_in          (rx_rst_gt_data_sync),
    .gt3_rxpcsreset_in         (gt3_rxpcsreset_in),
    .gt3_rxpmareset_in         (gt3_rxpmareset_in),
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    .gt3_rxlpmen_in            (gt3_rxlpmen_in),
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    .gt3_rxpolarity_in         (gt3_rxpolarity_in),
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    .gt3_rxchariscomma_out     (),
    .gt3_rxcharisk_out         (gt3_rxcharisk),
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .gt3_rxresetdone_out       (gt3_rxresetdone_i),
    //---------------------- TX Configurable Driver Ports ----------------------
    .gt3_txpostcursor_in       (gt3_txpostcursor_in),
    .gt3_txprecursor_in        (gt3_txprecursor_in),
    //------------------- TX Initialization and Reset Ports --------------------
    .gt3_gttxreset_in          (tx_rst_gt_data_sync),
    .gt3_txuserrdy_in          (1'b1),
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .gt3_txusrclk_in           (tx_core_clk),
    .gt3_txusrclk2_in          (tx_core_clk),
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
    .gt3_txprbsforceerr_in     (gt3_txprbsforceerr_in),
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    .gt3_txbufstatus_out       (gt3_txbufstatus_out),
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    .gt3_txdiffctrl_in         (gt3_txdiffctrl_in),
    .gt3_txinhibit_in          (gt3_txinhibit_in),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .gt3_txdata_in             (gt3_txdata),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .gt3_gtxtxn_out            (txn_out[3]),
    .gt3_gtxtxp_out            (txp_out[3]),
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    .gt3_txoutclk_out          (txoutclk_bus[3]),
    .gt3_txoutclkfabric_out    (),
    .gt3_txoutclkpcs_out       (),
    //------------------- Transmit Ports - TX Gearbox Ports --------------------
    .gt3_txcharisk_in          (gt3_txcharisk),
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    .gt3_txpcsreset_in         (gt3_txpcsreset_in),
    .gt3_txpmareset_in         (gt3_txpmareset_in),
    .gt3_txresetdone_out       (gt3_txresetdone_i),
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    .gt3_txpolarity_in         (gt3_txpolarity_in),
    //---------------- Transmit Ports - pattern Generator Ports ----------------
    .gt3_txprbssel_in          (gt_prbssel),

    //_________________________________________________________________________
    //GT4
    //____________________________CHANNEL PORTS________________________________
    .gt4_data_valid_in         (1'b1),
    //------------------------------- CPLL Ports -------------------------------
    .gt4_cpllfbclklost_out     (),
    .gt4_cplllock_out          (gt4_cplllock_i),
    .gt4_cplllockdetclk_in     (1'b0),
    .gt4_cpllpd_in             (cpllpd_i[4]),
    .gt4_cpllreset_in          (1'b0),
    //------------------------ Channel - Clocking Ports ------------------------
    .gt4_gtnorthrefclk0_in     (1'b0),
    .gt4_gtnorthrefclk1_in     (1'b0),
    .gt4_gtrefclk0_in          (cpll_refclk),
    .gt4_gtrefclk1_in          (1'b0),
    .gt4_gtsouthrefclk0_in     (1'b0),
    .gt4_gtsouthrefclk1_in     (1'b0),
    //-------------------------- Channel - DRP Ports  --------------------------
    .gt4_drpaddr_in            (gt4_drpaddr),
    .gt4_drpclk_in             (drpclk),
    .gt4_drpdi_in              (gt4_drpdi),
    .gt4_drpdo_out             (gt4_drpdo),
    .gt4_drpen_in              (gt4_drpen),
    .gt4_drprdy_out            (gt4_drprdy),
    .gt4_drpwe_in              (gt4_drpwe),
    //----------------------------- Clocking Ports -----------------------------
    .gt4_rxsysclksel_in        (gt4_rxsysclksel_i),
    .gt4_txsysclksel_in        (gt4_txsysclksel_i),
    //------------------------- Digital Monitor Ports --------------------------
    .gt4_dmonitorout_out       (gt4_dmonitorout_out),
    //----------------------------- Loopback Ports -----------------------------
    .gt4_loopback_in           (gt4_loopback_in),
    //---------------------------- Power-Down Ports ----------------------------
    .gt4_rxpd_in               (gt4_rxpd_in),
    .gt4_txpd_in               (gt4_txpd_in),
    //------------------- RX Initialization and Reset Ports --------------------
    .gt4_eyescanreset_in       (gt4_eyescanreset_in),
    .gt4_rxuserrdy_in          (1'b1),
    //------------------------ RX Margin Analysis Ports ------------------------
    .gt4_eyescandataerror_out  (gt4_eyescandataerror_out),
    .gt4_eyescantrigger_in     (gt4_eyescantrigger_in),
    //----------------------- Receive Ports - CDR Ports ------------------------
    .gt4_rxcdrhold_in          (gt4_rxcdrhold_in),
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    .gt4_rxusrclk_in           (rx_core_clk),
    .gt4_rxusrclk2_in          (rx_core_clk),
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .gt4_rxdata_out            (gt4_rxdata),
    //----------------- Receive Ports - Pattern Checker Ports ------------------
    .gt4_rxprbserr_out         (gt4_rxprbserr_out),
    .gt4_rxprbssel_in          (gt4_rxprbssel_in),
    //----------------- Receive Ports - Pattern Checker ports ------------------
    .gt4_rxprbscntreset_in     (gt4_rxprbscntreset_in),
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    .gt4_rxdisperr_out         (gt4_rxdisperr),
    .gt4_rxnotintable_out      (gt4_rxnotintable),
    //------------------------- Receive Ports - RX AFE -------------------------
    .gt4_gtxrxp_in             (rxp_in[4]),
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .gt4_gtxrxn_in             (rxn_in[4]),
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    .gt4_rxbufreset_in         (gt4_rxbufreset_in),
    .gt4_rxbufstatus_out       (gt4_rxbufstatus_out),
    .gt4_rxstatus_out          (gt4_rxstatus_out),
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    .gt4_rxbyteisaligned_out   (gt4_rxbyteisaligned_out),
    .gt4_rxbyterealign_out     (gt4_rxbyterealign_out),
    .gt4_rxcommadet_out        (gt4_rxcommadet_out),
    .gt4_rxmcommaalignen_in    (rxencommaalign),
    .gt4_rxpcommaalignen_in    (rxencommaalign),
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    .gt4_rxdfelpmreset_in      (gt4_rxdfelpmreset_in),
    .gt4_rxmonitorout_out      (gt4_rxmonitorout_out),
    .gt4_rxmonitorsel_in       (gt4_rxmonitorsel_in),
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    .gt4_rxoutclk_out          (rxoutclk_bus[4]),
    .gt4_rxoutclkfabric_out    (),
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    .gt4_gtrxreset_in          (rx_rst_gt_data_sync),
    .gt4_rxpcsreset_in         (gt4_rxpcsreset_in),
    .gt4_rxpmareset_in         (gt4_rxpmareset_in),
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    .gt4_rxlpmen_in            (gt4_rxlpmen_in),
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    .gt4_rxpolarity_in         (gt4_rxpolarity_in),
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    .gt4_rxchariscomma_out     (),
    .gt4_rxcharisk_out         (gt4_rxcharisk),
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .gt4_rxresetdone_out       (gt4_rxresetdone_i),
    //---------------------- TX Configurable Driver Ports ----------------------
    .gt4_txpostcursor_in       (gt4_txpostcursor_in),
    .gt4_txprecursor_in        (gt4_txprecursor_in),
    //------------------- TX Initialization and Reset Ports --------------------
    .gt4_gttxreset_in          (tx_rst_gt_data_sync),
    .gt4_txuserrdy_in          (1'b1),
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .gt4_txusrclk_in           (tx_core_clk),
    .gt4_txusrclk2_in          (tx_core_clk),
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
    .gt4_txprbsforceerr_in     (gt4_txprbsforceerr_in),
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    .gt4_txbufstatus_out       (gt4_txbufstatus_out),
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    .gt4_txdiffctrl_in         (gt4_txdiffctrl_in),
    .gt4_txinhibit_in          (gt4_txinhibit_in),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .gt4_txdata_in             (gt4_txdata),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .gt4_gtxtxn_out            (txn_out[4]),
    .gt4_gtxtxp_out            (txp_out[4]),
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    .gt4_txoutclk_out          (txoutclk_bus[4]),
    .gt4_txoutclkfabric_out    (),
    .gt4_txoutclkpcs_out       (),
    //------------------- Transmit Ports - TX Gearbox Ports --------------------
    .gt4_txcharisk_in          (gt4_txcharisk),
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    .gt4_txpcsreset_in         (gt4_txpcsreset_in),
    .gt4_txpmareset_in         (gt4_txpmareset_in),
    .gt4_txresetdone_out       (gt4_txresetdone_i),
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    .gt4_txpolarity_in         (gt4_txpolarity_in),
    //---------------- Transmit Ports - pattern Generator Ports ----------------
    .gt4_txprbssel_in          (gt_prbssel),

    //GT5
    //____________________________CHANNEL PORTS________________________________
    .gt5_data_valid_in         (1'b1),
    //------------------------------- CPLL Ports -------------------------------
    .gt5_cpllfbclklost_out     (),
    .gt5_cplllock_out          (gt5_cplllock_i),
    .gt5_cplllockdetclk_in     (1'b0),
    .gt5_cpllpd_in             (cpllpd_i[5]),
    .gt5_cpllreset_in          (1'b0),
    //------------------------ Channel - Clocking Ports ------------------------
    .gt5_gtnorthrefclk0_in     (1'b0),
    .gt5_gtnorthrefclk1_in     (1'b0),
    .gt5_gtrefclk0_in          (cpll_refclk),
    .gt5_gtrefclk1_in          (1'b0),
    .gt5_gtsouthrefclk0_in     (1'b0),
    .gt5_gtsouthrefclk1_in     (1'b0),
    //-------------------------- Channel - DRP Ports  --------------------------
    .gt5_drpaddr_in            (gt5_drpaddr),
    .gt5_drpclk_in             (drpclk),
    .gt5_drpdi_in              (gt5_drpdi),
    .gt5_drpdo_out             (gt5_drpdo),
    .gt5_drpen_in              (gt5_drpen),
    .gt5_drprdy_out            (gt5_drprdy),
    .gt5_drpwe_in              (gt5_drpwe),
    //----------------------------- Clocking Ports -----------------------------
    .gt5_rxsysclksel_in        (gt5_rxsysclksel_i),
    .gt5_txsysclksel_in        (gt5_txsysclksel_i),
    //------------------------- Digital Monitor Ports --------------------------
    .gt5_dmonitorout_out       (gt5_dmonitorout_out),
    //----------------------------- Loopback Ports -----------------------------
    .gt5_loopback_in           (gt5_loopback_in),
    //---------------------------- Power-Down Ports ----------------------------
    .gt5_rxpd_in               (gt5_rxpd_in),
    .gt5_txpd_in               (gt5_txpd_in),
    //------------------- RX Initialization and Reset Ports --------------------
    .gt5_eyescanreset_in       (gt5_eyescanreset_in),
    .gt5_rxuserrdy_in          (1'b1),
    //------------------------ RX Margin Analysis Ports ------------------------
    .gt5_eyescandataerror_out  (gt5_eyescandataerror_out),
    .gt5_eyescantrigger_in     (gt5_eyescantrigger_in),
    //----------------------- Receive Ports - CDR Ports ------------------------
    .gt5_rxcdrhold_in          (gt5_rxcdrhold_in),
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    .gt5_rxusrclk_in           (rx_core_clk),
    .gt5_rxusrclk2_in          (rx_core_clk),
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .gt5_rxdata_out            (gt5_rxdata),
    //----------------- Receive Ports - Pattern Checker Ports ------------------
    .gt5_rxprbserr_out         (gt5_rxprbserr_out),
    .gt5_rxprbssel_in          (gt5_rxprbssel_in),
    //----------------- Receive Ports - Pattern Checker ports ------------------
    .gt5_rxprbscntreset_in     (gt5_rxprbscntreset_in),
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    .gt5_rxdisperr_out         (gt5_rxdisperr),
    .gt5_rxnotintable_out      (gt5_rxnotintable),
    //------------------------- Receive Ports - RX AFE -------------------------
    .gt5_gtxrxp_in             (rxp_in[5]),
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .gt5_gtxrxn_in             (rxn_in[5]),
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    .gt5_rxbufreset_in         (gt5_rxbufreset_in),
    .gt5_rxbufstatus_out       (gt5_rxbufstatus_out),
    .gt5_rxstatus_out          (gt5_rxstatus_out),
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    .gt5_rxbyteisaligned_out   (gt5_rxbyteisaligned_out),
    .gt5_rxbyterealign_out     (gt5_rxbyterealign_out),
    .gt5_rxcommadet_out        (gt5_rxcommadet_out),
    .gt5_rxmcommaalignen_in    (rxencommaalign),
    .gt5_rxpcommaalignen_in    (rxencommaalign),
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    .gt5_rxdfelpmreset_in      (gt5_rxdfelpmreset_in),
    .gt5_rxmonitorout_out      (gt5_rxmonitorout_out),
    .gt5_rxmonitorsel_in       (gt5_rxmonitorsel_in),
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    .gt5_rxoutclk_out          (rxoutclk_bus[5]),
    .gt5_rxoutclkfabric_out    (),
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    .gt5_gtrxreset_in          (rx_rst_gt_data_sync),
    .gt5_rxpcsreset_in         (gt5_rxpcsreset_in),
    .gt5_rxpmareset_in         (gt5_rxpmareset_in),
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    .gt5_rxlpmen_in            (gt5_rxlpmen_in),
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    .gt5_rxpolarity_in         (gt5_rxpolarity_in),
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    .gt5_rxchariscomma_out     (),
    .gt5_rxcharisk_out         (gt5_rxcharisk),
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .gt5_rxresetdone_out       (gt5_rxresetdone_i),
    //---------------------- TX Configurable Driver Ports ----------------------
    .gt5_txpostcursor_in       (gt5_txpostcursor_in),
    .gt5_txprecursor_in        (gt5_txprecursor_in),
    //------------------- TX Initialization and Reset Ports --------------------
    .gt5_gttxreset_in          (tx_rst_gt_data_sync),
    .gt5_txuserrdy_in          (1'b1),
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .gt5_txusrclk_in           (tx_core_clk),
    .gt5_txusrclk2_in          (tx_core_clk),
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
    .gt5_txprbsforceerr_in     (gt5_txprbsforceerr_in),
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    .gt5_txbufstatus_out       (gt5_txbufstatus_out),
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    .gt5_txdiffctrl_in         (gt5_txdiffctrl_in),
    .gt5_txinhibit_in          (gt5_txinhibit_in),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .gt5_txdata_in             (gt5_txdata),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .gt5_gtxtxn_out            (txn_out[5]),
    .gt5_gtxtxp_out            (txp_out[5]),
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    .gt5_txoutclk_out          (txoutclk_bus[5]),
    .gt5_txoutclkfabric_out    (),
    .gt5_txoutclkpcs_out       (),
    //------------------- Transmit Ports - TX Gearbox Ports --------------------
    .gt5_txcharisk_in          (gt5_txcharisk),
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    .gt5_txpcsreset_in         (gt5_txpcsreset_in),
    .gt5_txpmareset_in         (gt5_txpmareset_in),
    .gt5_txresetdone_out       (gt5_txresetdone_i),
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    .gt5_txpolarity_in         (gt5_txpolarity_in),
    //---------------- Transmit Ports - pattern Generator Ports ----------------
    .gt5_txprbssel_in          (gt_prbssel),

    //GT6
    //____________________________CHANNEL PORTS________________________________
    .gt6_data_valid_in         (1'b1),
    //------------------------------- CPLL Ports -------------------------------
    .gt6_cpllfbclklost_out     (),
    .gt6_cplllock_out          (gt6_cplllock_i),
    .gt6_cplllockdetclk_in     (1'b0),
    .gt6_cpllpd_in             (cpllpd_i[6]),
    .gt6_cpllreset_in          (1'b0),
    //------------------------ Channel - Clocking Ports ------------------------
    .gt6_gtnorthrefclk0_in     (1'b0),
    .gt6_gtnorthrefclk1_in     (1'b0),
    .gt6_gtrefclk0_in          (cpll_refclk),
    .gt6_gtrefclk1_in          (1'b0),
    .gt6_gtsouthrefclk0_in     (1'b0),
    .gt6_gtsouthrefclk1_in     (1'b0),
    //-------------------------- Channel - DRP Ports  --------------------------
    .gt6_drpaddr_in            (gt6_drpaddr),
    .gt6_drpclk_in             (drpclk),
    .gt6_drpdi_in              (gt6_drpdi),
    .gt6_drpdo_out             (gt6_drpdo),
    .gt6_drpen_in              (gt6_drpen),
    .gt6_drprdy_out            (gt6_drprdy),
    .gt6_drpwe_in              (gt6_drpwe),
    //----------------------------- Clocking Ports -----------------------------
    .gt6_rxsysclksel_in        (gt6_rxsysclksel_i),
    .gt6_txsysclksel_in        (gt6_txsysclksel_i),
    //------------------------- Digital Monitor Ports --------------------------
    .gt6_dmonitorout_out       (gt6_dmonitorout_out),
    //----------------------------- Loopback Ports -----------------------------
    .gt6_loopback_in           (gt6_loopback_in),
    //---------------------------- Power-Down Ports ----------------------------
    .gt6_rxpd_in               (gt6_rxpd_in),
    .gt6_txpd_in               (gt6_txpd_in),
    //------------------- RX Initialization and Reset Ports --------------------
    .gt6_eyescanreset_in       (gt6_eyescanreset_in),
    .gt6_rxuserrdy_in          (1'b1),
    //------------------------ RX Margin Analysis Ports ------------------------
    .gt6_eyescandataerror_out  (gt6_eyescandataerror_out),
    .gt6_eyescantrigger_in     (gt6_eyescantrigger_in),
    //----------------------- Receive Ports - CDR Ports ------------------------
    .gt6_rxcdrhold_in          (gt6_rxcdrhold_in),
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    .gt6_rxusrclk_in           (rx_core_clk),
    .gt6_rxusrclk2_in          (rx_core_clk),
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .gt6_rxdata_out            (gt6_rxdata),
    //----------------- Receive Ports - Pattern Checker Ports ------------------
    .gt6_rxprbserr_out         (gt6_rxprbserr_out),
    .gt6_rxprbssel_in          (gt6_rxprbssel_in),
    //----------------- Receive Ports - Pattern Checker ports ------------------
    .gt6_rxprbscntreset_in     (gt6_rxprbscntreset_in),
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    .gt6_rxdisperr_out         (gt6_rxdisperr),
    .gt6_rxnotintable_out      (gt6_rxnotintable),
    //------------------------- Receive Ports - RX AFE -------------------------
    .gt6_gtxrxp_in             (rxp_in[6]),
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .gt6_gtxrxn_in             (rxn_in[6]),
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    .gt6_rxbufreset_in         (gt6_rxbufreset_in),
    .gt6_rxbufstatus_out       (gt6_rxbufstatus_out),
    .gt6_rxstatus_out          (gt6_rxstatus_out),
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    .gt6_rxbyteisaligned_out   (gt6_rxbyteisaligned_out),
    .gt6_rxbyterealign_out     (gt6_rxbyterealign_out),
    .gt6_rxcommadet_out        (gt6_rxcommadet_out),
    .gt6_rxmcommaalignen_in    (rxencommaalign),
    .gt6_rxpcommaalignen_in    (rxencommaalign),
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    .gt6_rxdfelpmreset_in      (gt6_rxdfelpmreset_in),
    .gt6_rxmonitorout_out      (gt6_rxmonitorout_out),
    .gt6_rxmonitorsel_in       (gt6_rxmonitorsel_in),
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    .gt6_rxoutclk_out          (rxoutclk_bus[6]),
    .gt6_rxoutclkfabric_out    (),
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    .gt6_gtrxreset_in          (rx_rst_gt_data_sync),
    .gt6_rxpcsreset_in         (gt6_rxpcsreset_in),
    .gt6_rxpmareset_in         (gt6_rxpmareset_in),
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    .gt6_rxlpmen_in            (gt6_rxlpmen_in),
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    .gt6_rxpolarity_in         (gt6_rxpolarity_in),
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    .gt6_rxchariscomma_out     (),
    .gt6_rxcharisk_out         (gt6_rxcharisk),
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .gt6_rxresetdone_out       (gt6_rxresetdone_i),
    //---------------------- TX Configurable Driver Ports ----------------------
    .gt6_txpostcursor_in       (gt6_txpostcursor_in),
    .gt6_txprecursor_in        (gt6_txprecursor_in),
    //------------------- TX Initialization and Reset Ports --------------------
    .gt6_gttxreset_in          (tx_rst_gt_data_sync),
    .gt6_txuserrdy_in          (1'b1),
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .gt6_txusrclk_in           (tx_core_clk),
    .gt6_txusrclk2_in          (tx_core_clk),
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
    .gt6_txprbsforceerr_in     (gt6_txprbsforceerr_in),
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    .gt6_txbufstatus_out       (gt6_txbufstatus_out),
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    .gt6_txdiffctrl_in         (gt6_txdiffctrl_in),
    .gt6_txinhibit_in          (gt6_txinhibit_in),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .gt6_txdata_in             (gt6_txdata),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .gt6_gtxtxn_out            (txn_out[6]),
    .gt6_gtxtxp_out            (txp_out[6]),
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    .gt6_txoutclk_out          (txoutclk_bus[6]),
    .gt6_txoutclkfabric_out    (),
    .gt6_txoutclkpcs_out       (),
    //------------------- Transmit Ports - TX Gearbox Ports --------------------
    .gt6_txcharisk_in          (gt6_txcharisk),
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    .gt6_txpcsreset_in         (gt6_txpcsreset_in),
    .gt6_txpmareset_in         (gt6_txpmareset_in),
    .gt6_txresetdone_out       (gt6_txresetdone_i),
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    .gt6_txpolarity_in         (gt6_txpolarity_in),
    //---------------- Transmit Ports - pattern Generator Ports ----------------
    .gt6_txprbssel_in          (gt_prbssel),

    //GT7
    //____________________________CHANNEL PORTS________________________________
    .gt7_data_valid_in         (1'b1),
    //------------------------------- CPLL Ports -------------------------------
    .gt7_cpllfbclklost_out     (),
    .gt7_cplllock_out          (gt7_cplllock_i),
    .gt7_cplllockdetclk_in     (1'b0),
    .gt7_cpllpd_in             (cpllpd_i[7]),
    .gt7_cpllreset_in          (1'b0),
    //------------------------ Channel - Clocking Ports ------------------------
    .gt7_gtnorthrefclk0_in     (1'b0),
    .gt7_gtnorthrefclk1_in     (1'b0),
    .gt7_gtrefclk0_in          (cpll_refclk),
    .gt7_gtrefclk1_in          (1'b0),
    .gt7_gtsouthrefclk0_in     (1'b0),
    .gt7_gtsouthrefclk1_in     (1'b0),
    //-------------------------- Channel - DRP Ports  --------------------------
    .gt7_drpaddr_in            (gt7_drpaddr),
    .gt7_drpclk_in             (drpclk),
    .gt7_drpdi_in              (gt7_drpdi),
    .gt7_drpdo_out             (gt7_drpdo),
    .gt7_drpen_in              (gt7_drpen),
    .gt7_drprdy_out            (gt7_drprdy),
    .gt7_drpwe_in              (gt7_drpwe),
    //----------------------------- Clocking Ports -----------------------------
    .gt7_rxsysclksel_in        (gt7_rxsysclksel_i),
    .gt7_txsysclksel_in        (gt7_txsysclksel_i),
    //------------------------- Digital Monitor Ports --------------------------
    .gt7_dmonitorout_out       (gt7_dmonitorout_out),
    //----------------------------- Loopback Ports -----------------------------
    .gt7_loopback_in           (gt7_loopback_in),
    //---------------------------- Power-Down Ports ----------------------------
    .gt7_rxpd_in               (gt7_rxpd_in),
    .gt7_txpd_in               (gt7_txpd_in),
    //------------------- RX Initialization and Reset Ports --------------------
    .gt7_eyescanreset_in       (gt7_eyescanreset_in),
    .gt7_rxuserrdy_in          (1'b1),
    //------------------------ RX Margin Analysis Ports ------------------------
    .gt7_eyescandataerror_out  (gt7_eyescandataerror_out),
    .gt7_eyescantrigger_in     (gt7_eyescantrigger_in),
    //----------------------- Receive Ports - CDR Ports ------------------------
    .gt7_rxcdrhold_in          (gt7_rxcdrhold_in),
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    .gt7_rxusrclk_in           (rx_core_clk),
    .gt7_rxusrclk2_in          (rx_core_clk),
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .gt7_rxdata_out            (gt7_rxdata),
    //----------------- Receive Ports - Pattern Checker Ports ------------------
    .gt7_rxprbserr_out         (gt7_rxprbserr_out),
    .gt7_rxprbssel_in          (gt7_rxprbssel_in),
    //----------------- Receive Ports - Pattern Checker ports ------------------
    .gt7_rxprbscntreset_in     (gt7_rxprbscntreset_in),
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    .gt7_rxdisperr_out         (gt7_rxdisperr),
    .gt7_rxnotintable_out      (gt7_rxnotintable),
    //------------------------- Receive Ports - RX AFE -------------------------
    .gt7_gtxrxp_in             (rxp_in[7]),
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .gt7_gtxrxn_in             (rxn_in[7]),
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    .gt7_rxbufreset_in         (gt7_rxbufreset_in),
    .gt7_rxbufstatus_out       (gt7_rxbufstatus_out),
    .gt7_rxstatus_out          (gt7_rxstatus_out),
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    .gt7_rxbyteisaligned_out   (gt7_rxbyteisaligned_out),
    .gt7_rxbyterealign_out     (gt7_rxbyterealign_out),
    .gt7_rxcommadet_out        (gt7_rxcommadet_out),
    .gt7_rxmcommaalignen_in    (rxencommaalign),
    .gt7_rxpcommaalignen_in    (rxencommaalign),
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    .gt7_rxdfelpmreset_in      (gt7_rxdfelpmreset_in),
    .gt7_rxmonitorout_out      (gt7_rxmonitorout_out),
    .gt7_rxmonitorsel_in       (gt7_rxmonitorsel_in),
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    .gt7_rxoutclk_out          (rxoutclk_bus[7]),
    .gt7_rxoutclkfabric_out    (),
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    .gt7_gtrxreset_in          (rx_rst_gt_data_sync),
    .gt7_rxpcsreset_in         (gt7_rxpcsreset_in),
    .gt7_rxpmareset_in         (gt7_rxpmareset_in),
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    .gt7_rxlpmen_in            (gt7_rxlpmen_in),
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    .gt7_rxpolarity_in         (gt7_rxpolarity_in),
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    .gt7_rxchariscomma_out     (),
    .gt7_rxcharisk_out         (gt7_rxcharisk),
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .gt7_rxresetdone_out       (gt7_rxresetdone_i),
    //---------------------- TX Configurable Driver Ports ----------------------
    .gt7_txpostcursor_in       (gt7_txpostcursor_in),
    .gt7_txprecursor_in        (gt7_txprecursor_in),
    //------------------- TX Initialization and Reset Ports --------------------
    .gt7_gttxreset_in          (tx_rst_gt_data_sync),
    .gt7_txuserrdy_in          (1'b1),
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .gt7_txusrclk_in           (tx_core_clk),
    .gt7_txusrclk2_in          (tx_core_clk),
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
    .gt7_txprbsforceerr_in     (gt7_txprbsforceerr_in),
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    .gt7_txbufstatus_out       (gt7_txbufstatus_out),
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    .gt7_txdiffctrl_in         (gt7_txdiffctrl_in),
    .gt7_txinhibit_in          (gt7_txinhibit_in),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .gt7_txdata_in             (gt7_txdata),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .gt7_gtxtxn_out            (txn_out[7]),
    .gt7_gtxtxp_out            (txp_out[7]),
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    .gt7_txoutclk_out          (txoutclk_bus[7]),
    .gt7_txoutclkfabric_out    (),
    .gt7_txoutclkpcs_out       (),
    //------------------- Transmit Ports - TX Gearbox Ports --------------------
    .gt7_txcharisk_in          (gt7_txcharisk),
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    .gt7_txpcsreset_in         (gt7_txpcsreset_in),
    .gt7_txpmareset_in         (gt7_txpmareset_in),
    .gt7_txresetdone_out       (gt7_txresetdone_i),
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    .gt7_txpolarity_in         (gt7_txpolarity_in),
    //---------------- Transmit Ports - pattern Generator Ports ----------------
    .gt7_txprbssel_in          (gt_prbssel),

    //____________________________COMMON PORTS________________________________
    .gt1_qplloutclk_in         (common1_qpll_clk_in),
    .gt1_qplloutrefclk_in      (common1_qpll_refclk_in),
    .gt0_qplloutclk_in         (common0_qpll_clk_in),
    .gt0_qplloutrefclk_in      (common0_qpll_refclk_in)
);

  assign txoutclk         = txoutclk_bus[0];
  assign rxoutclk         = rxoutclk_bus[0];

  assign gt0_cplllock_out = gt0_cplllock_i;
  assign gt1_cplllock_out = gt1_cplllock_i;
  assign gt2_cplllock_out = gt2_cplllock_i;
  assign gt3_cplllock_out = gt3_cplllock_i;
  assign gt4_cplllock_out = gt4_cplllock_i;
  assign gt5_cplllock_out = gt5_cplllock_i;
  assign gt6_cplllock_out = gt6_cplllock_i;
  assign gt7_cplllock_out = gt7_cplllock_i;

  assign cpll_lock = (gt0_cplllock_i && gt1_cplllock_i && gt2_cplllock_i && gt3_cplllock_i &&
                      gt4_cplllock_i && gt5_cplllock_i && gt6_cplllock_i && gt7_cplllock_i);
 
  always@(posedge drpclk)  
  begin
      rx_pll_lock_i <= cpll_lock;
      tx_pll_lock_i <= cpll_lock;      
  end

    
  //Clock domain crossing for pll lock
  jesd204_phy_dac_sync_block #(
    .TYPE (0)
  ) sync_tx_pll_lock 
  (
    .clk             (drpclk),
    .data_in         (tx_pll_lock_i),
    .data_out        (tx_pll_lock_sync)
  );

  assign tx_pll_lock = tx_pll_lock_sync;

  jesd204_phy_dac_sync_block #(
    .TYPE (0)
  ) sync_rx_pll_lock 
  (
    .clk             (drpclk),
    .data_in         (rx_pll_lock_i),
    .data_out        (rx_pll_lock_sync)
  );

  assign rx_pll_lock = rx_pll_lock_sync;

  assign gt0_txresetdone_out = gt0_txresetdone_i;
  assign gt0_rxresetdone_out = gt0_rxresetdone_i;

  assign gt1_txresetdone_out = gt1_txresetdone_i;
  assign gt1_rxresetdone_out = gt1_rxresetdone_i;

  assign gt2_txresetdone_out = gt2_txresetdone_i;
  assign gt2_rxresetdone_out = gt2_rxresetdone_i;

  assign gt3_txresetdone_out = gt3_txresetdone_i;
  assign gt3_rxresetdone_out = gt3_rxresetdone_i;

  assign gt4_txresetdone_out = gt4_txresetdone_i;
  assign gt4_rxresetdone_out = gt4_rxresetdone_i;

  assign gt5_txresetdone_out = gt5_txresetdone_i;
  assign gt5_rxresetdone_out = gt5_rxresetdone_i;

  assign gt6_txresetdone_out = gt6_txresetdone_i;
  assign gt6_rxresetdone_out = gt6_rxresetdone_i;

  assign gt7_txresetdone_out = gt7_txresetdone_i;
  assign gt7_rxresetdone_out = gt7_rxresetdone_i;


  assign tx_chan_rst_done     = (gt0_txresetdone_i && gt1_txresetdone_i && gt2_txresetdone_i && gt3_txresetdone_i && 
                                 gt4_txresetdone_i && gt5_txresetdone_i && gt6_txresetdone_i && gt7_txresetdone_i);
  assign rx_chan_rst_done     = (gt0_rxresetdone_i && gt1_rxresetdone_i && gt2_rxresetdone_i && gt3_rxresetdone_i && 
                                 gt4_rxresetdone_i && gt5_rxresetdone_i && gt6_rxresetdone_i && gt7_rxresetdone_i);

  always@(posedge tx_core_clk)
    tx_chan_rst_done_r <= tx_chan_rst_done;
    
  always@(posedge rx_core_clk)
    rx_chan_rst_done_r <= rx_chan_rst_done;

  jesd204_phy_dac_sync_block #(
    .TYPE (0)
  ) sync_tx_chan_rst_done 
  (
    .clk             (drpclk),
    .data_in         (tx_chan_rst_done_r),
    .data_out        (tx_chan_rst_done_sync)
  );

  jesd204_phy_dac_sync_block #(
    .TYPE (0)
  ) sync_rx_chan_rst_done 
  (
    .clk             (drpclk),
    .data_in         (rx_chan_rst_done_r),
    .data_out        (rx_chan_rst_done_sync)
  );    
  
  always@(posedge drpclk)
  begin 
    tx_reset_done_r <= gt_txfsmdone && tx_chan_rst_done_sync;
    rx_reset_done_r <= gt_rxfsmdone && rx_chan_rst_done_sync;
  end
    
  assign tx_reset_done = tx_reset_done_r;
  assign rx_reset_done = rx_reset_done_r;    
  
  // ******************************************************************************
  // Reset the GT when we lose PLL LOCK.
  always@(posedge drpclk)
  begin 
    if ((~tx_pll_lock && gt_txfsmdone) || tx_rst_all_sync)
      gt_txreset <= 1'b1;
    else
      gt_txreset <= 1'b0;
  end

  always@(posedge drpclk)
  begin 
    if ((~rx_pll_lock && gt_rxfsmdone) || rx_rst_all_sync)
      gt_rxreset <= 1'b1;
    else
      gt_rxreset <= 1'b0;
  end  

endmodule
