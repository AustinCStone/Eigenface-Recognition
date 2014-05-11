function [] = display_images(db )
fields = fieldnames(db);
fld_idx = 1;
img_idx = 2;
disp_count = 1;
while(img_idx<=7)
while(fld_idx<=size(fields,1))
    if(fld_idx == 19)
        fld_idx=fld_idx+1;
    end
    if(disp_count<=36)
    subplot(6,6,disp_count);
    disp_count=disp_count+1;
    imshow(uint8(vec2mat(db.(fields{fld_idx})(:,img_idx),640)));
    end
  
    fld_idx=fld_idx+6;
end
fld_idx = 1;
img_idx = img_idx+1;
end


end

