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



always @( a or b ) begin
  if ( reset ) begin
    Q<=1'b0;
  end
  else if ( b<5 && c==5 ) begin
    Q<=2'b10;
  end
  else begin
    Q<=1'b1;
  end
end


always @( clk ) begin
  if ( reset==1'b0 ) begin
    count=0;
    writeptr=0;
    readptr=0;
  end
  if ( (buffer[readptr]==buffer[readptr+1]) && read_signal==1 ) begin
    equal_or_not=1'b1;
  end
  else begin
    equal_or_not=1'b0;
  end
  

  if ( data_in_valid==1'b1 && write_signal == 1'b1 ) begin
  if ( count==0 ) begin
    buffer[writeptr]=data_in;
    writeptr=(writeptr+1)%255;
    readptr=(readptr+1)%255;
    count=count+1;
  end
  else if ( count==255 ) begin
  writeptr=writeptr;
  readptr=readptr;
  count=count;
  end
  else begin
  buffer[writeptr]=data_in;
  writeptr=(writeptr+1)%255;
  count=count+1;
  end

  end
  if ( read_signal==1'b1 ) begin
  if ( count==0 ) begin
  readptr=0;
  writeptr=0;
  count=count;
  end
  else begin
  bufferoutput=buffer[readptr];
  count=count-1;
  readptr=(readptr+1)%255;
  end
  end

		
end


always @( data_clk ) begin
	
  if ( equal_or_not==0 ) begin
    if ( datacount==0 ) begin
      flag1<=0;
      buffer1<=8'b0000_0000;
      buffer2<=buffer1;
      buffer3<=buffer2;
      flag2<=flag1;
      flag3<=flag2;
    end 
    else if ( datacount==1 ) begin
      flag1<=1;
      buffer1<=buffer[readptr];
      buffer2<=buffer[readptr];
      buffer3<=buffer2;
      flag2<=1;
      flag3<=flag2;
    end 
    else begin
      flag1<=1;
      flag2<=1;
      flag3<=1;
      buffer1<=8'b00011011;
      buffer2<=datacount+1;
      buffer3<=buffer[readptr];
    end
  end

  else begin
    flag1<=0;
    buffer1<=8'b0000_0000;
    buffer2<=buffer1;
    buffer3<=buffer2;
    flag2<=flag1;
    flag3<=flag2; 
  end
end


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
    if ( enable==1'b1 ) begin
      if ( enable==2'b10 ) begin
        if ( up_en==1'b1 ) begin
          if ( enable==3'b110 ) begin
            if ( datacount==1 ) begin
              if ( reset==1'b1 ) begin
                counter<=counter+1;
              end
            end
          end
        end
      end
    end
  end
end


always @( clk ) begin
  if ( reset==1'b0 ) begin
    count=0;
    writeptr=0;
    readptr=0;
  end
  if ( (buffer[readptr]==buffer[readptr+1]) && read_signal==1 ) begin
    equal_or_not=1'b1;
  end
  else begin
    equal_or_not=1'b0;
  end
  
end

always @( c or b ) begin
  if ( datacount==0 ) begin
    flag1<=0;
     buffer1<=8'b0000_0000;
     buffer2<=buffer1;
     buffer3<=buffer2;
     flag2<=flag1;
     flag3<=flag2;
   end 
   else if ( datacount==1 ) begin
     flag1<=1;
     buffer1<=buffer[readptr];
     buffer2<=buffer[readptr];
     buffer3<=buffer2;
     flag2<=1;
   flag3<=flag2;
  end 
    else begin
      flag1<=1;
      flag2<=1;
      flag3<=1;
      buffer1<=8'b00011011;
      buffer2<=datacount+1;
    buffer3<=buffer[readptr];
  end
end