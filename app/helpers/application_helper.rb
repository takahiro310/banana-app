module ApplicationHelper
    def page_title
        title = "RENSOW -連想ゲーム-"
        title = @page_title + " | " + title if @page_title
        title
    end
end
