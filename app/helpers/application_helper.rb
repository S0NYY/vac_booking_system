module ApplicationHelper
    include Pagy::Frontend


    def styled_date(current_date)
        current_date&.strftime("%Y-%m-%d %H:%M")
    end

    def downcase_helper(arg)
        arg.downcase
    end

end
