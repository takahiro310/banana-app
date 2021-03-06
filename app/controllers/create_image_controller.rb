class CreateImageController < ApplicationController

    def exec

        question_text = params[:asfor][:question]
        answer_text = params[:asfor][:answer]

        if question_text.blank? || question_text.size > 12 ||
            answer_text.blank? || answer_text.size > 12
            # 兄さん、入力データ異常ですよ！
            render partial: 'ajax_error_partial'
            return
        end

        @asfor = nil
        if Asfor.exists?(question: question_text, answer: answer_text)
            logger.debug("EXISTS")
            @asfor = Asfor.find_by(question: question_text, answer: answer_text)
        else
            logger.debug("NOT EXISTS")
            # TODO Serviceクラスを作って移行したほうがスマート
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
            directory = ("a".."z").to_a.sample(2).join
            FileUtils.mkdir_p("#{Rails.root}/public/image/asfors/#{directory}", :mode => 755)
            new_img.write("#{Rails.root}/public/image/asfors/#{directory}/#{image_file}.png")
            new_img.destroy!

            # DBレコード生成だ！
            @asfor = Asfor.new
            @asfor.question = question_text
            @asfor.answer = answer_text
            @asfor.url_key = image_file

            @asfor.image = "/image/asfors/"
            @asfor.image << directory
            @asfor.image << "/"
            @asfor.image << image_file
            @asfor.image << ".png"
            
            unless @asfor.save
                # なんで書き込めなかったん・・・
                render partial: 'ajax_error_partial'
                return
            end
        end
        
        # シェア用のURLと生成した画像ファイル名を返答するよ
        results = { :url_key => @asfor.url_key, :image => @asfor.image }
        render partial: 'ajax_partial', locals: { :results => results }
    end

end
