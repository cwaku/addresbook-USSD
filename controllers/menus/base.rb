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

      validate_user
      initialize_pages
    end

    def fetch_data
      @cache = Cache.fetch(@params).cache
      @data = JSON.parse(@cache).with_indifferent_access
    end

    def display_contatcs(user_number)
      user = User.find_by(phone: user_number)
      @contacts = Contact.where(user_id: user.id)

      store_data({ user_id: user.id })
      message = ''
      @contacts.each_with_index do |contact, index|
        message += <<~MSG
          #{index + 1}. Name: #{contact.firstname} #{contact.lastname} Phone: #{contact.phone}
        MSG
      end
      message
    end

    def display_suburbs
      fetch_data
      @suburbs = Suburb.where(city_id: @data[:city_id])
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
      fetch_data
      @cities = City.where(region_id: @data[:region_id])
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
      user = User.find_by(phone: @mobile_number) # active_status: true, del_status: false)
      info = {
        firstname: @data['first_name'],
        lastname: @data['last_name'],
        phone: @data['mobile_number'],
        suburb_id: @data['suburb_id'].to_i,
        user_id: user.id.to_i
      }

      # contact = Contact.find_by(phone
      # Find contact from database with mobile number where active is true and del is fasle

      # check menu function
      puts "Heeeeeeeeeey #{@data['menu_function']}"
      case @data['menu_function']
      when 'add_contact'
        # add contact
        Contact.create(info)
        #   @contact.save
      when 'edit_contact'
        contact = Contact.find_by(phone: @data['mobile_number'], active: true, del: false)
        # edit contact
        # @contact = Contact.find(@data['contact_id'])

        # Create a new contact and update active and del of previous contact
        new_contact = Contact.create(info)
        contact.update(active: false, del: true, new_contact_id: new_contact.id)
        # contact.update(active: false, del: true)
        # contact.update(active: false, del: true, new_contact_id: new_contact.id)
        # @contact.update(info)
      end
    end

    private

    def initialize_pages
      @page = @params[:page] || @tracker&.page
      # @pagination_page = @tracker&.pagination_page.to_i
      # @page = '1' if @page.nil?
      # @page = @page.to_i
    end

    def validate_user
      return if @mobile_number.nil?

      user = User.find_by(phone: @mobile_number)
      return unless user.nil?

      Session::Manager.end(
        @params.merge(display_message: 'You are not authorized to use this service')
      )
    end
  end
end
