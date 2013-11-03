#!/usr/bin/env ruby
#
# 2010-07-09 -- jontow@zenbsd.net
# 2013-09-24 -- jontow@zenbsd.net
#
# Fetch an image every @interval seconds from a given camera, stored
# locally with timestamp.
#

if ARGV[2].nil?
        puts "Syntax: camfetch.rb <host|ipaddr> <filename> <interval-in-seconds>"
        puts "    ie: camfetch.rb 192.168.0.1 parkinglot1.jpg 60"
        exit
end

@hostname = ARGV[0]
@basename = ARGV[1]
@interval = ARGV[2]

counter = 0

loop do
        imgdir = Time.now.strftime("%Y-%m-%d")
        if !File.directory?(imgdir)
                Dir.mkdir(imgdir)
        end

        now = Time.now.strftime("%Y-%m-%d_%H:%M:%S")

        puts now
        cmd = "wget -q -O #{imgdir}/#{now}-#{@basename} http://#{@hostname}/jpg/image.jpg"
        #p cmd
        `#{cmd}`
        sleep @interval.to_i
end
