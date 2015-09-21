# Require core library
require 'middleman-core'

# Extension namespace
class Katex < ::Middleman::Extension
  # option :my_option, 'default', 'An example option'
  option :render_at_build, true,
         'Option to control if equations are rendered during middleman build or during client loading'
  option :js_dir, nil, 'Specify location of js files which may be used for client side rendering'

  def initialize(app, options_hash={}, &block)
    # Call super to build options from the options_hash
    super

    # Require libraries only when activated
    # require 'necessary/library'

    # set up your extension
    # puts options.my_option
  end

  def after_configuration
    # Do something
  end

  # A Sitemap Manipulator
  # def manipulate_resource_list(resources)
  # end

  # helpers do
  #   def a_helper
  #   end
  # end
end

# Register extensions which can be activated
# Make sure we have the version of Middleman we expect
# Name param may be omited, it will default to underscored
# version of class name

MyExtension.register(:katex)
