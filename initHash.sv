module initHash(input logic [1:0] t, output logic [127:0] outHash);
    always_comb begin
        case(t)
            2'd0: outHash = 128'h22312194FC2BF72C_9F555FA3C84C64C2;
            2'd1: outHash = 128'h2393B86B6F53B151_963877195940EABD;
            2'd2: outHash = 128'h96283EE2A88EFFE3_BE5E1E2553863992;
            2'd3: outHash = 128'h2B0199FC2C85B8AA_0EB72DDC81C52CA2;
            default: outHash = 128'd0;
        endcase
    end

endmodule
