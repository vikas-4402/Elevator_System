module elevator (output reg [1:0]state,output [1:0] motor,input [3:0] button, input [1:0] floor,input reset,timer);
  assign motor = state;
  parameter rest=2'b00, up=2'b01, down=2'b10, waiting=2'b11;
  always@(state,floor,button,reset,timer)
  if(!reset)
    state<=rest;
  else case(state)
  rest: begin
    if(floor==2'b00&&button!=4'b0000) begin
       if (button>=4'b0010) state<=up;
     end
     if(floor==2'b01&&button!=4'b0000) begin
       if (button>=4'b0100) state<=up;
       else if (button==4'b0000) state<=down;
     end
     if(floor==2'b10&&button!=4'b0000) begin
       if (button>=4'b0100) state<=up;
       else if (button<4'b0010) state<=down;
     end
     if(floor==2'b11&&button!=4'b0000) begin
       if (button<4'b1000) state<=down;
     end
   end

   up: begin
      if (floor==2'b00&&(button&4'b0001)) state<=waiting;
      else if (floor==2'b01&&(button&4'b0010)) state<=waiting;
      else if (floor==2'b10&&(button&4'b0100)) state<=waiting;
      else if (floor==2'b11&&(button&4'b1000)) state<=waiting;

   end

   down :begin 
      if (floor==2'b00&&(button&4'b0001)) state<=waiting;
      else if (floor==2'b01&&(button&4'b0010)) state<=waiting;
      else if (floor==2'b10&&(button&4'b0100)) state<=waiting;
      else if (floor==2'b11&&(button&4'b1000)) state<=waiting;
   end

  waiting: begin
    if(timer) state<=rest;   
/* assumes timer start when state goes to 11 and gives 1 afte a reasonable amoout of time
so people can leave lift and auto close

 or we can use it as input from gate if gate outputs 1 if gate is closed for manual gate with some modifications
  */
  end

  endcase
endmodule 
// handles button input and process it
module button (output reg [4:0] out, input button0,button1,button2,button3,reset, input [1:0] floor);
  always@(button0,reset)
    if(!reset) out=4'b0000;
    else if(button0&&floor!=2'b00) out<=out |4'b0001;

  always@(button1)
    if(button1&&floor!=2'b01) out<=out |4'b0010;

  always@(button2)
    if(button2&&floor!=2'b10) out<=out |4'b0100;

  always@(button3)
    if(button3&&floor!=2'b11) out<=out |4'b1000;
  always@(floor) 
    if (floor==2'b00) out<=out&4'b1110;
    else if (floor==2'b01) out<=out&4'b1101;
    else if (floor==2'b10) out<=out&4'b1011;
    else if (floor==2'b11) out<=out&4'b0111;


endmodule 