class ApplicationController < ActionController::Base
    def upload_image fileData
        if(fileData != nil)
            uploaded_io = fileData[:picture];
            fileName = File.basename(uploaded_io, File.extname(uploaded_io))+''+Time.now.strftime("%6N")+''+File.extname(uploaded_io);
            File.open(Rails.root.join('public', 'uploads', fileName), 'wb') do |file|
                file.write(uploaded_io.read)
                return fileName
            end
            return false
        end
    end
end
