function [db] = load_image_db(image_db_path, angle_increment, angle_min, angle_max,reload, num_to_load, rows, columns, imgType)
%Takes as input path to database, loads the database or creates it if it
%has not already been created.

%image_db_path = path to image database
%angle_increment = the degree rotation of the faces
%angle_min = minimum angle (in this project it is -90)
%angle_max = maximum angle (in this project it is 90)

%save all the image matrices for the faces at different angles
%first determine if this has already been done
if(~reload)
    if(exist(sprintf('%sface_matrices.mat',image_db_path),'file'))
        fprintf('loading...');
        load(sprintf('%sface_matrices.mat',image_db_path));
    else
        reload = 1;
    end
end

if(reload)
    angle = angle_min;
    while(angle<=angle_max)
        
        if(angle>=0)
            img_dir = sprintf('%sangle+%d/',image_db_path,angle);
        else
            img_dir = sprintf('%sangle%d/',image_db_path,angle);
        end
        disp(img_dir);
        if(angle<0)
            angleStr=sprintf('neg%s',int2str(abs(angle)));
        else
            angleStr=sprintf('pos%s',int2str(angle));
        end
        db.(sprintf('mat_%s',angleStr))=get_img_mat(img_dir, num_to_load, rows, columns, imgType);
        angle = angle+angle_increment;
    end
    save(sprintf('%s/face_matrices.mat',image_db_path),'-v7.3');
end










end

