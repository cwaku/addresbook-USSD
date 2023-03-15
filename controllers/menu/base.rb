# frozen_string_literal: true

module Menu
  class Base
    def initialize(params)
      @params = params
      initialize_pages
    end

    def display_main_menu(options = {})
      # TODO: Add logic to display main menu
    end

    def display_page(options)
      # TODO: Add logic to display page
    end

    private

    def initialize_pages
      @page = @params[:page]
      @page = 1 if @page.nil?
      # @page = @page.to_i
    end
  end
end
