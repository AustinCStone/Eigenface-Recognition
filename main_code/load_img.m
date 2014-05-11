function [Igray]=load_img(filename, pathname)
% load image
    fullFilename = [pathname filename];
    disp(fullFilename);
    % Get image info, read it accordingly
    info = imfinfo(fullFilename);
    if(strcmp('truecolor',info.ColorType))
        I = imread(fullFilename);
        Igray = (rgb2gray(I));
        clear I
    elseif(strcmp('grayscale',info.ColorType))
        Igray = (imread(fullFilename));
    elseif(strcmp('indexed',info.ColorType))
        [I,map] = imread(fullFilename);
        Igray = (ind2gray(I,map));
        clear I map
    else
        error('statPart:FormatImage','Image format error');
    end
    clear info
end
    