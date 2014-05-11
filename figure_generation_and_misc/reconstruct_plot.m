function [ img_proj ] = reconstruct_plot( pca, image )
new_image = zeros(480*640,1);
img_idx =1;
img_proj = (image-pca.mat_pos0.mean)'*pca.mat_pos0.pc;

while(img_idx<=20)
    subplot(5,4,img_idx);
    eig = img_proj(img_idx).*pca.mat_pos0.pc(:,img_idx);%*pca.mat_pos0.var_pc(img_idx);
    new_image = new_image+eig;
    imshow(uint8(vec2mat(new_image+pca.mat_pos0.mean,640)));
    img_idx=img_idx+1;    
end



end

