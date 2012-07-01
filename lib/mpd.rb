require "librmpd"
require 'curl'

def get_music(input)
  if input.match('http')
    return get_online_music(input)
  end
  return [input]
end

def get_online_music(url)
  ext = url.scan(/\.([A-z]+)$/).flatten[0]
  if ext.length == 0
    return []
  elsif ext == "pls"
    curl = CURL.new
    p = curl.get(url)
    return p.scan(/^File[0-9]*=(.*)\n/).flatten
  end
end

class MPDControl

  # Called to reconnect when mpd kicks us off for inactivity
  def disconnect_callback( connected )
      unless connected
        @@mpd.connect
      end
  end

  def initialize
    # Create connection object
    @@mpd = MPD.new 'localhost', 6600
    @@mpd.register_callback('disconnect_callback', 
                                    MPD::CONNECTION_CALLBACK)
    # Initialize connection to server with callbacks
    @@mpd.connect(true)
  end

  def pause
    exec.pause=true
  end

  def stop
    exec.stop
  end

  def play
    exec.play
  end

  def playlist_add(source)
    exec.clear
    get_music(source).each {|x| exec.add x }
    exec.play
  end

  def set_volume(level)
    exec.volume=level
  end

  def get_volume(level)
    exec.volume
  end

  def playing?
    exec.playing?
  end

  def now_playing
    current = mpd.current_song
    current.name unless current == nil
  end

  def exec
    if !@@mpd.connected?
      @@mpd.connect
    end
    @@mpd
  end
end
