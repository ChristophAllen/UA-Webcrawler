class HomepageController < ApplicationController

	def index
    	require 'watir'
        @browser = Watir::Browser.new :chrome
        @browser.goto "https://vmh.selectlabsoft.com/login"

        Completedua.delete_all
        
		@browser.input(name: 'username').send_keys('') # user name has been taken out for security purposes
		@browser.input(name: 'password').send_keys('') # password has been taken out for security purposes
		
		@submit = @browser.button(id: "loginbutton")
		@submit.click	
		
        @h3s = @browser.h3s
    	@h3s[0].click

    	sleep 5

    	@browser.links(:text, "Patient Search").last.click

    	sleep 5

    	client_list = clients()
    	client_list.each do | key, value| 
    		# value[0] = id
    		# value[1] = name
    		sleep 5

    		@browser.goto "https://vmh.selectlabsoft.com/lis/#/obplabsrch"

    		sleep 5

	    	@browser.input(name: 'pid').send_keys(value[0])
	    	
	  		sleep 5
	    	
	    	@browser.trs.last.click #picking the client

	    	sleep 5

	    	@trs = @browser.trs
	    	@trs_length = @trs.length
	    	@subtractor = 1
	    	@placeholder = true
	    	@link_placeholder = @browser.url

	    	while @placeholder == true
	    		x = @trs[@trs_length - @subtractor]  #clicking last one then going backwards

	    			x.click  
	    			sleep 5
	    			@list_of_words = @browser.div(class: 'grid-100').text  #finding status
	    			@list_of_words = @list_of_words.split(" ")   #finding status
	    			@index_of_collected_date = @list_of_words.index('Collected:') + 1
	    			@last_collected_date = @list_of_words[@index_of_collected_date]
	    			@list_of_words.each do |x|   #finding status
	    				if x == "complete" || x == "ready"   #finding status
	    					@status = "last completed here"    #finding status
	    				end   #finding status
	    			end

					if @status == "last completed here" || @trs_length == @subtractor + 2
	    				@status = nil     # resetting status for next person
	    				@browser.back   
	    				sleep 5
	    				@correct_tr = @browser.trs[@trs_length - @subtractor].tds[1].text  #going back to get date
	    				Completedua.create('name' => value[1], 'client_id' => value[0], 'lastcompleted' => @last_collected_date, 'link' => @link_placeholder )
	    				@placeholder = false	# resetting placeholder value for next person
	    			else
	    				@browser.back
	    				sleep 5
	    				@trs = @browser.trs	
	    				@subtractor = @subtractor + 1
	    			end 
	    	end
	    end
    end


    def clients
    	# clients are organized in a hash here but has been taken out for HIPPA purposes while this code is on github
    end
   

end

	