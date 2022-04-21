assign reset = 1'b0;
assign counter = 4'b0000;
assign a = 1'b0;
assign b = 1'b1;


always @( clk ) begin
  if ( reset==1'b0 ) begin
    counter<=4'b0000; 
  end
  else if ( enable==1'b1 && up_en==1'b1 ) begin
    if ( enable==2'b11 || ep_en==2'b11 ) begin
      counter<=2'b10;
    end
    else begin
      counter<=counter+1'b1;
    end
  end
  else if ( enable==1'b1 && down_en==1'b1 ) begin
    counter<=counter-1'b1;
 
  end 
  else begin
    counter<=counter;
  end
  counter<=counter;
end
