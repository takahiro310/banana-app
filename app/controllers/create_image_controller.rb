class CreateImageController < ApplicationController

    def exec

        question_text = params[:asfor][:question]
        answer_text = params[:asfor][:answer]

        if question_text.blank? || question_text.size > 12 ||
            answer_text.blank? || answer_text.size > 12
            # 入力データ異常デス
            render partial: 'ajax_error_partial'
            return
        end

        @asfor = nil
        if Asfor.exists?(question: question_text, answer: answer_text)
            logger.debug("EXISTS")
            @asfor = Asfor.find_by(question: question_text, answer: answer_text)
        else
            logger.debug("NOT EXISTS")

            # 画像ファイルを生成
            img = Magick::ImageList.new("#{Rails.root}/app/assets/image/frame.png")
            new_img = img.scale(600, 315)
            draw = Magick::Draw.new
            draw.annotate(new_img, 0, 0, 0, -80, question_text) do
                self.font      = "#{Rails.root}/app/assets/fonts/GenJyuuGothicX-Heavy.ttf"
                self.fill      = "black"
                self.stroke    = "transparent"
                self.pointsize = 40
                self.gravity   = Magick::CenterGravity
            end
              
            draw.annotate(new_img, 0, 0, 0, -40, "といったら...") do
                self.font      = "#{Rails.root}/app/assets/fonts/GenJyuuGothicX-Light.ttf"
                self.fill      = "black"
                self.stroke    = "transparent"
                self.pointsize = 40
                self.gravity   = Magick::CenterGravity
            end
              
            draw.annotate(new_img, 0, 0, 0, 30, answer_text) do
                self.font      = "#{Rails.root}/app/assets/fonts/GenJyuuGothicX-Heavy.ttf"
                self.fill      = "red"
                self.stroke    = "transparent"
                self.pointsize = 40
                self.gravity   = Magick::CenterGravity
            end
            
            image_file = SecureRandom.urlsafe_base64(8)
            new_img.write("#{Rails.root}/public/image/asfors/#{image_file}.png")
            new_img.destroy!

            # DBレコード生成
            @asfor = Asfor.new
            @asfor.question = question_text
            @asfor.answer = answer_text
            @asfor.url_key = image_file
            @asfor.image = "/image/asfors/" + image_file + ".png"
            unless @asfor.save
                # エラーコンテンツを返答
                render partial: 'ajax_error_partial'
                return
            end
        end
        
        # シェア用のURLと生成した画像ファイル名を返答する
        results = { :url_key => @asfor.url_key, :image => @asfor.image }
        render partial: 'ajax_partial', locals: { :results => results }
    end

end
