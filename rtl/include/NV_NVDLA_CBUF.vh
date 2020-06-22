// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================

// File Name: NV_NVDLA_CBUF.vh
`define CBUF_BANK_NUMBER            NVDLA_CBUF_BANK_NUMBER
`define CBUF_BANK_DEPTH             NVDLA_CBUF_BANK_DEPTH
`define CBUF_ENTRY_WIDTH            NVDLA_CBUF_ENTRY_WIDTH
`define CBUF_ENTRY_BYTE             CBUF_ENTRY_WIDTH/8
`define CBUF_RAM_DEPTH              NVDLA_CBUF_BANK_DEPTH 
`define CBUF_BANK_DEPTH_BITS        NVDLA_CBUF_BANK_DEPTH_LOG2  //log2(bank_depth), how many bits need to give an address in BANK
`define CBUF_RD_DATA_SHIFT_WIDTH    NVDLA_CBUF_WIDTH_MUL2_LOG2  //log2(ram_width*2),width of data shift
`define CBUF_ADDR_WIDTH             NVDLA_CBUF_DEPTH_LOG2       //log2(bank_depth*bank_num)for both read and write
`define CBUF_RD_PORT_WIDTH          CBUF_ENTRY_WIDTH
`define CBUF_WR_PORT_NUMBER         2   //how many write ports.
`define CSC_IMAGE_MAX_STRIDE_BYTE   32  //=stride_max*channel_max*BPE, stride could be config max to 8, image channel to 4.         

`ifdef CBUF_BANK_RAM_CASE0
    `define CBUF_BANK_RAM_CASE          0
`elsif CBUF_BANK_RAM_CASE2
    `define CBUF_BANK_RAM_CASE          2
`elsif CBUF_BANK_RAM_CASE1
    `define CBUF_BANK_RAM_CASE          1
`elsif CBUF_BANK_RAM_CASE3
    `define CBUF_BANK_RAM_CASE          3
`elsif CBUF_BANK_RAM_CASE4
    `define CBUF_BANK_RAM_CASE          4
`endif


//ram case could be 0/1/2/3/4  0:1ram/bank; 1:1*2ram/bank; 2:2*1ram/bank; 3:2*2ram/bank  4:4*1ram/bank
`ifdef CBUF_BANK_RAM_CASE0
    `define CBUF_RAM_PER_BANK           1   
    `define CBUF_WR_BANK_SEL_WIDTH      1
    `define CBUF_RAM_WIDTH              NVDLA_CBUF_ENTRY_WIDTH  
    `define CBUF_RAM_DEPTH              NVDLA_CBUF_BANK_DEPTH 
    `define CBUF_RAM_DEPTH_BITS         CBUF_BANK_DEPTH_BITS
`elsif CBUF_BANK_RAM_CASE1
    `define CBUF_RAM_PER_BANK           2   
    `define CBUF_WR_BANK_SEL_WIDTH      2
    `define CBUF_RAM_WIDTH              NVDLA_CBUF_ENTRY_WIDTH/2
    `define CBUF_RAM_DEPTH              NVDLA_CBUF_BANK_DEPTH 
    `define CBUF_RAM_DEPTH_BITS         CBUF_BANK_DEPTH_BITS
`elsif CBUF_BANK_RAM_CASE2
    `define CBUF_RAM_PER_BANK           2   
    `define CBUF_WR_BANK_SEL_WIDTH      1
    `define CBUF_RAM_WIDTH              NVDLA_CBUF_ENTRY_WIDTH
    `define CBUF_RAM_DEPTH              NVDLA_CBUF_BANK_DEPTH/2 
    `define CBUF_RAM_DEPTH_BITS         CBUF_BANK_DEPTH_BITS-1
`elsif CBUF_BANK_RAM_CASE3
    `define CBUF_RAM_PER_BANK           4   
    `define CBUF_WR_BANK_SEL_WIDTH      2
    `define CBUF_RAM_WIDTH              NVDLA_CBUF_ENTRY_WIDTH/2
    `define CBUF_RAM_DEPTH              NVDLA_CBUF_BANK_DEPTH/2 
    `define CBUF_RAM_DEPTH_BITS         CBUF_BANK_DEPTH_BITS-1
`elsif CBUF_BANK_RAM_CASE4
    `define CBUF_RAM_PER_BANK           4   
    `define CBUF_WR_BANK_SEL_WIDTH      4
    `define CBUF_RAM_WIDTH              NVDLA_CBUF_ENTRY_WIDTH/4
    `define CBUF_RAM_DEPTH              NVDLA_CBUF_BANK_DEPTH 
    `define CBUF_RAM_DEPTH_BITS         CBUF_BANK_DEPTH_BITS
`endif

`define CBUF_WR_PORT_WIDTH          CBUF_RAM_WIDTH 

`ifdef CBUF_BANK_NUMBER_16
    `ifdef CBUF_BANK_DEPTH_512
        `define CBUF_BANK_SLICE             "12:9"  //address range for choosing a bank
    `elsif CBUF_BANK_DEPTH_128
        `define CBUF_BANK_SLICE             "10:7"  //address range for choosing a bank
    `endif
`elsif CBUF_BANK_NUMBER_32
    `ifdef CBUF_BANK_DEPTH_512
        `define CBUF_BANK_SLICE             "13:9"  //address range for choosing a bank
    `elsif CBUF_BANK_DEPTH_128
        `define CBUF_BANK_SLICE             "11:7"  //address range for choosing a bank
    `endif
`endif

`ifdef NVDLA_WEIGHT_COMPRESSION_ENABLE
    `define CBUF_WEIGHT_COMPRESSED    //whether need read WMB
`endif

`define CDMA2CBUF_DEBUG_PRINT  //open debug print
