require 'cgi'
require 'pathname'
require 'stringio'
require 'yaml'

require 'faraday'
require 'hashie'
require 'nokogiri'

# This is the 'entry-point' for the gem. We'll just require all our
# stuff right here.

module Kernel
  def ban_api_info(msg)
    puts "[\033[0;35mBAN_API_INFO\033[0;0m] - #{msg}"
  end
  def ban_api_warning(msg)
    puts "[\033[0;33mBAN_API_WARNING\033[0;0m] - #{msg}"
  end
end

# Main Module Declaration
module BanApi
  # TODO: Figure out how to change the store (mess around in browser for this).

  # TODO: Create product class.
end

pathname = Pathname.new(__FILE__)

# Api
require pathname.parent.join('ban_api', 'api').to_s

# Formats
require pathname.parent.join('ban_api', 'formats').to_s

# Objects
require pathname.parent.join('ban_api', 'objects').to_s
require pathname.parent.join('ban_api', 'objects', 'abstract').to_s
require pathname.parent.join('ban_api', 'objects', 'author').to_s
require pathname.parent.join('ban_api', 'objects', 'book').to_s

# Parsers
require pathname.parent.join('ban_api', 'parsers').to_s
require pathname.parent.join('ban_api', 'parsers', 'search').to_s

# Stubs
require pathname.parent.join('ban_api', 'stubs').to_s
