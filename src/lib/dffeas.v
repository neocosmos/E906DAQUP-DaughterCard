// Copyright (C) 1991-2011 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.
//////////////////////////////////////////////////////////////////////////////
// STRATIXIII dffeas atom for Formal Verification
///////////////////////////////////////////////////////////////////////////////

// MODEL BEGIN
module dffeas(
// INTERFACE BEGIN
	q , 
	clk, 
	ena , 
	prn, 
	clrn,  
	asdata, 
	aload, 
	sload, 
	sclr, 
	d,
	devpor,
	devclrn
// INTERFACE END
);

// GLOBAL PARAMETER DECLARATION
parameter power_up = "DONT_CARE";
parameter is_wysiwyg = "false";

// LOCAL PARAMETER DECLARATION
parameter x_on_violation = "on";
parameter lpm_type = "dffeas";

	output q;

	input clk; 
	input ena;
	input prn;
	input clrn;
	input asdata;
	input aload;
	input sload; 
	input sclr; 
	input d;

	input devpor;
	input devclrn;

	wire actual_d;
	wire arst_w;
	wire aset_w;
	wire inv_aclr;
	wire aclr; 	
	wire aset; 	

// IMPLEMENTATION_BEGIN
	assign actual_d = (sclr==1'b1) ? 1'b0 : ((sload==1'b1) ? asdata : d);

	assign aset_w = ~prn | (clrn & aload & asdata);
	assign arst_w = ~clrn | (clrn & aload & (~asdata));

	dffep lc_ff (q, clk, ena , actual_d , aset_w, arst_w);

// IMPLEMENTATION END
endmodule
// MODEL END
