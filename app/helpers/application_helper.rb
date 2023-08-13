module ApplicationHelper

    def title(page_title)
        content_for(:title) { page_title + " | ИРМ" }
    end

    def controllers_list
        (About.all.collect {|c| [c.title, about_path(c.page_title)]}).concat(Science.all.collect {|c| [c.title, science_path(c.page_title)]}).concat(Product.all.collect {|c| [c.title, product_path(c.page_title)]}).concat(Career.all.collect {|c| [c.title, career_path(c.page_title)]}).concat(Other.all.collect {|c| [c.title, other_path(c.page_title)]})
    end

end
