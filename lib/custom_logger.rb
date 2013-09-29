class CustomLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    timestamp = timestamp + Time.zone_offset('CST')
    nice = timestamp.strftime("%Y-%m-%d %I:%M:%S %p")
    "#{nice}: #{severity} - #{msg}\n"
  end
  	
 	# logfile = File.open(Rails.root + '/log/useful.log', 'a')  #create log file
	
 	logfile = File.open(Rails.root.join('log/useful.log'), 'a')
	logfile.sync  = true  #automatically flushes data to file
	CUSTOM_LOGGER = CustomLogger.new(logfile)  #constant accessible anywhere

end