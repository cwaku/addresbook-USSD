# frozen_string_literal: true

module Menu
  class Base
    def initialize(params)
      @params = params
      @tracker = params[:tracker]
      @activity_type = @params[:activity_type] || @tracker&.activity_type
      @menu_function = @params[:menu_function] || @tracker&.menu_function
      @ussd_body = @params[:ussd_body]
      @message_prepend = @params[:message_prepend].to_s
      @mobile_number = @params[:msisdn]
      @session_id = @params[:session_id]
      initialize_pages
    end

    def fetch_data
      @cache = Cache.fetch(@params).cache
      @data = JSON.parse(@cache).with_indifferent_access
    end

    def display_contatcs(user_number)
      @contacts = User.where(phone: user_number) # active: true, del: false)
      # store_data({ user_id:
      message = ''
      @contacts.each_with_index do |contact, index|
        message += <<~MSG
          #{index + 1}. First Name: #{contact.first_name} Last Name: #{contact.last_name} Phone: #{contact.mobile_number}
        MSG
      end
      message
    end

    def display_suburbs
      @suburbs = Suburb.all
      message = ''
      @suburbs.each_with_index do |suburb, index|
        message += <<~MSG
          #{index + 1}. #{suburb.name}
        MSG
      end
      message
    end

    def display_regions
      @regions = Region.all
      message = ''
      @regions.each_with_index do |region, index|
        message += <<~MSG
          #{index + 1}. #{region.name}
        MSG
      end
      message
    end

    def display_cities
      @suburbs = City.all
      message = ''
      @cities.each_with_index do |city, index|
        message += <<~MSG
          #{index + 1}. #{city.name}
        MSG
      end
      message
    end

    def store_data(new_data)
      fetch_data
      Cache.store(@params.merge(cache: @data.merge(new_data).to_json))
    end

    def self.process(params)
      new(params).process
    end

    def end_session(message = 'Service Unavailable. Please try again later')
      Session::Manager.end(
        @params.merge(display_message: message)
      )
    end

    def display_main_menu(options = {})
      # TODO: Add logic to display main menu
      @params[:page] = '1'
      Page::Main::First.process(@params.merge(options))
    end

    def display_page(options)
      # TODO: Add logic to display page
      # set tracker here
      params = @params.merge(options)

      # TODO: Add logic to check page for necessary routing and page display

      ActivityTracker.create({
                               mobile_number: @mobile_number,
                               ussd_body: params[:ussd_body],
                               session_id: params[:session_id],
                               menu_function: params[:menu_function],
                               page: params[:page],
                               activity_type: params[:activity_type],
                               message_type: params[:msg_type]
                             })

      Session::Manager.continue(@params.merge(display_message: display_message))
    end

    def save_info
      # save contact info here
      info = {
        first_name: @data['first_name'],
        last_name: @data['last_name'],
        mobile_number: @data['mobile_number'],
        user_number: @data['user_number']
      }

      # check menu function
      puts "Heeeeeeeeeey #{@data['menu_function']}"
      case @data['menu_function']
      when 'add_contact'
        # add contact
        Contact.create(info)
      #   @contact.save
      when 'edit_contact'
        # edit contact
        # @contact = Contact.find(@data['contact_id'])
        @contact.update(info)
      end
    end

    private

    def initialize_pages
      @page = @params[:page] || @tracker&.page
      # @pagination_page = @tracker&.pagination_page.to_i
      # @page = '1' if @page.nil?
      # @page = @page.to_i
    end
  end
end
