
// test bench for elevator
/*
module test;
reg [1:0]floor;
reg [3:0] button;
reg timer,reset;
wire [1:0] state,motor;

elevator m1(state,motor,button,floor,reset,timer);
initial begin
reset=1'b0;
#10 reset=1'b1;
floor=2'b00; timer=1'b0;
#10 button = 4'b0100; // 2nd floor button
#20 floor=2'b01;
#20 floor=2'b10;
#5 button=4'b0000;
#10 timer=1; 
end
endmodule */

// test bench for button

module test_button;
reg button0,button1,button2,button3,reset;
reg [1:0]floor;
wire [3:0] out;
button m2(out,button0,button1,button2,button3,reset,floor);
initial begin
reset=1'b0;
#10 reset=1'b1;
floor = 2'b10;
button0=1'b0;
button1=1'b0;
button2=1'b0;
button3=1'b0;
#10 button2=1'b1;
#5 button2=1'b0;
#20 button0=1'b1;
#5 button1=1'b0;
#20 button3 = 1'b1;
#5 button3 = 1'b0;

end
endmodule 
