class VLCControl

  if system('pgrep vlc')
    logger.info "Found VLC, using existing."
  else
    logger.info "Starting new vlc instance..."
    IO.popen('vlc --intf telnet');
  end
  
  @@vlc=TCPSocket.new("127.0.0.1", 4212)
  @@vlc.puts "admin"
  @@vlc.puts "set prompt \"\""

  logger.info "Connected to VLC successfully"

  def initialize
  end

  
  def playlist_clear
    exec_cmd "clear"
  end

  def pause
    exec_cmd "pause"
  end
  
  def stop
    exec_cmd "stop"
  end
  
  def play
    exec_cmd "play"
  end
  
  # NB: Automatically starts playing.
  def playlist_add(source)
    exec_cmd "add #{source}"
  end
  
  # Volume goes from 0 to 512
  def set_volume(level)
    exec_cmd "volume #{level}"
  end

  def playing?
    flush_input(@@vlc)
    @@vlc.puts("is_playing")
    get_plain_response.chomp
  end
  
  def now_playing
    flush_input(@@vlc)
    @@vlc.puts "get_title"
    get_plain_response.chomp!
  end
  
  def flush_input(handle)
    # flush any input left in the buffer (non-blockingly, obviously)
    begin
      handle.read_nonblock(4096)
    rescue
    end
  end
  
  def get_plain_response
    # return a 'plain response' to a command, filtering out any status change messages.
    @@vlc.readpartial(4096).each_line do |line|
      return line if line !~ /status change/;
    end
    ""
  end
  
  def get_retval
    re_retval = /^\S+: returned (\d+)/;
    # capture any VLC output, then pick out the return value of the last command and discard anything else
    vlc_output = @@vlc.readpartial(4096);
    re_match = re_retval.match(vlc_output);
    if(re_match) then
      return re_match[1];
    end
  end
  
  def exec_cmd(cmd)
    flush_input(@@vlc)
    @@vlc.puts(cmd)
    # get_retval
  end
  
  def close
    @@vlc.close
    logger.info "Closed VLC telnet session";
    ""
  end
end

