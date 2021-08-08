require 'cgi'
require 'stringio'

require 'faraday'
require 'nokogiri'

module BanApi
  module Api
    class << self
      def search(term, number_of_results_per_page: 20, page: 1)
        raw_url = generate_url(base_url, 's', term, **{
          :'Nrpp' => 20,
          :page   => 1
        })
        puts raw_url
      end

      private

      def generate_url(*urls, **params)
        StringIO.new.tap do |s|
          final_url_index = urls.length - 1
          urls.each_with_index do |url, index|
            if index == 0
              s.print url
            elsif index < final_url_index
              s.print '/'
              s.print url
            else
              s.print '/'
              s.print CGI.escape(url)
            end
          end

          unless params.empty?
            s.print '?'
            params.each_with_index do |(name, value), index|
              s.print '&' unless index == 0
              s.print name
              s.print '='
              s.print CGI.escape(value.to_s)
            end
          end
        end.string
      end

      def base_url
        'https://www.barnesandnoble.com'
      end
    end
  end
end
