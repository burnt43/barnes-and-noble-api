module BanApi
  module Stubs
    class << self
      def cached_stub_manifests
        @cached_stub_manifests || {}
      end

      def cached_stubs
        @cached_stubs || {}
      end

      def load_stub(type, name)
        # See if we can just find the stub in memory.
        possible_cached_stub = cached_stubs.dig(type.to_sym, name.to_sym)
        return possible_cached_stub if possible_cached_stub

        # Each type will have its own manifest file where you can define
        # stubs by name.
        manifest_pathname = Pathname.new('./test/assets/stubs').join(type.to_s, 'manifest.yaml')

        # If we can't find the manifest, then return.
        return nil unless manifest_pathname.exist?

        manifest =
          if cached_stub_manifests.key?(type.to_sym)
            # The manifest is cached, so just use what is in memory.
            cached_stub_manifests[type.to_sym]
          else
            # The manifest is not cached, so we must load it and parse it.
            YAML.load(IO.read(manifest_pathname)).tap do |parsed_yaml|
              @cached_stub_manifests ||= {}
              @cached_stub_manifests[type.to_sym] = parsed_yaml
            end
          end

        # Look up the attributes in the manifest for the stub with the given
        # name.
        stub_config = manifest.dig('manifest', name.to_s)

        unless stub_config
          ban_api_warning("Could not find stub '#{name}'")
          return
        end

        # Create a hash of attributes to create a Mash from.
        attributes_for_mash =
          case type.to_sym
          when :http_responses
            # If we are looking up http_responses, then we are returning an
            # object that behaves like a Faraday::Response. Since Barnes
            # and Noble at this time does not provide an API that would
            # return us some JSON, we are navigating their website
            # programatically. This means we are getting back a big old blob
            # of HTML. Since, I don't want to clutter up the stub manifest file
            # with big blobs of HTML, The body field is just the name of the
            # file in the 'body' directory. We need to load that file and replace
            # the body attribute with it.
            body_filename = stub_config['body']
            actual_body_pathname = manifest_pathname.parent.join('body', "#{body_filename}.html")

            if actual_body_pathname.exist?
              # Replace the body attribute with the contents of the file.
              stub_config.tap do |h|
                h['body'] = actual_body_pathname.read
              end
            else
              # We couldn't find the body file, so just remove the body
              # attribute altogether.
              stub_config.reject {|k,v| k == 'body'}
            end
          else
            stub_config
          end

        Hashie::Mash.new(attributes_for_mash).tap do |stub|
          # Cache the stub.
          @cached_stubs ||= {}
          @cached_stubs[type.to_sym] ||= {}
          @cached_stubs[type.to_sym][name.to_sym] = stub
        end
      end
    end
  end
end
