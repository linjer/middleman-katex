module Middleman
  module Katex
    # Extension namespace
    class Katex < Middleman::Extension
      # option :my_option, 'default', 'An example option'
      option :katex_inline, false, 'Rendering equations in-line or as a block.'
      # option :render_at_build, true,
      #        'Option to control if equations are rendered during middleman build or during client loading'

      def initialize(app, options_hash={}, &block)
        # Call super to build options from the options_hash
        super

        # Require libraries only when activated
        # require 'necessary/library'
        require 'execjs'
        require 'middleman-katex/redcarpet_katex_renderer'

        # app.config[:autoload_sprockets] = true

        # set up your extension
        # puts options.my_option
        # root = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
        # app.precompile << /\.(?:svg|eot|woff|ttf)$/

        if app.config[:markdown_engine] == :redcarpet
          require 'middleman-core/renderers/redcarpet'
          Middleman::Renderers::MiddlemanRedcarpetHTML.send :include, RedcarpetKatexRenderer
        elsif app.config[:markdown_engine] == :kramdown
          require 'kramdown'
          Kramdown::Converter::Html.class_eval do
            def convert_codeblock(el, indent)
              attr     = el.attr.dup
              language = extract_code_language!(attr)
              # Middleman::Syntax::Highlighter.highlight(el.value, language)
            end
          end
        end
      end

      def after_configuration
        # Compile and setup katex
        # root_dir = __dir__ + "/../.."
        # katex_js_path = File.join(root_dir, 'vendor', 'assets', 'javascripts', 'katex', 'katex.js')
        katex_js_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'vendor', 'assets', 'javascripts', 'katex', 'katex.js'))
        raise "Cannot load path #{katex_js_path}" unless File.exists? katex_js_path
        app.config[:katex_js] = ExecJS.compile(File.read(katex_js_path))
      end

      # A Sitemap Manipulator
      # def manipulate_resource_list(resources)
      # end

      helpers do
        def katex(opts={}, &block)
          raise 'The katex math helper requires a block to be provided.' unless block_given?

          # instance_opts = {}.merge!(@rendering_defaults)
          # instance_opts[:displayMode] = opts[:inline] if opts.has_key? :inline
          instance_opts       = { displayMode: true, throwOnError: false }

          # Save current buffer for later
          @_out_buf, _buf_was = "", @_out_buf

          begin
            content = capture_html(&block)
          ensure
            # Reset stored buffer
            @_out_buf = _buf_was
          end

          content = content.encode(Encoding::UTF_8)
          concat_content app.config[:katex_js].call 'katex.renderToString', content, instance_opts
        end
      end
    end
  end
end
