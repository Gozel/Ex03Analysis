
path = '/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Data';
extension = '*.avi';

files = dir(path);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
% Print folder names to command window.
for k = 3 : length(subFolders) - 1  % last folder is pilot study folder
                                    % and start at 3 to skip . folder and
                                    % .. folder
	fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
    
    files = dir(strcat(path,'/', subFolders(k).name));
    % Get a logical vector that tells which is a directory.
    subdirFlags = [files.isdir];
    subsubFolders = files(subdirFlags);
    
    % Print folder names to command window.
    for i = 3 : length(subsubFolders)
        fprintf('Sub sub folder #%d = %s\n', i, subsubFolders(i).name);
                
        files = dir(strcat(path, subFolders(k).name, '/', subsubFolders(i).name, '/', extension));
        
        % Get a logical vector that tells which is a directory.
        subsubdirFlags = [files.isdir];
        subsubsubFolders = files(subsubdirFlags);
        
        for j = 3 : length(subsubsubFolders)
            fprintf('Sub sub sub folder #%d = %s\n', j, subsubsubFolders(j).name);
            
            %gaze_extraction_vid(strcat(path, subFolders(k).name, '/', subsubFolders(i).name, '/'), subsubsubFolders(j).name);
        end
        %fileList = get_all_files(strcat(path, subFolders(k).name, subsubFolders(i).name));
    end
end